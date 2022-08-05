USE qltour
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