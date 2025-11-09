-- Chapter 1: SELECT Basics (ANSI-safe)
-- Goal: columns, aliases, literals, TOP, DISTINCT

-- Sample demo table (temp) — drop if exists
IF OBJECT_ID('tempdb..#Sales') IS NOT NULL DROP TABLE #Sales;
CREATE TABLE #Sales(
    SaleID       int         NOT NULL PRIMARY KEY,
    CustomerID   int         NOT NULL,
    OrderDate    date        NOT NULL,
    Qty          int         NOT NULL CHECK (Qty > 0),
    UnitPrice    decimal(12,2) NOT NULL CHECK (UnitPrice >= 0.0)
);

INSERT INTO #Sales(SaleID, CustomerID, OrderDate, Qty, UnitPrice)
VALUES (1, 101, '2024-01-03', 2, 12.50),
       (2, 101, '2024-02-10', 5,  9.99),
       (3, 102, '2024-02-17', 1, 25.00),
       (4, 103, '2024-03-01', 3, 15.00);

-- Basic SELECT with alias and computed column
SELECT 
    s.SaleID,
    s.CustomerID AS cust_id,
    s.OrderDate,
    s.Qty,
    s.UnitPrice,
    CAST(s.Qty * s.UnitPrice AS decimal(12,2)) AS line_total
FROM #Sales AS s;

-- DISTINCT and TOP
SELECT DISTINCT CustomerID FROM #Sales;
SELECT TOP (2) * FROM #Sales ORDER BY OrderDate DESC;
