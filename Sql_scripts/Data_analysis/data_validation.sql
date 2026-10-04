/* =====================================================================
   01_data_validation.sql
   ---------------------------------------------------------------------
   PURPOSE
       Validate the pharmaceutical sales dataset before analysis.

   OBJECTIVE
       Confirm that the data is complete, consistent, and follows
       the expected business rules before SQL analysis and Power BI.
    ===================================================================== */

SELECT *
FROM pharma.pharma_sales;

SELECT COUNT(*) AS total_rows
FROM pharma.pharma_sales;

SELECT
    MIN(Date) AS first_date,
    MAX(Date) AS last_date
FROM pharma.pharma_sales;

SELECT DISTINCT Product
FROM pharma.pharma_sales
ORDER BY Product;

UPDATE pharma.pharma_sales
SET Product = UPPER(REPLACE(Product, ' ', ''));

SELECT DISTINCT Territory
FROM pharma.pharma_sales
ORDER BY Territory;

-- =====================================================================
-- 1. VOLUME & DATA COVERAGE
-- =====================================================================

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT Invoice_ID) AS distinct_invoice_ids,
    MIN([Date]) AS first_sale_date,
    MAX([Date]) AS last_sale_date,
    COUNT(DISTINCT Product) AS products,
    COUNT(DISTINCT Territory) AS territories,
    COUNT(DISTINCT Sales_Rep) AS sales_reps,
    COUNT(DISTINCT Distributor) AS distributors
FROM pharma.pharma_sales;

-- =====================================================================
-- 2. NULL PROFILE
-- =====================================================================
-- Check missing values in fields required for analysis.
-- =====================================================================

SELECT
    SUM(CASE WHEN Invoice_ID IS NULL THEN 1 ELSE 0 END) AS null_invoice_id,
    SUM(CASE WHEN [Date] IS NULL THEN 1 ELSE 0 END) AS null_date,
    SUM(CASE WHEN Product IS NULL THEN 1 ELSE 0 END) AS null_product,
    SUM(CASE WHEN Product_category IS NULL THEN 1 ELSE 0 END) AS null_category,
    SUM(CASE WHEN Batch IS NULL THEN 1 ELSE 0 END) AS null_batch,
    SUM(CASE WHEN Expiry_Date IS NULL THEN 1 ELSE 0 END) AS null_expiry,
    SUM(CASE WHEN Territory IS NULL THEN 1 ELSE 0 END) AS null_territory,
    SUM(CASE WHEN Sales_Rep IS NULL THEN 1 ELSE 0 END) AS null_sales_rep,
    SUM(CASE WHEN Distributor IS NULL THEN 1 ELSE 0 END) AS null_distributor,
    SUM(CASE WHEN Target IS NULL THEN 1 ELSE 0 END) AS null_target
FROM pharma.pharma_sales;



-- ---------------------------------------------------------------------
-- 3. BATCH → EXPIRY DATE
-- ---------------------------------------------------------------------
-- Each batch should have exactly one expiry date.
-- ---------------------------------------------------------------------

SELECT
    Batch,
    COUNT(DISTINCT Expiry_Date) AS expiry_dates
FROM pharma.pharma_sales
GROUP BY
    Batch
HAVING
    COUNT(DISTINCT Expiry_Date) > 1;

