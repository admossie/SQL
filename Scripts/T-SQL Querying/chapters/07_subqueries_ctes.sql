-- Chapter 7: Subqueries & CTEs
-- Top customers by revenue using CTE
WITH sales_rev AS (
    SELECT CustomerID, SUM(Qty*UnitPrice) AS revenue
    FROM #Sales
    GROUP BY CustomerID
)
SELECT *
FROM sales_rev
WHERE revenue = (SELECT MAX(revenue) FROM sales_rev);
