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


--test
SELECT
*
FROM pharma.vw_sales_clean
