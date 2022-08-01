USE master;
GO 
EXEC sp_detach_db
    @dbname = N'qltour';
GO
GO
CREATE DATABASE qltour
    ON (FILENAME = 'C:\CSDL\qltour_data.mdf'),
       (FILENAME = 'C:\CSDL\qltour_log.ldf')
    FOR ATTACH;
GO
CREATE DATABASE qltour_new
    ON (FILENAME = 'C:\CSDL\qltour_new.mdf'),
       (FILENAME = 'C:\CSDL\qltour_new.ldf')
    FOR ATTACH;
GO
use qltour_new
select * from tour where depart_date > '2022-01-01'

CREATE PARTITION FUNCTION pfTour (DATE)
AS RANGE RIGHT FOR VALUES 
('1983-01-01', '1996-01-01', '2009-01-01');
CREATE PARTITION SCHEME psTour
AS PARTITION pfTour ALL TO ([PRIMARY]) 
GO
CREATE PARTITION FUNCTION pfInvoice (DATETIME)
AS RANGE RIGHT FOR VALUES 
('1983-01-01', '1996-01-01', '2009-01-01');
CREATE PARTITION SCHEME psInvoice
AS PARTITION pfInvoice ALL TO ([PRIMARY]) 
GO

SELECT ps.name,pf.name,boundary_id,value
FROM sys.partition_schemes ps
INNER JOIN sys.partition_functions pf ON pf.function_id=ps.function_id
INNER JOIN sys.partition_range_values prf ON pf.function_id=prf.function_id

EXEC sp_helpindex 'TOUR';
ALTER TABLE dbo.TOUR DROP CONSTRAINT PK__TOUR__3213E83F18B8FC10

CREATE CLUSTERED INDEX IX_TOUR_depart_date ON dbo.TOUR (depart_date)
  WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, 
        ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
  ON psTour(depart_date)
  SELECT o.name objectname,i.name indexname, partition_id, partition_number, [rows]
FROM sys.partitions p
INNER JOIN sys.objects o ON o.object_id=p.object_id
INNER JOIN sys.indexes i ON i.object_id=p.object_id and p.index_id=i.index_id
WHERE o.name LIKE 'TOUR'
