-- Chapter 10: Conditional expressions
-- CASE (ANSI) vs IIF (T‑SQL convenience)
SELECT
    SaleID,
    Qty,
    UnitPrice,
    CASE WHEN Qty*UnitPrice >= 40 THEN 'High' 
         WHEN Qty*UnitPrice >= 20 THEN 'Medium'
         ELSE 'Low' END AS spend_bucket,
    IIF(Qty >= 3, 1, 0) AS bulk_flag
FROM #Sales;
