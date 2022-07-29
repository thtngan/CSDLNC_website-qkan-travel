USE qltour

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
SELECT c.city_name FROM CITY c GROUP  BY c.city_name
SELECT country_name FROM COUNTRY c GROUP BY c.country_name
SELECT * FROM TOUR t WHERE t.destination_id = 211 AND t.departure_id = 236 AND t.depart_date = '19700622'
