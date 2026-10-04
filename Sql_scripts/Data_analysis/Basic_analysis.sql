
-- =====================================================================
-- 1. DISTRIBUTOR PERFORMANCE / KPIs
-- =====================================================================

SELECT
    RANK() OVER (
        ORDER BY SUM(net_sales) DESC
    ) AS distributor_rank,
    Distributor,
    COUNT(DISTINCT Invoice_ID) AS invoice_lines,
    SUM(Quantity) AS units_sold,
    SUM(Sales_Amount) AS gross_sales,
    SUM(net_sales) AS net_sales,
    SUM(Return_Quantity * Unit_Price) AS returned_value,

    ROUND(
        100.0 * SUM(Return_Quantity)
        / NULLIF(SUM(Quantity), 0),
        2
    ) AS return_rate_pct
FROM pharma.pharma_sales
GROUP BY Distributor
ORDER BY distributor_rank;



-- =====================================================================
-- 2. ABC ANALYSIS
-- =====================================================================
-- A = Top products contributing to approximately 70% of net sales
-- B = Next products contributing to approximately 20%
-- C = Remaining products
-- =====================================================================

WITH product_sales AS
(
    SELECT
        Product,
        SUM(net_sales) AS net_sales
    FROM pharma.pharma_sales
    GROUP BY
        Product
),
abc_analysis AS
(
    SELECT
        Product,
        net_sales,

        SUM(net_sales) OVER (
            ORDER BY net_sales DESC
            ROWS UNBOUNDED PRECEDING
        ) AS cumulative_sales,

        SUM(net_sales) OVER () AS total_sales

    FROM product_sales
)
SELECT
    Product,
    ROUND(net_sales, 2) AS net_sales,

    ROUND(
        100.0 * cumulative_sales / NULLIF(total_sales, 0),
        1
    ) AS cumulative_sales_pct,

    CASE
        WHEN cumulative_sales - net_sales < total_sales * 0.70
            THEN 'A'
        WHEN cumulative_sales - net_sales < total_sales * 0.90
            THEN 'B'
        ELSE 'C'
    END AS abc_class

FROM abc_analysis

ORDER BY
    net_sales DESC;






