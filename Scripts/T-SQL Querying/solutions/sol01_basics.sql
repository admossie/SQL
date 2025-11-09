SELECT TOP (3)
    SaleID, OrderDate, CAST(Qty*UnitPrice AS decimal(12,2)) AS total
FROM #Sales
ORDER BY total DESC;
