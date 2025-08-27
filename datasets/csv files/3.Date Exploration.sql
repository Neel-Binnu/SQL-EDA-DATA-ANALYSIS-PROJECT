
--Find the first and last of order date
--How many years of sales are available

select * from gold.fact_sales

select 
	min(order_date) as first_order_date,
	max(order_date) as last_order_date,
	DATEDIFF(MONTH,min(order_date),max(order_date)) as order_range_months
from gold.fact_sales

--Find the youngest and oldest customer
---------------------------------------------------------------------------- 
select 
	first_name,
	last_name,
	birthdate
from gold.dim_customers
where birthdate in ((select min(birthdate) from gold.dim_customers),
			(select max(birthdate) from gold.dim_customers))
order by birthdate
--------------------------------------------------------------------------------
SELECT 
    first_name,
    last_name,
    birthdate,
    CASE 
        WHEN birthdate = (SELECT MIN(birthdate) FROM gold.dim_customers) THEN 'oldest_customer'
        WHEN birthdate = (SELECT MAX(birthdate) FROM gold.dim_customers) THEN 'youngest_customer'
    END AS customer_type
FROM gold.dim_customers
WHERE birthdate IN (
    (SELECT MIN(birthdate) FROM gold.dim_customers),
    (SELECT MAX(birthdate) FROM gold.dim_customers)
);

