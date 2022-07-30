USE qltour
GO
---------------------------------------------------
---------------------------------------------------
DECLARE @matour int, @cur int
DECLARE cur_PG CURSOR
FORWARD_ONLY
FOR
SELECT id FROM TOUR
-- Mở cursor
OPEN cur_PG
-- Ðọc dữ liệu và cập nhật giá trị
FETCH NEXT FROM cur_PG INTO @matour
WHILE @@FETCH_STATUS = 0
BEGIN
	SELECT @cur = sum(quantity)	FROM INVOICE WHERE tour_id = @matour
	IF @cur IS NULL 
	BEGIN
		SET @cur = 0
	END

	PRINT @cur

	UPDATE TOUR
	SET cur_quantity = @cur
	WHERE id=@matour -- Hoặc là: Where Current OF cur_PG

	FETCH NEXT FROM cur_PG INTO @matour
END
-- Ðóng và hủy cursor
CLOSE cur_PG
DEALLOCATE cur_PG
---------------------------------------------------
---------------------------------------------------
DECLARE @id int, @price decimal(10,2)
DECLARE cur_PG CURSOR
FORWARD_ONLY
FOR
SELECT id FROM INVOICE
-- Mở cursor
OPEN cur_PG
-- Ðọc dữ liệu và cập nhật giá trị
FETCH NEXT FROM cur_PG INTO @id
WHILE @@FETCH_STATUS = 0
BEGIN
	SELECT @price = TOUR.price 
	FROM TOUR JOIN INVOICE ON TOUR.id = INVOICE.tour_id
	WHERE INVOICE.id = @id

	PRINT @id

	UPDATE INVOICE
	SET price = @price
	WHERE id=@id -- Hoặc là: Where Current OF cur_PG

	FETCH NEXT FROM cur_PG INTO @id
END
-- Ðóng và hủy cursor
CLOSE cur_PG
DEALLOCATE cur_PG
---------------------------------------------------
---------------------------------------------------
DECLARE @tour_id int, @hotel_service_id int, @service_price decimal(10,2), @quantity int
DECLARE cur_PG CURSOR
FORWARD_ONLY
FOR
SELECT tour_id, hotel_service_id FROM HOTEL_BOOKING
-- Mở cursor
OPEN cur_PG
-- Ðọc dữ liệu và cập nhật giá trị
FETCH NEXT FROM cur_PG INTO @tour_id, @hotel_service_id
WHILE @@FETCH_STATUS = 0
BEGIN
	SELECT @service_price = service_price
	FROM HOTEL_SERVICE
	WHERE id = @hotel_service_id

	SELECT @quantity = cur_quantity
	FROM TOUR
	WHERE id = @tour_id

	PRINT @tour_id

	UPDATE HOTEL_BOOKING
	SET price = @service_price, quantity = @quantity
	WHERE Current OF cur_PG 

	FETCH NEXT FROM cur_PG INTO @tour_id, @hotel_service_id
END
-- Ðóng và hủy cursor
CLOSE cur_PG
DEALLOCATE cur_PG
---------------------------------------------------
---------------------------------------------------
DECLARE @transport_service_id int
DECLARE cur_PG CURSOR
FORWARD_ONLY
FOR
SELECT tour_id, transport_service_id FROM TRANSPORT_BOOKING
-- Mở cursor
OPEN cur_PG
-- Ðọc dữ liệu và cập nhật giá trị
FETCH NEXT FROM cur_PG INTO @tour_id, @transport_service_id
WHILE @@FETCH_STATUS = 0
BEGIN
	SELECT @service_price = service_price
	FROM TRANSPORT_SERVICE
	WHERE id = @transport_service_id

	SELECT @quantity = cur_quantity
	FROM TOUR
	WHERE id = @tour_id

	PRINT @tour_id

	UPDATE TRANSPORT_BOOKING
	SET price = @service_price, quantity = @quantity
	WHERE Current OF cur_PG 

	FETCH NEXT FROM cur_PG INTO @tour_id, @transport_service_id
END
-- Ðóng và hủy cursor
CLOSE cur_PG
DEALLOCATE cur_PG
