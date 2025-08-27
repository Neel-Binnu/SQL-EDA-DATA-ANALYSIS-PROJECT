--Find the Total sales

select sum(sales_amount) as total_sales from gold.fact_sales

--Find how many items are sold

select sum(quantity) as total_quantity from gold.fact_sales

--Find the average selling price

select avg(price) as avg_price from gold.fact_sales

--Find the total number of orders

select count(order_number) as total_orders from gold.fact_sales
select count(distinct(order_number)) as total_orders from gold.fact_sales

--Find the total number of products

select count(distinct(product_key)) as total_products from gold.dim_products

--Find total number of customer

select 
	count(customer_key) as total_customers
from gold.dim_customers

--Find total number of customers that has placed an order

select 
count(DISTINCT(customer_key)) as total_customers
from gold.fact_sales

--===============================================================================


select 'Total Sales' AS measure_name ,sum(sales_amount) as measure_value from gold.fact_sales
UNION ALL
select 'Total Quantity' AS measure_name ,sum(quantity) as measure_value from gold.fact_sales
UNION ALL
select 'order_number' AS measure_name ,count(distinct(order_number)) as measure_value from gold.fact_sales
UNION ALL
select 'product_key' AS measure_name ,count(distinct(product_key)) as measure_value from gold.dim_products
UNION ALL
select 'customer_key' AS measure_name ,count(customer_key) as measure_value from gold.dim_customers

