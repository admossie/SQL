SELECT
    s.CustomerID, s.SaleID, s.OrderDate,
    ROW_NUMBER() OVER (PARTITION BY s.CustomerID ORDER BY s.OrderDate) AS rnk
FROM #Sales AS s
ORDER BY s.CustomerID, rnk;
