TRUNCATE TABLE pharma.pharma_sales;
GO


INSERT INTO pharma.pharma_sales
(
    Invoice_ID,
    Date,
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
    Target,
    Return_Quantity,
    sales_calc,
    [Near-Expiry flag],
    Net_quantity,
    net_sales
)
SELECT
    Invoice_ID,
    TRY_CONVERT(DATE, Date, 101),
    Product,
    Product_category,
    Batch,
    TRY_CONVERT(DATE, Expiry_Date, 101),
    Territory,
    Sales_Rep,
    Distributor,
    TRY_CONVERT(INT, Quantity),
    TRY_CONVERT(DECIMAL(18,2), Unit_Price),
    TRY_CONVERT(DECIMAL(18,2), Sales_Amount),
    TRY_CONVERT(DECIMAL(18,2), Target),
    TRY_CONVERT(INT, Return_Quantity),
    TRY_CONVERT(DECIMAL(18,2), sales_calc),
    [Near-Expiry flag],
    TRY_CONVERT(INT, Net_quantity),
    TRY_CONVERT(DECIMAL(18,2), net_sales)
FROM raw.pharma_sales_raw
WHERE Invoice_ID IS NOT NULL;

