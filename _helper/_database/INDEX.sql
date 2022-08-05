USE qltour

--DROP INDEX [_dta_index_TOUR_5_1943834137__K5_K3_K4_1_2_6_7_8_9_10] ON [dbo].[TOUR]
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


