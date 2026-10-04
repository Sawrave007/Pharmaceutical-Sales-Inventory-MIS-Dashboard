

CREATE SCHEMA pharma;

GO
IF OBJECT_ID('pharma.pharma_sales', 'U') IS NOT NULL
    DROP TABLE pharma.pharma_sales;


GO
CREATE TABLE pharma.pharma_sales (
    Invoice_ID         VARCHAR (50)   ,
    Date               DATE           ,
    Product            VARCHAR (100)  ,
    Product_category   VARCHAR (100)  ,
    Batch              VARCHAR (50)   ,
    Expiry_Date        DATE           ,
    Territory          VARCHAR (50)   ,
    Sales_Rep          VARCHAR (100)  ,
    Distributor        VARCHAR (150)  ,
    Quantity           INT            ,
    Unit_Price         DECIMAL (18, 2),
    Sales_Amount       DECIMAL (18, 2),
    Target             DECIMAL (18, 2),
    Return_Quantity    INT            ,
    sales_calc         DECIMAL (18, 2),
    [Near-Expiry flag] VARCHAR (30)   ,
    Net_quantity       INT            ,
    net_sales          DECIMAL (18, 2)
);


