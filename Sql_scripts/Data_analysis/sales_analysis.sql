-- =====================================================================
-- 1. MONTHLY SALES TREND
-- =====================================================================

WITH monthly AS
(
    SELECT
        DATEFROMPARTS(
            YEAR([Date]),
            MONTH([Date]),
            1
        ) AS month_start,

        SUM(Sales_Amount) AS gross_sales,
        SUM(net_sales) AS net_sales,
        COUNT(*) AS invoice_lines

    FROM pharma.pharma_sales

    WHERE [Date] IS NOT NULL

    GROUP BY
        DATEFROMPARTS(
            YEAR([Date]),
            MONTH([Date]),
            1
        )
),
monthly_analysis AS
(
    SELECT
        month_start,
        invoice_lines,
        gross_sales,
        net_sales,

        LAG(net_sales) OVER (
            ORDER BY month_start
        ) AS previous_month_sales,

        SUM(net_sales) OVER (
            ORDER BY month_start
            ROWS UNBOUNDED PRECEDING
        ) AS cumulative_net_sales
    FROM monthly
)
SELECT
    month_start,
    invoice_lines,
    gross_sales,
    net_sales,
    cumulative_net_sales
FROM monthly_analysis
ORDER BY month_start;

