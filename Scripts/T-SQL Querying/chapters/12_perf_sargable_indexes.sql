-- Chapter 12: Performance & SARGability demo
-- Create an indexed permanent table in tempdb for demo
IF OBJECT_ID('tempdb.dbo.DemoSales','U') IS NOT NULL DROP TABLE tempdb.dbo.DemoSales;
CREATE TABLE tempdb.dbo.DemoSales(
    SaleID int IDENTITY(1,1) PRIMARY KEY,
    OrderDate date NOT NULL,
    Amount decimal(12,2) NOT NULL
);
-- Insert sample rows
DECLARE @d date='2024-01-01';
WHILE @d < '2024-12-31'
BEGIN
    INSERT INTO tempdb.dbo.DemoSales(OrderDate, Amount)
    SELECT @d, ABS(CHECKSUM(NEWID())) % 100 + 1;
    SET @d = DATEADD(day,1,@d);
END
-- Index on OrderDate
CREATE INDEX IX_DemoSales_OrderDate ON tempdb.dbo.DemoSales(OrderDate);

-- SARGable predicate (seek)
SELECT * FROM tempdb.dbo.DemoSales
WHERE OrderDate >= '2024-06-01' AND OrderDate < '2024-07-01';

-- Non‑SARGable predicate (scan)
-- SELECT * FROM tempdb.dbo.DemoSales WHERE YEAR(OrderDate)=2024 AND MONTH(OrderDate)=6;
