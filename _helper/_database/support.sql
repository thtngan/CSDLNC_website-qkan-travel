USE master;
GO 
EXEC sp_detach_db
    @dbname = N'qltour';
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
-- FILEGROUP F1
ALTER DATABASE [qltour] ADD FILEGROUP FG1
GO
ALTER DATABASE [qltour] 
ADD FILE 
    ( NAME = N'qltour_data01', FILENAME = N'C:\CSDL\qltour_data01.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
TO FILEGROUP FG1
GO
-- FILEGROUP F2
ALTER DATABASE [qltour] ADD FILEGROUP FG2
GO
ALTER DATABASE [qltour] 
ADD FILE 
    ( NAME = N'qltour_data02', FILENAME = N'C:\CSDL\qltour_data02.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
TO FILEGROUP FG2
GO
-- FILEGROUP F3
ALTER DATABASE [qltour] ADD FILEGROUP FG3
GO
ALTER DATABASE [qltour] 
ADD FILE 
    ( NAME = N'qltour_data03', FILENAME = N'C:\CSDL\qltour_data03.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
TO FILEGROUP FG3
--------------------------------------------------------
--------------------------------------------------------
USE qltour
GO
SELECT DB_NAME() AS dbname,fg.name AS filegroup, f.name AS filename, file_id, physical_name,
(size * 8.0/1024) AS size_MB,
((size * 8.0/1024) - (FILEPROPERTY(f.name, 'SpaceUsed') * 8.0/1024)) AS FreeSpace_MB
FROM sys.database_files f
    LEFT JOIN sys.filegroups fg ON f.data_space_id = fg.data_space_id
GO
--------------------------------------------------------
--------------------------------------------------------
use qltour

CREATE PARTITION FUNCTION pfTour (DATE)
AS RANGE RIGHT FOR VALUES 
('1987-01-01', '1997-01-01', '2007-01-01');
CREATE PARTITION SCHEME psTour
AS PARTITION pfTour TO ([PRIMARY], FG1, FG2, FG3)  
GO

CREATE PARTITION FUNCTION pfInvoice (DATETIME)
AS RANGE RIGHT FOR VALUES 
('2001-01-01', '2002-01-01');
CREATE PARTITION SCHEME psInvoice
AS PARTITION pfInvoice TO ([PRIMARY], FG1, FG2)
GO

SELECT ps.name,pf.name,boundary_id,value
FROM sys.partition_schemes ps
INNER JOIN sys.partition_functions pf ON pf.function_id=ps.function_id
INNER JOIN sys.partition_range_values prf ON pf.function_id=prf.function_id

--------------------------------------------------------
--------------------------------------------------------

SELECT o.name objectname,i.name indexname, partition_id, partition_number, [rows]
FROM sys.partitions p
INNER JOIN sys.objects o ON o.object_id=p.object_id
INNER JOIN sys.indexes i ON i.object_id=p.object_id and p.index_id=i.index_id
WHERE o.name LIKE 'TOUR'

--------------------------------------------------------
--------------------------------------------------------
EXEC sp_helpindex 'TOUR'
--------------------------------------------------------
--------------------------------------------------------
