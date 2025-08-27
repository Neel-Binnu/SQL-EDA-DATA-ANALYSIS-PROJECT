
--Explore all countries our Customers from

select distinct country from gold.dim_customers

--Explore all categories 'The Major Divisions'

select distinct category,subcategory,product_name from  gold.dim_products
order by 1,2,3


select * from gold.dim_customers
