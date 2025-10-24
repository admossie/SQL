--SQL_SERVER TEST
-- A. What state is the DB in?
SELECT name, state_desc, user_access_desc
FROM sys.databases
WHERE name = 'WideWorldImportersDW';

-- B. Any active sessions touching it?
SELECT s.session_id, s.host_name, s.program_name, r.status, r.command
FROM sys.dm_exec_sessions s
JOIN sys.dm_exec_requests r ON r.session_id = s.session_id
WHERE r.database_id = DB_ID('WideWorldImportersDW');

USE master;
GO
RESTORE DATABASE WideWorldImportersDW_New
FROM DISK = 'C:\SQL\Backup\WideWorldImportersDW-Full (1).bak'
WITH REPLACE,
     RECOVERY,
     MOVE 'WWI_Primary' TO 'C:\SQLData\WideWorldImportersDW_New.mdf',
     MOVE 'WWI_UserData' TO 'C:\SQLData\WideWorldImportersDW_New_UserData.ndf',
     MOVE 'WWI_Log' TO 'C:\SQLLogs\WideWorldImportersDW_New_log.ldf',
     MOVE 'WWI_InMemory_Data_1' TO 'C:\SQLData\WideWorldImportersDW_New_InMemory.ndf';
GO
-- 1) Force everyone off and take it offline
USE master;
GO
ALTER DATABASE [WideWorldImportersDW] SET OFFLINE WITH ROLLBACK IMMEDIATE;
GO

-- 2) Drop the database
DROP DATABASE [WideWorldImportersDW];
GO


SELECT physical_name
FROM sys.master_files
WHERE DB_NAME(database_id) = 'WideWorldImportersDW';

USE master;
GO
RESTORE DATABASE [WideWorldImportersDW_New]
FROM DISK = 'C:\SQL\Backup\WideWorldImportersDW-Full (1).bak'
WITH REPLACE, RECOVERY;
GO

USE master;
GO

RESTORE DATABASE [WideWorldImportersDW_New]
FROM DISK = 'C:\SQL\Backup\WideWorldImportersDW-Full (1).bak'
WITH 
    REPLACE,
    RECOVERY,
    MOVE 'WWI_Primary'           TO 'C:\SQLData\WideWorldImportersDW_New.mdf',
    MOVE 'WWI_UserData'          TO 'C:\SQLData\WideWorldImportersDW_New_UserData.ndf',
    MOVE 'WWI_Log'               TO 'C:\SQLLogs\WideWorldImportersDW_New_log.ldf',
    MOVE 'WWI_InMemory_Data_1'   TO 'C:\SQLData\WideWorldImportersDW_New_InMemory.ndf';
GO
RESTORE FILELISTONLY 
FROM DISK = 'C:\SQL\Backup\WideWorldImportersDW-Full (1).bak';
GO
USE master;
GO

RESTORE DATABASE [WideWorldImportersDW_New]
FROM DISK = 'C:\SQL\Backup\WideWorldImportersDW-Full (1).bak'
WITH 
    REPLACE,
    RECOVERY,
    MOVE 'WWI_Primary'             TO 'C:\SQLData\WideWorldImportersDW_New.mdf',
    MOVE 'WWI_UserData'            TO 'C:\SQLData\WideWorldImportersDW_New_UserData.ndf',
    MOVE 'WWI_Log'                 TO 'C:\SQLLogs\WideWorldImportersDW_New_log.ldf',
    MOVE 'WWIDW_InMemory_Data_1'   TO 'C:\SQLData\WideWorldImportersDW_New_InMemory.ndf';
GO
SELECT name, state_desc 
FROM sys.databases
WHERE name = 'WideWorldImportersDW_New';

SELECT TOP 10 * FROM WideWorldImportersDW_New.Dimension.City;

SELECT TOP 20 City, State Province, Country, Region
FROM WideWorldImportersDW_New.Dimension.City
ORDER BY City;

SELECT TOP 5 *
FROM WideWorldImportersDW_New.Dimension.City;

-- Change the DISK path to the file you’re restoring
RESTORE FILELISTONLY 
FROM DISK = 'C:\SQL\Backup\Northwind.bak';
GO
USE master;
GO
RESTORE DATABASE [Northwind]
FROM DISK = 'C:\SQL\Backup\Northwind.bak'
WITH REPLACE, RECOVERY,
     MOVE 'Northwind'      TO 'C:\SQLData\Northwind.mdf',      -- <== data LogicalName
     MOVE 'Northwind_log'  TO 'C:\SQLLogs\Northwind_log.ldf';  -- <== log  LogicalName
GO

SELECT TOP 10 OrderID, CustomerID, OrderDate
FROM Northwind.dbo.Orders
ORDER BY OrderDate DESC;

USE Chinook;
GO
SELECT TOP 10
    ar.Name AS Artist,
    COUNT(il.InvoiceLineId) AS TrackSales
FROM InvoiceLine AS il
JOIN Track AS t ON il.TrackId = t.TrackId
JOIN Album AS al ON t.AlbumId = al.AlbumId
JOIN Artist AS ar ON al.ArtistId = ar.ArtistId
GROUP BY ar.Name
ORDER BY TrackSales DESC;


SELECT TOP 10
    ar.Name AS Artist,
    COUNT(il.InvoiceLineId) AS TrackSales
FROM dbo.InvoiceLine AS il
JOIN dbo.Track       AS t  ON il.TrackId  = t.TrackId
JOIN dbo.Album       AS al ON t.AlbumId   = al.AlbumId
JOIN dbo.Artist      AS ar ON al.ArtistId = ar.ArtistId
GROUP BY ar.Name
ORDER BY TrackSales DESC;
