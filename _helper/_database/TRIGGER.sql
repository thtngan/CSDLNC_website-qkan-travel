USE qltour
-- LICH SU GIA HAN HOP DONG
CREATE TRIGGER tr_contract_record_ins_del
ON CONTRACTS
AFTER INSERT, DELETE
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO CONTRACT_RECORD(
		contract_id,
		active_date,
		end_date,
		commission,
		rec_timestamp,
		operation
	)
	SELECT ins.id, ins.active_date, ins.end_date, ins.commission, GETDATE(), 'INS'
	FROM inserted ins
	UNION ALL
	SELECT del.id, del.active_date, del.end_date, del.commission, GETDATE(), 'DEL'
	FROM deleted del
END
GO
---------------------------------------------------
CREATE TRIGGER tr_RenewalRec_upd
ON CONTRACTS
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO CONTRACT_RECORD(
		contract_id,
		active_date,
		end_date,
		commission,
		rec_timestamp,
		operation
	)
	SELECT ins.id, ins.active_date, ins.end_date, ins.commission, GETDATE(), 'UPD'
	FROM inserted ins
END
GO
---------------------------------------------------
---------------------------------------------------
-- LICH SU CAP NHAT GIA DICH VU
CREATE TRIGGER tr_hotel_price_record
ON HOTEL_SERVICE
AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO HOTEL_PRICE_RECORD(
		service_id,
		active_date,
		service_price
	)
	SELECT ins.id, GETDATE(), ins.service_price
	FROM inserted ins
END
GO
---------------------------------------------------
CREATE TRIGGER tr_transport_price_record
ON TRANSPORT_SERVICE
AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO TRANSPORT_PRICE_RECORD(
		service_id,
		active_date,
		service_price
	)
	SELECT ins.id, GETDATE(), ins.service_price
	FROM inserted ins
END
GO
---------------------------------------------------
---------------------------------------------------
-- LICH SU TRUY VET HOA DON
CREATE TRIGGER tr_invoice_record
ON INVOICE 
AFTER INSERT, UPDATE
AS
	DECLARE @reg date, @id int, @tour decimal(10,2)
	IF NOT EXISTS (SELECT * FROM deleted)
	BEGIN
		SELECT @id = inserted.id ,@reg =  TOUR.register_date, @tour = TOUR.price FROM TOUR JOIN inserted ON TOUR.id = inserted.tour_id
		IF DATEDIFF(DD, GETDATE(), @reg) < 0
		BEGIN
			UPDATE INVOICE SET price = CAST(@tour*1.05 AS decimal(10,2)) WHERE id = @id
		END
		UPDATE INVOICE SET price = @tour WHERE id = @id
		SET NOCOUNT ON;
		INSERT INTO INVOICE_RECORD(
			invoice_id,
			rec_timestamp,
			invoice_status,
			operation
		)
		SELECT ins.id, GETDATE(), ins.invoice_status, 'INS'
		FROM inserted ins
	END
	ELSE
	BEGIN
		SET NOCOUNT ON;
		INSERT INTO INVOICE_RECORD(
			invoice_id,
			rec_timestamp,
			invoice_status,
			operation
		)
		SELECT ins.id, GETDATE(), ins.invoice_status,'UPD'
		FROM inserted ins
	END
GO
CREATE TRIGGER tr_invoice_record_del
ON INVOICE 
INSTEAD OF DELETE
AS
BEGIN
	UPDATE INVOICE SET invoice_status = 'CANCELLING' FROM INVOICE JOIN deleted ON INVOICE.id = deleted.id
	SET NOCOUNT ON;
	INSERT INTO INVOICE_RECORD(
		invoice_id,
		rec_timestamp,
		invoice_status,
		operation
	)
	SELECT del.id, GETDATE(), 4,'DEL'
	FROM deleted del
END
GO
---------------------------------------------------
---------------------------------------------------
-- CAP NHAT KHACH HANG THAN THIET
CREATE TRIGGER tr_membership
ON INVOICE
AFTER INSERT, DELETE
AS
DECLARE @cust_id int, @promo decimal(10,2)
BEGIN
	SELECT @cust_id = del.cust_id FROM inserted ins join deleted del on ins.id = del.id 

	SELECT @promo = SUM(price*quantity) FROM INVOICE WHERE cust_id = @cust_id
	IF @promo > 100000000
		UPDATE CUSTOMER SET membership = 'DIAMOND' WHERE id = @cust_id
	ELSE IF @promo > 50000000
		UPDATE CUSTOMER SET membership = 'GOLD' WHERE id = @cust_id
	ELSE IF @promo > 30000000
		UPDATE CUSTOMER SET membership = 'SILVER' WHERE id = @cust_id
	ELSE IF @promo > 10000000
		UPDATE CUSTOMER SET membership = 'MEMBER' WHERE id = @cust_id
END
GO
---------------------------------------------------
---------------------------------------------------
set dateformat MDY
GO
