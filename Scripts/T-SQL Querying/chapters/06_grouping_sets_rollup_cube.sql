-- Chapter 6: GROUPING SETS, ROLLUP, CUBE
-- Totals by (CustomerID), by (OrderDate), and grand total
SELECT
    GROUPING_ID(CustomerID, OrderDate) AS grp_id,
    CustomerID,
    OrderDate,
    SUM(Qty*UnitPrice) AS revenue
FROM #Sales
GROUP BY GROUPING SETS ((CustomerID), (OrderDate), ())
ORDER BY grp_id, CustomerID, OrderDate;
