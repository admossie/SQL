SELECT s.CustomerID,
       SUM(s.Qty*s.UnitPrice) AS revenue,
       COUNT(*) AS orders_cnt
FROM #Sales AS s
GROUP BY s.CustomerID
HAVING SUM(s.Qty*s.UnitPrice) >= 30
ORDER BY revenue DESC;
