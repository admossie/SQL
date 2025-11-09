-- Chapter 8: Window Functions (OVER, PARTITION BY, ORDER BY)
-- Running total and rank by customer
SELECT
    s.CustomerID,
    s.OrderDate,
    CAST(s.Qty*s.UnitPrice AS decimal(12,2)) AS line_total,
    SUM(CAST(s.Qty*s.UnitPrice AS decimal(12,2))) OVER
        (PARTITION BY s.CustomerID ORDER BY s.OrderDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total,
    DENSE_RANK() OVER (ORDER BY s.CustomerID) AS cust_rank
FROM #Sales AS s
ORDER BY s.CustomerID, s.OrderDate;
