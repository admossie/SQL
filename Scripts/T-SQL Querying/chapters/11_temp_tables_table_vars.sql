-- Chapter 11: Temp tables, table variables, and TVFs (outline)
-- Temp table already used above (#Sales, #Notes).
-- Table variable demo:
DECLARE @Recent TABLE(SaleID int PRIMARY KEY, CustomerID int, OrderDate date);
INSERT INTO @Recent
SELECT SaleID, CustomerID, OrderDate
FROM #Sales WHERE OrderDate >= '2024-02-01';

SELECT * FROM @Recent;
