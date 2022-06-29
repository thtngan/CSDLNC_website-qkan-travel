/*CREATE DATABASE qltour ON PRIMARY
( NAME = qltour_data, FILENAME = 'C:\CSDL\qltour_data.mdf', SIZE = 10, MAXSIZE = 1000, FILEGROWTH = 10)
LOG ON
( NAME = qltour_log, FILENAME = 'C:\CSDL\qltour_log.ldf', SIZE = 10, FILEGROWTH = 5)*/

USE qltour
GO
/*DROP TABLE ROSTER
DROP TABLE INVOICE_RECORD
DROP TABLE INVOICE_LINE
DROP TABLE TOUR_DETAIL
DROP TABLE INVOICE
DROP TABLE TIMESHEETS
DROP TABLE ITINERARY
DROP TABLE FEEDBACK
DROP TABLE VISA
DROP TABLE PASSPORT
DROP TABLE HOTEL_PRICE_RECORD
DROP TABLE TRANSPORT_PRICE_RECORD
DROP TABLE SHOPPING_CART
DROP TABLE HOTEL_BOOKING
DROP TABLE TRANSPORT_BOOKING
DROP TABLE HOTEL_SERVICE
DROP TABLE TRANSPORT_SERVICE
DROP TABLE ROOM_TYPE
DROP TABLE TICKET_TYPE
DROP TABLE CONTRACT_RECORD
DROP TABLE CONTRACTS
DROP TABLE PARTNERS
DROP TABLE PARTNER_TYPE
DROP TABLE STAFF
DROP TABLE STAFF_TYPE
DROP TABLE TOUR
DROP TABLE CUSTOMER
DROP TABLE ACCOUNT
DROP TABLE CITY
DROP TABLE COUNTRY
*/
GO
---------------------------------------------------
-- ACCOUNT
CREATE TABLE ACCOUNT
(
	email varchar(50) NOT NULL PRIMARY KEY,
	pass varchar(50) NOT NULL,
	roles tinyint NOT NULL,
	active bit not null default 1,
	CHECK(roles = 1 OR roles = 2 OR roles = 3)
)
---------------------------------------------------
-- CUSTOMER
CREATE TABLE CUSTOMER
(
	id int identity(1,1) not null primary key,
	cust_name varchar(50) not null,
	gender bit,
	dob date,
	nation_id int NOT NULL,
	tele varchar(12),
	email varchar(50) not null unique,
	cust_address varchar(100),
	membership varchar(7) DEFAULT 'NONE' not null,
	id_no char(12),
	CHECK(membership = 'NONE' OR membership = 'MEMBER' OR membership = 'SILVER' OR membership = 'GOLD' OR membership = 'DIAMOND')
)
---------------------------------------------------
-- PASSPORT
CREATE TABLE PASSPORT
(
	id char(8) not null primary key,
	cust_id int not null,
	passport_type varchar(5),
	country_id int,
	issue_date date not null,
	expiration_date date not null,
	issue_place varchar(50),
	active bit not null
)
---------------------------------------------------
-- VISA
CREATE TABLE VISA 
(
	id char(8) not null primary key,
	passport_id char(8) not null,
	country_id int,
	issue_date date not null,
	expiration_date date not null,
	type_class varchar(5),
	entries tinyint not null,
	active bit not null
)
---------------------------------------------------
-- STAFF
CREATE TABLE STAFF
(
	id int identity(1,1) not null primary key,
	staff_name varchar(50) not null,
	gender bit,
	dob date,
	tele varchar(12),
	email varchar(50) not null unique,
	staff_address varchar(100),
	staff_type_id int NOT NULL,
	id_no char(12) NOT NULL,
	manager_id int NOT NULL
)
---------------------------------------------------
-- STAFF_TYPE
CREATE TABLE STAFF_TYPE
(
	id int identity(1,1) not null primary key,
	staff_type_name varchar(50)
)
---------------------------------------------------
-- TIMESHEETS
CREATE TABLE TIMESHEETS
(
	staff_id int not null,
	presence_date date not null default GETDATE(),
	entry_time time not null default GETDATE(),
	out_time time,
	note text,
	primary key(staff_id, presence_date),
	check (out_time = null  or out_time > entry_time)
)
---------------------------------------------------
-- COUNTRY
CREATE TABLE COUNTRY
(
	id int identity(1,1) not null primary key,
	country_code char(3),
	country_name varchar(50) not null
)
---------------------------------------------------
-- CITY
CREATE TABLE CITY
(
	id int identity(1,1) not null primary key,
	city_name varchar(50) not null,
	country_id int not null
)
---------------------------------------------------
-- TOUR
CREATE TABLE TOUR 
(
	id int identity(1,1) not null primary key,
	tour_name varchar(50) not null,
	destination_id int not null,
	departure_id int not null,
	depart_date date not null,
	end_date date not null,
	price decimal(10,2),
	register_date date,
	max_quantity int,
	cur_quantity int not null default 0,
	img image,
	descriptions text,
	note text,
	check (end_date > depart_date and register_date <= depart_date and cur_quantity <= max_quantity)
)
---------------------------------------------------
-- TOUR_DETAIL
CREATE TABLE TOUR_DETAIL
(
	tour_id int not null,
	cust_id int not null,
	invoice_id int not null,
	note text,
	primary key (tour_id, cust_id)
)
---------------------------------------------------
-- ITINERARY
CREATE TABLE ITINERARY
(
	id int identity(1,1) not null primary key,
	tour_id int not null,
	visit_place varchar(50) not null,
	visit_time datetime not null,
	duration int not null,
	descriptions text,
	note text,
	fee_per_person decimal(10,2)
)
---------------------------------------------------
-- FEEDBACK
CREATE TABLE FEEDBACK
(
	tour_id int not null,
	cust_id int not null,
	rating tinyint not null,
	descriptions text,
	feedback_timestamp datetime not null default GETDATE(),
	primary key(tour_id, cust_id),
	CHECK (rating < 6 and rating > 0)
)
---------------------------------------------------
-- PARTNER_TYPE
CREATE TABLE PARTNER_TYPE
(
	id int identity(1,1) not null primary key,
	partner_type_name varchar(50)
)
---------------------------------------------------
-- PARTNERS
CREATE TABLE PARTNERS
(
	id int identity(1,1) not null primary key,
	partner_name varchar(50) not null,
	email varchar(50) not null unique,
	city_id int not null,
	partner_address varchar(50) not null,
	descriptions text,
	active bit not null default 0,
	partner_type_id int not null
)
---------------------------------------------------
-- ROOM_TYPE
CREATE TABLE ROOM_TYPE
(
	id int identity(1,1) not null primary key,
	room_type_name varchar(50)
)
---------------------------------------------------
-- TICKET_TYPE
CREATE TABLE TICKET_TYPE
(
	id int identity(1,1) not null primary key,
	ticket_type_name varchar(50)
)
---------------------------------------------------
-- HOTEL_SERVICE
CREATE TABLE HOTEL_SERVICE
(
	id int identity(1,1) not null primary key,
	partner_id int not null,
	room_type_id int not null,
	service_price decimal(10,2),
	active bit not null default 0
)
---------------------------------------------------
-- TRANSPORT_SERVICE
CREATE TABLE TRANSPORT_SERVICE
(
	id int identity(1,1) not null primary key,
	partner_id int not null,
	ticket_type_id int not null,
	from_city_id int not null,
	to_city_id int,
	service_price decimal(10,2),
	active bit not null default 0
)
---------------------------------------------------
-- HOTEL_PRICE_RECORD
CREATE TABLE HOTEL_PRICE_RECORD
(
	service_id int not null,
	active_date datetime,
	service_price decimal(10,2),
	primary key (service_id, active_date)
)
---------------------------------------------------
-- TRANSPORT_PRICE_RECORD
CREATE TABLE TRANSPORT_PRICE_RECORD
(
	service_id int not null,
	active_date datetime,
	service_price decimal(10,2),
	primary key (service_id, active_date)
)
---------------------------------------------------
-- CONTRACTS
CREATE TABLE CONTRACTS
(
	id int identity(1,1) not null primary key,
	partner_id int not null,
	staff_id int not null,
	active_date date not null,
	end_date date not null,
	contract_status tinyint not null default 0,
	commission float
)
---------------------------------------------------
-- CONTRACT_RECORD
CREATE TABLE CONTRACT_RECORD
(
	contract_id int not null,
	active_date date not null,
	end_date date not null,
	commission float not null,
	rec_timestamp datetime not null,
	operation char(3) not null,
	PRIMARY KEY (contract_id, rec_timestamp),
	CHECK (operation = 'INS' or operation = 'UPD' or operation = 'DEL')
)
---------------------------------------------------
-- HOTEL_BOOKING
CREATE TABLE HOTEL_BOOKING
(
	tour_id int not null,
	hotel_service_id int not null,
	quantity int,
	price decimal(10,2)
	primary key (tour_id, hotel_service_id),
	check (quantity > 0)
)
---------------------------------------------------
-- TRANSPORT_BOOKING
CREATE TABLE TRANSPORT_BOOKING
(
	tour_id int not null,
	transport_service_id int not null,
	quantity int,
	price decimal(10,2)
	primary key (tour_id, transport_service_id),
	check (quantity > 0)
)
---------------------------------------------------
-- INVOICE
CREATE TABLE INVOICE
(
	id int identity(1,1) not null primary key,
	cust_id int not null,
	order_date datetime not null default GETDATE(),
	note text,
	invoice_status tinyint not null default 0,
	refunded_amount decimal(10,2),
	payment_method char(4) not null default 'CASH',
	check(payment_method = 'CASH' or payment_method = 'CARD')
)
---------------------------------------------------
-- INVOICE_LINE
CREATE TABLE INVOICE_LINE
(
	tour_id int not null,
	invoice_id int not null,
	quantity int not null,
	price decimal(10,2),
	primary key (tour_id, invoice_id),
	check (quantity > 0)
)
---------------------------------------------------
-- INVOICE_RECORD
CREATE TABLE INVOICE_RECORD
(
	invoice_id int not null,
	rec_timestamp datetime not null default GETDATE(),
	invoice_status tinyint,
	operation char(3),
	primary key (invoice_id, rec_timestamp),
	CHECK (operation = 'INS' or operation = 'UPD' or operation = 'DEL')
)
---------------------------------------------------
-- SHOPPING_CART
CREATE TABLE SHOPPING_CART
(
	cust_id int not null,
	tour_id int not null,
	quantity int not null,
	CHECK (quantity > 0)
)
---------------------------------------------------
--	ROSTER
CREATE TABLE ROSTER
(
	staff_id int not null,
	tour_id int not null,
	assignment_date date not null,
	note text,
	primary key (staff_id, tour_id)
)
GO
---------------------------------------------------
-- Foreign key for table CUSTOMER
ALTER TABLE CUSTOMER ADD CONSTRAINT FK01_CUSTOMER FOREIGN KEY(email) REFERENCES ACCOUNT(email)
ALTER TABLE CUSTOMER ADD CONSTRAINT FK02_CUSTOMER FOREIGN KEY(nation_id) REFERENCES COUNTRY(id)

-- Foreign key for table STAFF
ALTER TABLE STAFF ADD CONSTRAINT FK01_STAFF FOREIGN KEY(email) REFERENCES ACCOUNT(email)
ALTER TABLE STAFF ADD CONSTRAINT FK02_STAFF FOREIGN KEY(staff_type_id) REFERENCES STAFF_TYPE(id)
ALTER TABLE STAFF ADD CONSTRAINT FK03_STAFF FOREIGN KEY(manager_id) REFERENCES STAFF(id)

-- Foreign key for table CITY
ALTER TABLE CITY ADD CONSTRAINT FK01_CITY FOREIGN KEY(country_id) REFERENCES COUNTRY(id)

-- Foreign key for table TOUR
ALTER TABLE TOUR ADD CONSTRAINT FK01_TOUR FOREIGN KEY(destination_id) REFERENCES CITY(id)
ALTER TABLE TOUR ADD CONSTRAINT FK02_TOUR FOREIGN KEY(departure_id) REFERENCES CITY(id)

-- Foreign key for table ITENERARY
ALTER TABLE ITINERARY ADD CONSTRAINT FK01_ITENERARY FOREIGN KEY(tour_id) REFERENCES TOUR(id)

-- Foreign key for table FEEDBACK
ALTER TABLE FEEDBACK ADD CONSTRAINT FK01_FEEDBACK FOREIGN KEY(tour_id) REFERENCES TOUR(id)
ALTER TABLE FEEDBACK ADD CONSTRAINT FK02_FEEDBACK FOREIGN KEY(cust_id) REFERENCES CUSTOMER(id)

-- Foreign key for table TIMESHEETS
ALTER TABLE TIMESHEETS ADD CONSTRAINT FK01_TIMESHEETS FOREIGN KEY(staff_id) REFERENCES STAFF(id)

-- Foreign key for table ROSTER
ALTER TABLE ROSTER ADD CONSTRAINT FK01_ROSTER FOREIGN KEY(staff_id) REFERENCES STAFF(id)
ALTER TABLE ROSTER ADD CONSTRAINT FK02_ROSTER FOREIGN KEY(tour_id) REFERENCES TOUR(id)

-- Foreign key for table INVOICE
ALTER TABLE INVOICE ADD CONSTRAINT FK01_invoice FOREIGN KEY(cust_id) REFERENCES CUSTOMER(id)

-- Foreign key for table INVOICE_LINE
ALTER TABLE INVOICE_LINE ADD CONSTRAINT FK01_INVOICE_LINE FOREIGN KEY(tour_id) REFERENCES TOUR(id)
ALTER TABLE INVOICE_LINE ADD CONSTRAINT FK02_INVOICE_LINE FOREIGN KEY(invoice_id) REFERENCES INVOICE(id)

-- Foreign key for table INVOICE_RECORD
ALTER TABLE INVOICE_RECORD ADD CONSTRAINT FK01_INVOICE_RECORD FOREIGN KEY(invoice_id) REFERENCES INVOICE(id)

-- Foreign key for table SHOPPING_CART
ALTER TABLE SHOPPING_CART ADD CONSTRAINT FK01_SHOPPING_CART FOREIGN KEY(cust_id) REFERENCES CUSTOMER(id)
ALTER TABLE SHOPPING_CART ADD CONSTRAINT FK02_SHOPPING_CART FOREIGN KEY(tour_id) REFERENCES TOUR(id)

-- Foreign key for table PARTNERS
ALTER TABLE PARTNERS ADD CONSTRAINT FK01_PARTNERS FOREIGN KEY(city_id) REFERENCES CITY(id)
ALTER TABLE PARTNERS ADD CONSTRAINT FK02_PARTNERS FOREIGN KEY(partner_type_id) REFERENCES PARTNER_TYPE(id)
ALTER TABLE PARTNERS ADD CONSTRAINT FK03_PARTNERS FOREIGN KEY(email) REFERENCES ACCOUNT(email)

-- Foreign key for table HOTEL_SERVICE
ALTER TABLE HOTEL_SERVICE ADD CONSTRAINT FK01_HOTEL_SERVICE FOREIGN KEY(partner_id) REFERENCES PARTNERS(id)
ALTER TABLE HOTEL_SERVICE ADD CONSTRAINT FK02_HOTEL_SERVICE FOREIGN KEY(room_type_id) REFERENCES ROOM_TYPE(id)

-- Foreign key for table TRANSPORT_SERVICE
ALTER TABLE TRANSPORT_SERVICE ADD CONSTRAINT FK01_TRANSPORT_SERVICE FOREIGN KEY(partner_id) REFERENCES PARTNERS(id)
ALTER TABLE TRANSPORT_SERVICE ADD CONSTRAINT FK02_TRANSPORT_SERVICE FOREIGN KEY(ticket_type_id) REFERENCES TICKET_TYPE(id)
ALTER TABLE TRANSPORT_SERVICE ADD CONSTRAINT FK03_TRANSPORT_SERVICE FOREIGN KEY(from_city_id) REFERENCES CITY(id)
ALTER TABLE TRANSPORT_SERVICE ADD CONSTRAINT FK04_TRANSPORT_SERVICE FOREIGN KEY(to_city_id) REFERENCES CITY(id)

-- Foreign key for table HOTEL_PRICE_RECORD
ALTER TABLE HOTEL_PRICE_RECORD ADD CONSTRAINT FK01_HOTEL_PRICE_RECORD FOREIGN KEY(service_id) REFERENCES HOTEL_SERVICE(id)

-- Foreign key for table TRANSPORT_PRICE_RECORD
ALTER TABLE TRANSPORT_PRICE_RECORD ADD CONSTRAINT FK01_TRANSPORT_PRICE_RECORD FOREIGN KEY(service_id) REFERENCES TRANSPORT_SERVICE(id)


-- Foreign key for table CONTRACTS
ALTER TABLE CONTRACTS ADD CONSTRAINT FK01_CONTRACTS FOREIGN KEY(partner_id) REFERENCES PARTNERS(id)
ALTER TABLE CONTRACTS ADD CONSTRAINT FK02_CONTRACTS FOREIGN KEY(staff_id) REFERENCES STAFF(id)

-- Foreign key for table CONTRACT_RECORD
ALTER TABLE CONTRACT_RECORD ADD CONSTRAINT FK01_CONTRACT_RECORD FOREIGN KEY(contract_id) REFERENCES CONTRACTS(id)

-- Foreign key for table HOTEL_BOOKING
ALTER TABLE HOTEL_BOOKING ADD CONSTRAINT FK01_HOTEL_BOOKING FOREIGN KEY(tour_id) REFERENCES TOUR(id)
ALTER TABLE HOTEL_BOOKING ADD CONSTRAINT FK02_HOTEL_BOOKING FOREIGN KEY(hotel_service_id) REFERENCES HOTEL_SERVICE(id)

-- Foreign key for table TRANSPORT_BOOKING
ALTER TABLE TRANSPORT_BOOKING ADD CONSTRAINT FK01_TRANSPORT_BOOKING FOREIGN KEY(tour_id) REFERENCES TOUR(id)
ALTER TABLE TRANSPORT_BOOKING ADD CONSTRAINT FK02_TRANSPORT_BOOKING FOREIGN KEY(transport_service_id) REFERENCES TRANSPORT_SERVICE(id)

-- Foreign key for table TOUR_DETAIL
ALTER TABLE TOUR_DETAIL ADD CONSTRAINT FK01_TOUR_DETAIL FOREIGN KEY(tour_id) REFERENCES TOUR(id)
ALTER TABLE TOUR_DETAIL ADD CONSTRAINT FK02_TOUR_DETAIL FOREIGN KEY(cust_id) REFERENCES CUSTOMER(id)
ALTER TABLE TOUR_DETAIL ADD CONSTRAINT FK03_TOUR_DETAIL FOREIGN KEY(invoice_id) REFERENCES INVOICE(id)

-- Foreign key for table PASSPORT
ALTER TABLE PASSPORT ADD CONSTRAINT FK01_PASSPORT FOREIGN KEY(cust_id) REFERENCES CUSTOMER(id)
ALTER TABLE PASSPORT ADD CONSTRAINT FK02_PASSPORT FOREIGN KEY(country_id) REFERENCES COUNTRY(id)

-- Foreign key for table VISA
ALTER TABLE VISA ADD CONSTRAINT FK01_VISA FOREIGN KEY(passport_id) REFERENCES PASSPORT(id)
ALTER TABLE VISA ADD CONSTRAINT FK02_VISA FOREIGN KEY(country_id) REFERENCES COUNTRY(id)
GO
---------------------------------------------------
---------------------------------------------------
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
ON TRANSPORT_SERVICE 
AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO PRICE_RECORD(
		service_id,
		partner_type_id,
		active_date,
		service_price
	)
	SELECT ins.id, (SELECT P.partner_type_id FROM TRANSPORT_SERVICE TS JOIN PARTNERS P ON TS.partner_id = P.id WHERE TS.id = ins.id), GETDATE(), ins.service_price
	FROM inserted ins
END
GO
---------------------------------------------------
CREATE TRIGGER tr_transport_price_record
ON HOTEL_SERVICE 
AFTER INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO PRICE_RECORD(
		service_id,
		partner_type_id,
		active_date,
		service_price
	)
	SELECT ins.id, (SELECT P.partner_type_id FROM TRANSPORT_SERVICE TS JOIN PARTNERS P ON TS.partner_id = P.id WHERE TS.id = ins.id), GETDATE(), ins.service_price
	FROM inserted ins
END
GO
---------------------------------------------------
---------------------------------------------------
-- LICH SU TRUY VET HOA DON
CREATE TRIGGER tr_invoice_record
ON INVOICE 
AFTER INSERT
AS
	DECLARE @operation varchar(6), @new_status tinyint, @old_status tinyint
	IF NOT EXISTS (SELECT * FROM deleted)
	BEGIN
		SET NOCOUNT ON;
		INSERT INTO INVOICE_RECORD(
			invoice_id,
			rec_timestamp,
			operation
		)
		SELECT ins.id, GETDATE(), 'CREATE'
		FROM inserted ins
	END
	ELSE
	BEGIN
		SELECT @new_status = invoice_status FROM inserted
		SELECT @old_status = invoice_status FROM deleted
		IF @new_status <> @old_status
		BEGIN
			IF @new_status = 1
				SET @operation = 'PAID'
			IF @new_status = 2
				SET @operation = 'CANCEL'
			IF @new_status = 3
				SET @operation = 'REFUND'
			SET NOCOUNT ON;
			INSERT INTO INVOICE_RECORD(
				invoice_id,
				rec_timestamp,
				operation
			)
			SELECT ins.id, GETDATE(), @operation
			FROM inserted ins
		END
	END
GO
---------------------------------------------------
---------------------------------------------------
-- CAP NHAT SO LUONG SLOT CUA TOUR
CREATE TRIGGER tr_invoice_detail_ins
ON INVOICE_LINE
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	UPDATE TOUR SET cur_quantity = cur_quantity  - (
		SELECT quantity FROM inserted WHERE tour_id = TOUR.id) +
		(SELECT quantity FROM deleted WHERE tour_id = TOUR.id
	)FROM TOUR JOIN deleted del ON TOUR.id = del.tour_id		
END
GO
---------------------------------------------------
---------------------------------------------------
-- CAP NHAT KHACH HANG THAN THIET
ALTER TABLE INVOICE ADD total decimal(10,2)
GO
CREATE TRIGGER tr_menbership
ON INVOICE
AFTER INSERT, DELETE
AS
DECLARE @cust_id int, @promo decimal(10,2)
BEGIN
	SELECT @cust_id = del.cust_id FROM inserted ins join deleted del on ins.id = del.id 

	SELECT @promo = SUM(total) FROM INVOICE WHERE cust_id = @cust_id
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
-- RANG BUOC TOUR_DETAIL
/*CREATE TRIGGER tr_tour_detail
ON TOUR_DETAIL
AFTER INSERT
AS
DECLARE @count int, @max int, @dob date
BEGIN
	SELECT @count = COUNT(*) FROM TOUR_DETAIL 
	SELECT @max = max_quantity FROM TOUR
	IF @count >= @max
		BEGIN 
			RAISERROR ('Out of bound',16,1)
			ROLLBACK
			RETURN;
		END
	ELSE 
		SELECT @dob = dob FROM CUSTOMER C JOIN inserted INS ON C.id = INS.cust_id
		IF D
END
GO*/

---------------------------------------------------
---------------------------------------------------
-- CAP NHAT THEM COT TONG TIEN
DECLARE @id int, @total decimal(10,2)
DECLARE cur_INVOICE CURSOR
FORWARD_ONLY
FOR
	SELECT id FROM INVOICE
OPEN cur_INVOICE
FETCH NEXT FROM cur_INVOICE INTO @id
WHILE @@FETCH_STATUS = 0
BEGIN
	SELECT @total = SUM(price*quantity)
	FROM INVOICE_LINE
	WHERE invoice_id = @id

	PRINT 'Updating ' + @id
	UPDATE INVOICE
	SET total = @total
	WHERE id = @id 

	FETCH NEXT FROM cur_INVOICE INTO @id
END
CLOSE cur_INVOICE
DEALLOCATE cur_INVOICE
---------------------------------------------------
---------------------------------------------------
-- TINH THU CHI
/*CREATE VIEW_REVENUE_EXPENDITURE
AS
SELECT id, tour_name, price*cur_quantity as total, (select fee_per_person from ITINERARY where tour_id = TOUR.id)*cur_quantity + 
FROM TOUR 
WHERE end_date <= GETDATE()*/

---------------------------------------------------
---------------------------------------------------
set dateformat dmy