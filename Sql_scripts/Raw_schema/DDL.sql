CREATE SCHEMA raw;
GO


CREATE TABLE raw.pharma_sales_raw
(
    Invoice_ID          VARCHAR(100),
    Date                VARCHAR(100),
    Product             VARCHAR(100),
    Product_category    VARCHAR(100),
    Batch               VARCHAR(100),
    Expiry_Date         VARCHAR(100),
    Territory           VARCHAR(100),
    Sales_Rep           VARCHAR(100),
    Distributor         VARCHAR(150),
    Quantity            VARCHAR(100),
    Unit_Price           VARCHAR(100),
    Sales_Amount        VARCHAR(100),
    Target              VARCHAR(100),
    Return_Quantity     VARCHAR(100),
    sales_calc          VARCHAR(100),
    [Near-Expiry flag]  VARCHAR(100),
    Net_quantity        VARCHAR(100),
    net_sales           VARCHAR(100)
);
GO