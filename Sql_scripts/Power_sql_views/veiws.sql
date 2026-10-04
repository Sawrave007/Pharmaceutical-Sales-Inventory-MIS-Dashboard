/* =====================================================================
   08_powerbi_model_views.sql
   ---------------------------------------------------------------------
   PURPOSE
       Create the SQL views required for the Power BI dashboard.
=========================================================================== */


-- =====================================================================
-- 1. SALES VIEW
-- =====================================================================

CREATE OR ALTER VIEW pharma.vw_sales_clean AS

SELECT
    Invoice_ID,
    [Date],

    DATEFROMPARTS(
        YEAR([Date]),
        MONTH([Date]),
        1
    ) AS month_start,

    Product,
    Product_category,
    Batch,
    Expiry_Date,
    Territory,
    Sales_Rep,
    Distributor,

    Quantity,
    Unit_Price,
    Sales_Amount,
    Return_Quantity,

    Net_quantity,
    net_sales,

    Return_Quantity * Unit_Price AS Return_Value,

    DATEDIFF(
        DAY,
        [Date],
        Expiry_Date
    ) AS Days_Left_At_Sale,

    CASE
        WHEN DATEDIFF(DAY, [Date], Expiry_Date) < 90
            THEN '1. < 90 days'

        WHEN DATEDIFF(DAY, [Date], Expiry_Date) < 180
            THEN '2. 90-179 days'

        WHEN DATEDIFF(DAY, [Date], Expiry_Date) < 365
            THEN '3. 180-364 days'

        ELSE '4. 365+ days'
    END AS Shelf_Life_Bucket

FROM pharma.pharma_sales

WHERE Invoice_ID IS NOT NULL;

GO


-- =====================================================================
-- 2. MONTH DIMENSION
-- =====================================================================

CREATE OR ALTER VIEW pharma.vw_dim_month AS

SELECT
    DATEADD(
        MONTH,
        n,
        CAST('2025-01-01' AS DATE)
    ) AS month_start,

    MONTH(
        DATEADD(
            MONTH,
            n,
            CAST('2025-01-01' AS DATE)
        )
    ) AS MonthNo,

    LEFT(
        DATENAME(
            MONTH,
            DATEADD(
                MONTH,
                n,
                CAST('2025-01-01' AS DATE)
            )
        ),
        3
    ) AS MonthName,

    DATEPART(
        QUARTER,
        DATEADD(
            MONTH,
            n,
            CAST('2025-01-01' AS DATE)
        )
    ) AS QuarterNo

FROM
(
    SELECT TOP (12)
        ROW_NUMBER() OVER (
            ORDER BY (SELECT NULL)
        ) - 1 AS n

    FROM sys.all_objects
) AS months;

GO


-- =====================================================================
-- 3. TERRITORY DIMENSION
-- =====================================================================

CREATE OR ALTER VIEW pharma.vw_dim_territory AS

SELECT DISTINCT
    Territory

FROM pharma.pharma_sales

WHERE Territory IS NOT NULL;

GO


-- =====================================================================
-- 4. PRODUCT DIMENSION
-- =====================================================================

CREATE OR ALTER VIEW pharma.vw_dim_product AS

SELECT
    Product,
    MAX(Product_category) AS Product_category

FROM pharma.pharma_sales

WHERE Product IS NOT NULL

GROUP BY
    Product;

GO

--test
SELECT
*
FROM pharma.vw_sales_clean

SELECT
*
FROM pharma.vw_dim_month


SELECT
*
FROM pharma.vw_dim_territory


SELECT
*
FROM pharma.vw_dim_product;