/*CREATE DATABASE qltour ON PRIMARY
( NAME = qltour_data, FILENAME = 'C:\CSDL\qltour_data.mdf', SIZE = 10, MAXSIZE = UNLIMITED, FILEGROWTH = 10)
LOG ON
( NAME = qltour_log, FILENAME = 'C:\CSDL\qltour_log.ldf', SIZE = 10, FILEGROWTH = 5)*/
USE qltour_NEW
GO
/*
DROP TABLE ROSTER
DROP TABLE INVOICE_RECORD
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
DROP VIEW v_incoming_spending
DROP VIEW v_revenue_1year
*/
GO
---------------------------------------------------
-- ACCOUNT
CREATE TABLE ACCOUNT
(
	email varchar(50) NOT NULL PRIMARY KEY,
	pass varchar(50) NOT NULL,
	roles tinyint NOT NULL,
	active bit not null
)
---------------------------------------------------
-- CUSTOMER
CREATE TABLE CUSTOMER
(
	id int identity(1,1) not null primary key,
	cust_name varchar(50) not null,
	gender BIT NOT NULL,
	dob DATE NOT null,
	nation_id int NOT NULL,
	tele varchar(12),
	email varchar(50),
	cust_address varchar(100) NOT NULL,
	membership varchar(7) not null,
	id_no char(12),
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
	country_id INT NOT NULL,
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
	gender BIT NOT NULL,
	dob DATE NOT NULL,
	tele varchar(12) NOT null,
	email varchar(50) not null,
	staff_address varchar(100) NOT null,
	staff_type_id int NOT NULL,
	id_no char(12) NOT NULL,
	manager_id int
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
	staff_id int NOT NULL,
	presence_date date NOT NULL,
	entry_time time NOT NULL,
	out_time time,
	note text,
	primary key(staff_id, presence_date),
)
---------------------------------------------------
-- COUNTRY
CREATE TABLE COUNTRY
(
	id int identity(1,1) NOT NULL primary key,
	country_code char(3),
	country_name varchar(50) NOT NULL
)
---------------------------------------------------
-- CITY
CREATE TABLE CITY
(
	id int identity(1,1) NOT NULL primary key,
	city_name varchar(50) NOT NULL,
	country_id int NOT NULL
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
	max_quantity int not null,
	cur_quantity int not null,
	img image,
	descriptions text,
	note text,
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
	tour_id int NOT NULL,
	cust_id int NOT NULL,
	rating tinyint NOT NULL,
	descriptions text,
	feedback_timestamp datetime NOT NULL,
	primary key(tour_id, cust_id),
)
---------------------------------------------------
-- PARTNER_TYPE
CREATE TABLE PARTNER_TYPE
(
	id int identity(1,1) NOT NULL primary key,
	partner_type_name varchar(50)
)
---------------------------------------------------
-- PARTNERS
CREATE TABLE PARTNERS
(
	id int identity(1,1) not null primary key,
	partner_name varchar(50) not null,
	email varchar(50) not null,
	city_id int not null,
	partner_address varchar(50) not null,
	descriptions text,
	active bit not null,
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
	active bit not null
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
	active bit not null
)
---------------------------------------------------
-- HOTEL_PRICE_RECORD
CREATE TABLE HOTEL_PRICE_RECORD
(
	service_id int not null,
	active_date DATETIME NOT NULL,
	service_price decimal(10,2),
	primary key (service_id, active_date)
)
---------------------------------------------------
-- TRANSPORT_PRICE_RECORD
CREATE TABLE TRANSPORT_PRICE_RECORD
(
	service_id int not null,
	active_date DATETIME NOT NULL,
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
	contract_status varchar(8) not null,
	commission float NOT NULL
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
)
---------------------------------------------------
-- INVOICE
CREATE TABLE INVOICE
(
	id int identity(1,1) not null primary key,
	cust_id int not null,
	tour_id int not null,
	order_date datetime not null,
	note text,
	invoice_status varchar(10),
	refunded_amount decimal(10,2),
	payment_method char(4) not null,
	price decimal(10,2),
	quantity int not null
)
---------------------------------------------------
-- INVOICE_RECORD
CREATE TABLE INVOICE_RECORD
(
	invoice_id int not null,
	rec_timestamp datetime not null,
	invoice_status varchar(10),
	operation char(3),
	primary key (invoice_id, rec_timestamp),
)
---------------------------------------------------
-- SHOPPING_CART
CREATE TABLE SHOPPING_CART
(
	cust_id int not null,
	tour_id int not null,
	quantity int not null
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
ALTER TABLE STAFF ADD CONSTRAINT FK01_STAFF FOREIGN KEY(email) REFERENCES ACCOUNT(email) ON DELETE CASCADE
ALTER TABLE STAFF ADD CONSTRAINT FK02_STAFF FOREIGN KEY(staff_type_id) REFERENCES STAFF_TYPE(id)
ALTER TABLE STAFF ADD CONSTRAINT FK03_STAFF FOREIGN KEY(manager_id) REFERENCES STAFF(id)

-- Foreign key for table CITY
ALTER TABLE CITY ADD CONSTRAINT FK01_CITY FOREIGN KEY(country_id) REFERENCES COUNTRY(id)

-- Foreign key for table TOUR
ALTER TABLE TOUR ADD CONSTRAINT FK01_TOUR FOREIGN KEY(destination_id) REFERENCES CITY(id)
ALTER TABLE TOUR ADD CONSTRAINT FK02_TOUR FOREIGN KEY(departure_id) REFERENCES CITY(id)

-- Foreign key for table ITENERARY
ALTER TABLE ITINERARY ADD CONSTRAINT FK01_ITENERARY FOREIGN KEY(tour_id) REFERENCES TOUR(id) ON DELETE CASCADE

-- Foreign key for table FEEDBACK
ALTER TABLE FEEDBACK ADD CONSTRAINT FK01_FEEDBACK FOREIGN KEY(tour_id) REFERENCES TOUR(id)
ALTER TABLE FEEDBACK ADD CONSTRAINT FK02_FEEDBACK FOREIGN KEY(cust_id) REFERENCES CUSTOMER(id)

-- Foreign key for table TIMESHEETS
ALTER TABLE TIMESHEETS ADD CONSTRAINT FK01_TIMESHEETS FOREIGN KEY(staff_id) REFERENCES STAFF(id) ON DELETE CASCADE

-- Foreign key for table ROSTER
ALTER TABLE ROSTER ADD CONSTRAINT FK01_ROSTER FOREIGN KEY(staff_id) REFERENCES STAFF(id) ON DELETE CASCADE
ALTER TABLE ROSTER ADD CONSTRAINT FK02_ROSTER FOREIGN KEY(tour_id) REFERENCES TOUR(id) ON DELETE CASCADE

-- Foreign key for table INVOICE
ALTER TABLE INVOICE ADD CONSTRAINT FK01_INVOICE FOREIGN KEY(cust_id) REFERENCES CUSTOMER(id)
ALTER TABLE INVOICE ADD CONSTRAINT FK02_INVOICE FOREIGN KEY (tour_id) REFERENCES TOUR(id)

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

-- Foreign key for table PASSPORT
ALTER TABLE PASSPORT ADD CONSTRAINT FK01_PASSPORT FOREIGN KEY(cust_id) REFERENCES CUSTOMER(id)
ALTER TABLE PASSPORT ADD CONSTRAINT FK02_PASSPORT FOREIGN KEY(country_id) REFERENCES COUNTRY(id)

-- Foreign key for table VISA
ALTER TABLE VISA ADD CONSTRAINT FK01_VISA FOREIGN KEY(passport_id) REFERENCES PASSPORT(id)
ALTER TABLE VISA ADD CONSTRAINT FK02_VISA FOREIGN KEY(country_id) REFERENCES COUNTRY(id)
GO
---------------------------------------------------
---------------------------------------------------
--Check Constraint for table ACCOUNT
ALTER TABLE ACCOUNT ADD CONSTRAINT CK01_ACCOUNT CHECK(roles BETWEEN 0 AND 3)

--Check Constraint for table CUSTOMER
ALTER TABLE CUSTOMER ADD CONSTRAINT CK01_CUSTOMER CHECK(membership IN ('NONE','MEMBER','SILVER','GOLD','DIAMOND'))
ALTER TABLE CUSTOMER ADD CONSTRAINT CK02_CUSTOMER CHECK(DATEDIFF(YEAR,dob,GETDATE()) > 2)

--Check Constraint for table TIMESHEETS
ALTER TABLE TIMESHEETS ADD CONSTRAINT CK01_TIMESHEETS CHECK(out_time = NULL or out_time > entry_time)

--Check Constraint for table TOUR
ALTER TABLE TOUR ADD CONSTRAINT CK01_TOUR CHECK(DATEDIFF(DAY, depart_date, end_date) > 0 AND DATEDIFF(DAY,register_date,depart_date) >= 0)
ALTER TABLE TOUR ADD CONSTRAINT CK02_TOUR CHECK(cur_quantity >= 0)
ALTER TABLE TOUR ADD CONSTRAINT CK03_TOUR CHECK(max_quantity > 0)
ALTER TABLE TOUR ADD CONSTRAINT CK04_TOUR CHECK(cur_quantity <= max_quantity)
	
--Check Constraint for table FEEDBACK
ALTER TABLE FEEDBACK ADD CONSTRAINT CK01_FEEDBACK CHECK (rating BETWEEN 1 AND 5)

--Check Constraint for table CONTRACTS
ALTER TABLE CONTRACTS ADD CONSTRAINT CK01_CONTRACTS CHECK (contract_status IN ('PENDING', 'APPROVED', 'RUNNING', 'EXPIRED', 'CANCELED'))

--Check Constraint for table CONTRACT_RECORD
ALTER TABLE CONTRACT_RECORD ADD CONSTRAINT CK01_CONTRACT_RECORD CHECK (operation IN ('INS', 'UPD', 'DEL'))

--Check Constraint for table HOTEL_BOOKING
ALTER TABLE HOTEL_BOOKING ADD CONSTRAINT CK01_HOTEL_BOOKING CHECK (quantity > 0)

--Check Constraint for table TRANSPORT_BOOKING
ALTER TABLE TRANSPORT_BOOKING ADD CONSTRAINT CK01_TRANSPORT_BOOKING CHECK (quantity > 0)

--Check Constraint for table INVOICE
ALTER TABLE INVOICE ADD CONSTRAINT CK01_INVOICE CHECK(payment_method IN ('CASH', 'CARD'))
ALTER TABLE INVOICE ADD CONSTRAINT CK02_INVOICE CHECK(invoice_status IN ('PENDING', 'APPROVED', 'PAID', 'CANCELLING', 'CANCELED'))
ALTER TABLE INVOICE ADD CONSTRAINT CK03_INVOICE CHECK(quantity > 0)	

--Check Constraint for table SHOPPING_CART
ALTER TABLE SHOPPING_CART ADD CONSTRAINT CK01_SHOPPING_CART CHECK(quantity > 0)	

--Check Constraint for table INVOICE_RECORD
ALTER TABLE INVOICE_RECORD ADD CONSTRAINT CK01_INVOICE_RECORD CHECK (operation IN ('INS', 'UPD', 'DEL'))
ALTER TABLE INVOICE_RECORD ADD CONSTRAINT CK02_INVOICE_RECORD	CHECK (invoice_status IN ('PENDING', 'APPROVED', 'PAID', 'CANCELLING', 'CANCELED'))
---------------------------------------------------
---------------------------------------------------
--Default Constraint for table ACCOUNT
ALTER TABLE ACCOUNT ADD CONSTRAINT DF01_ACCOUNT DEFAULT(1) FOR active

--Default Constraint for table CUSTOMER
ALTER TABLE CUSTOMER ADD CONSTRAINT DF01_CUSTOMER DEFAULT('NONE') FOR membership

--Default Constraint for table TIMESHEETS
ALTER TABLE TIMESHEETS ADD CONSTRAINT DF01_TIMESHEETS DEFAULT(GETDATE()) FOR presence_date
ALTER TABLE TIMESHEETS ADD CONSTRAINT DF02_TIMESHEETS DEFAULT(GETDATE()) FOR entry_time

--Default Constraint for table TOUR
ALTER TABLE TOUR ADD CONSTRAINT DF01_TOUR DEFAULT(0) FOR cur_quantity

--Default Constraint for table FEEDBACK
ALTER TABLE FEEDBACK ADD CONSTRAINT DF01_FEEDBACK DEFAULT(GETDATE()) FOR feedback_timestamp

--Default Constraint for table CONTRACTS
ALTER TABLE CONTRACTS ADD CONSTRAINT DF01_CONTRACTS DEFAULT('PENDING') FOR contract_status

--Default Constraint for table INVOICE
ALTER TABLE INVOICE ADD CONSTRAINT DF01_INVOICE DEFAULT(GETDATE()) FOR order_date
ALTER TABLE INVOICE ADD CONSTRAINT DF02_INVOICE DEFAULT('PENDING') FOR invoice_status
ALTER TABLE INVOICE ADD CONSTRAINT DF03_INVOICE DEFAULT('CASH') FOR payment_method

---------------------------------------------------
---------------------------------------------------
-- Unique constraint for table CUSTOMER
ALTER TABLE CUSTOMER ADD CONSTRAINT UQ01_CUSTOMER UNIQUE (email); 
ALTER TABLE CUSTOMER ADD CONSTRAINT UQ02_CUSTOMER UNIQUE (id_no); 

-- Unique constraint for table STAFF
ALTER TABLE STAFF ADD CONSTRAINT UQ01_STAFF UNIQUE (email); 
ALTER TABLE STAFF ADD CONSTRAINT UQ02_STAFF UNIQUE (id_no);

-- Unique constraint for table STAFF_TYPE
ALTER TABLE STAFF_TYPE ADD CONSTRAINT UQ01_STAFF_TYPE UNIQUE (staff_type_name); 

-- Unique constraint for table COUNTRY
ALTER TABLE COUNTRY ADD CONSTRAINT UQ01_COUNTRY UNIQUE (country_code, country_name); 

-- Unique constraint for table CITY
ALTER TABLE CITY ADD CONSTRAINT UQ01_CITY UNIQUE (city_name, country_id); 

-- Unique constraint for table PARTNER_TYPE
ALTER TABLE PARTNER_TYPE ADD CONSTRAINT UQ01_PARTNER_TYPE UNIQUE (partner_type_name); 

-- Unique constraint for table PARTNERS
ALTER TABLE PARTNERS ADD CONSTRAINT UQ01_PARTNERS UNIQUE (email); 

-- Unique constraint for table ROOM_TYPE
ALTER TABLE ROOM_TYPE ADD CONSTRAINT UQ01_ROOM_TYPE UNIQUE (room_type_name); 

-- Unique constraint for table TICKET_TYPE
ALTER TABLE TICKET_TYPE ADD CONSTRAINT UQ01_TICKET_TYPE UNIQUE (ticket_type_name); 

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
-- DROP VIEW v_incoming_spending
CREATE VIEW v_incoming_spending (
	tour_id,
	tour_name,
	incoming,
	spending
) AS
	SELECT 
		TOUR.id,
		TOUR.tour_name,
		SUM(TOUR.price * TOUR.cur_quantity) incoming,
		SUM(HOTEL_BOOKING.price*HOTEL_BOOKING.quantity + TRANSPORT_BOOKING.price*TRANSPORT_BOOKING.quantity + TOUR.cur_quantity*ITINERARY.fee_per_person) spending
	FROM
		TOUR 
	JOIN HOTEL_BOOKING
		ON TOUR.id = HOTEL_BOOKING.tour_id
	JOIN TRANSPORT_BOOKING
		ON TOUR.id = TRANSPORT_BOOKING.tour_id
	JOIN ITINERARY
		ON TOUR.id = ITINERARY.tour_id
	GROUP BY TOUR.id, TOUR.tour_name
GO
---------------------------------------------------
---------------------------------------------------
-- drop view v_revenue_1year
CREATE VIEW v_revenue_1year (
	year,
	incoming,
	spending,
	revenue
) AS
	SELECT YEAR(TOUR.end_date), SUM(V.incoming), SUM(v.spending), SUM(V.incoming - V.spending)
	FROM TOUR JOIN v_incoming_spending V ON TOUR.id = V.tour_id
	WHERE DATEDIFF(DD, end_date, GETDATE()) > 0
	GROUP BY YEAR(TOUR.end_date)
GO
---------------------------------------------------
---------------------------------------------------
set dateformat MDY
GO
