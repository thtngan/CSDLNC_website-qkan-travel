USE qltour_new

CREATE PROC sp_staff_add
	@name varchar(50),
	@gender bit,
	@dob date,
	@tele varchar(12),
	@email varchar(50),
	@address varchar(100),
	@type int,
	@manager int,
	@cccd char(12)
AS
BEGIN
	SET NOCOUNT ON;
    BEGIN TRAN
        BEGIN TRY
			INSERT INTO ACCOUNT (email, pass, roles) VALUES (@email, @cccd, 1)
			INSERT INTO STAFF(staff_name, gender, dob, tele, email, staff_address, staff_type_id, manager_id, id_no) VALUES (@name, @gender, @dob, @tele, @email, @address, @type, @manager, @cccd)
            COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
				-- if error, roll back any chanegs done by any of the sql statements
				ROLLBACK TRANSACTION
		END CATCH
END
GO

DROP PROC sp_order_add
CREATE PROC sp_order_add
	@cust_id int,
	@tour_id int,
	@quantity int,
	@note text,
	@payment_method char(4),	
	@hotel_service_id int,
	@transport_service_id int,
	@tour_price decimal(10,2)
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
			DECLARE @hotel_price decimal(10,2)
			INSERT [INVOICE] ([cust_id], [tour_id], [note], [payment_method], [price], [quantity]) VALUES (@cust_id, @tour_id, @note, @payment_method, @tour_price, @quantity)
			UPDATE TOUR SET cur_quantity = cur_quantity + @quantity WHERE TOUR.id = @tour_id
			IF EXISTS (SELECT * FROM [HOTEL_BOOKING] WHERE tour_id = @tour_id AND hotel_service_id = @hotel_service_id)
				BEGIN
					UPDATE [HOTEL_BOOKING] SET quantity = quantity + @quantity WHERE tour_id = @tour_id AND hotel_service_id = @hotel_service_id
				END
			ELSE
				BEGIN
					SELECT @hotel_price = service_price FROM HOTEL_SERVICE WHERE id = @hotel_service_id
					INSERT [dbo].[HOTEL_BOOKING] ([tour_id], [hotel_service_id], [quantity], [price]) VALUES (@tour_id, @hotel_service_id, @quantity, @hotel_price)
				END

			IF EXISTS (SELECT * FROM [TRANSPORT_BOOKING] WHERE tour_id = @tour_id AND transport_service_id = @transport_service_id)
				BEGIN
					UPDATE [dbo].[TRANSPORT_BOOKING] SET quantity = quantity + @quantity WHERE tour_id = @tour_id AND transport_service_id = @transport_service_id
				END
			ELSE
				BEGIN
					SELECT @hotel_price = service_price FROM TRANSPORT_SERVICE WHERE id = @transport_service_id
					INSERT [dbo].[TRANSPORT_BOOKING] ([tour_id], [transport_service_id], [quantity], [price]) VALUES (@tour_id,  @transport_service_id, @quantity, @hotel_price)
				END
			
			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
				-- if error, roll back any chanegs done by any of the sql statements
				DECLARE @ErrorNumber INT = ERROR_NUMBER();
				DECLARE @ErrorMessage NVARCHAR(1000) = ERROR_MESSAGE() 
				RAISERROR('Error Number-%d : Error Message-%s', 16, 1, @ErrorNumber, @ErrorMessage)
				IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION
		END CATCH
END
SELECT * FROM invoice
select * from tour
UPDATE TOUR SET cur_quantity = cur_quantity + 3 WHERE TOUR.id = 99983
EXEC sp_order_add @cust_id=1, @tour_id=99983, @quantity=2, @note=NULL, @payment_method='CASH', @hotel_service_id=472, @transport_service_id=1, @tour_price=371000.13
