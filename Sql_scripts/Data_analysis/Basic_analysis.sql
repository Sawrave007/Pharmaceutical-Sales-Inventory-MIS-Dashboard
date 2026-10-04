-- =====================================================================
-- 1. HEADLINE KPIs
-- =====================================================================

SELECT
    distributor,
    COUNT(*) AS invoice_lines,
    COUNT(DISTINCT Invoice_ID) AS unique_invoices,
    SUM(Quantity) AS units_sold,
    SUM(Sales_Amount) AS gross_sales,
    SUM(net_sales) AS net_sales,
    SUM(Return_Quantity * Unit_Price) AS returned_value,
    ROUND(
        100.0 * SUM(Return_Quantity)
        / NULLIF(SUM(Quantity), 0),
        2
    ) AS return_rate_pct,
    ROUND(AVG(Sales_Amount), 2) AS avg_invoice_line_value
FROM pharma.pharma_sales
group by distributor


select * from pharma.pharma_sales
where distributor is NULL