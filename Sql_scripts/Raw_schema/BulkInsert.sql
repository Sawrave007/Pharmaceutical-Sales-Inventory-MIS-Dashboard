BULK INSERT raw.pharma_sales_raw
FROM 'E:\Projects\Eskayef\Data\pharma_data(Clean Data).csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);

