-- QUERY 1: Tìm kiếm tất cả các tour theo ngày khởi hành, tên điểm đến và điểm đi.
SELECT * FROM TOUR t WHERE t.depart_date = '19990807'
	AND EXISTS (SELECT * FROM CITY c WHERE c.city_name = 'Druzhba' AND c.id = T.destination_id)
	AND EXISTS (SELECT * FROM CITY c WHERE c.city_name = 'Honolulu' AND c.id = T.departure_id)

-- QUERY 2: Tìm kiếm tất cả nhân viên theo từ khóa (tên)
SELECT * FROM STAFF s WHERE s.staff_name LIKE 'Che%'

-- QUERY 3: Lấy thông tin tất cả nhân viên cùng với tên loại nhân viên
SELECT s.*, t.staff_type_name FROM STAFF s LEFT JOIN STAFF_TYPE t ON s.staff_type_id = t.id

-- QUERY 3: Lấy thông tin cùng với tên loại nhân viên của nhân viên có id 509
SELECT s.*, t.staff_type_name FROM STAFF s LEFT JOIN STAFF_TYPE t ON s.staff_type_id = t.id
Where s.id= 509

-- QUERY 4: Lấy thông tin lợi nhuận theo thứ tự năm tăng dần
Select year, revenue from v_revenue_1year order by year asc

-- QUERY 5: Lấy 15 tour có lợi nhuận cao nhất
Select top 15 tour_name, incoming, spending from v_incoming_spending order by incoming - spending asc

-- QUERY 6: Lấy tất cả các tour
SELECT t.*, c1.city_name as destination_city, c2.city_name as departure_city 
FROM TOUR t LEFT JOIN CITY c1 ON c1.id = t.destination_id 
	LEFT JOIN CITY c2 ON c2.id = t.departure_id

-- QUERY 7: Lấy tour có tour_id = 100
SELECT t.*, c1.city_name as destination_city, c2.city_name as departure_city 
FROM TOUR t LEFT JOIN CITY c1 ON c1.id = t.destination_id 
	LEFT JOIN CITY c2 ON c2.id = t.departure_id Where t.id= 100

-- QUERY 8: Lấy tất cả thành phố
SELECT city_name,id FROM CITY

-- QUERY 9: Search transport với điểm khởi hành id = 10
select se.id as id, ty.ticket_type_name as name from TRANSPORT_SERVICE se left join TICKET_TYPE ty
on se.ticket_type_id = ty.id where se.from_city_id = 10

-- QUERY 10: Lấy loại phòng khách sạn
select se.id as id, ty.room_type_name as name from HOTEL_SERVICE se left join ROOM_TYPE ty
        on se.room_type_id = ty.id
