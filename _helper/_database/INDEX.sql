USE qltour

/*SELECT * FROM COUNTRY c
SELECT * FROM CITY c
SELECT * FROM TICKET_TYPE tt ORDER BY id
SELECT * FROM ROOM_TYPE rt ORDER BY id
SELECT * FROM PARTNER_TYPE pt
SELECT * FROM STAFF_TYPE st
SELECT * FROM ACCOUNT a
SELECT * FROM PARTNERS p
SELECT * FROM CUSTOMER c
SELECT * FROM STAFF s
SELECT * FROM INVOICE i
SELECT * FROM TOUR t
BULK INSERT INVOICE
*/
--DROP INDEX [_dta_index_TOUR_5_1943834137__K5_K3_K4_1_2_6_7_8_9_10] ON [dbo].[TOUR]
SELECT * FROM TOUR t WHERE t.depart_date = '19700904'
	AND EXISTS (SELECT * FROM CITY c WHERE c.city_name = 'Svetogorsk' AND c.id = T.destination_id)
	AND EXISTS (SELECT * FROM CITY c WHERE c.city_name = 'Seputih' AND c.id = T.departure_id)
CREATE NONCLUSTERED INDEX [_dta_index_TOUR_5_1943834137__K5_K3_K4_1_2_6_7_8_9_10] ON [dbo].[TOUR]
(
	[depart_date] ASC,
	[destination_id] ASC,
	[departure_id] ASC
)
INCLUDE([id],[tour_name],[end_date],[price],[register_date],[max_quantity],[cur_quantity]) WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]


-- DROP INDEX [_dta_index_STAFF_5_1639833054__K2_1_3_4_5_6_7_8_9_10] ON [dbo].[STAFF]

SET ANSI_PADDING ON
CREATE NONCLUSTERED INDEX [_dta_index_STAFF_5_1639833054__K2_1_3_4_5_6_7_8_9_10] ON [dbo].[STAFF]
(
	[staff_name] ASC
)
INCLUDE([id],[gender],[dob],[tele],[email],[staff_address],[staff_type_id],[id_no],[manager_id]) WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
SELECT * FROM STAFF s WHERE s.staff_name LIKE 'Che%'
