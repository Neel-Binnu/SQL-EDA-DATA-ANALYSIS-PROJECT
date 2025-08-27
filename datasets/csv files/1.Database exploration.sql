
--Explore all objects in the Database

SELECT * FROM INFORMATION_SCHEMA.TABLES 


--Explore All columns in the Database

SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='fact_sales'
