-- Chapter 5: Aggregation & GROUP BY (with HAVING)
-- Total and average spend per customer
SELECT
    s.CustomerID,
    SUM(s.Qty * s.UnitPrice) AS revenue,
    AVG(s.UnitPrice)         AS avg_price,
    COUNT(*)                 AS orders_cnt
FROM #Sales AS s
GROUP BY s.CustomerID
HAVING SUM(s.Qty * s.UnitPrice) > 30.0
ORDER BY revenue DESC;
