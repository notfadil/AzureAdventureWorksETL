

CREATE VIEW gold.customer
AS 
SELECT 
    * 
FROM OPENROWSET(
    BULK 'https://azprojectstorage.dfs.core.windows.net/silver/Customer/',
    FORMAT = 'PARQUET'
) as query1

CREATE VIEW gold.calender
AS 
SELECT 
    * 
FROM OPENROWSET(
    BULK 'https://azprojectstorage.dfs.core.windows.net/silver/Calender/',
    FORMAT = 'PARQUET'
) as query2

CREATE VIEW gold.product
AS 
SELECT 
    * 
FROM OPENROWSET(
    BULK 'https://azprojectstorage.dfs.core.windows.net/silver/Product/',
    FORMAT = 'PARQUET'
) as query2

CREATE VIEW gold.prodcat
AS 
SELECT 
    * 
FROM OPENROWSET(
    BULK 'https://azprojectstorage.dfs.core.windows.net/silver/ProductCategories/',
    FORMAT = 'PARQUET'
) as query2


CREATE VIEW gold.prodsubcat
AS 
SELECT 
    * 
FROM OPENROWSET(
    BULK 'https://azprojectstorage.blob.core.windows.net/silver/ProductSubcategory/',
    FORMAT = 'PARQUET'
) as query2

CREATE VIEW gold.returns
AS 
SELECT 
    * 
FROM OPENROWSET(
    BULK 'https://azprojectstorage.blob.core.windows.net/silver/Returns/',
    FORMAT = 'PARQUET'
) as query2


CREATE VIEW gold.sales
AS 
SELECT 
    * 
FROM OPENROWSET(
    BULK 'https://azprojectstorage.blob.core.windows.net/silver/Sales/',
    FORMAT = 'PARQUET'
) as query2

CREATE VIEW gold.territories
AS 
SELECT 
    * 
FROM OPENROWSET(
    BULK 'https://azprojectstorage.blob.core.windows.net/silver/Territories/',
    FORMAT = 'PARQUET'
) as query2