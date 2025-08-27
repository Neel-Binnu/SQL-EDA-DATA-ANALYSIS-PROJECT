
--CHANGE OVER-TIME ANALYSIS

select 
	year(order_date) as order_year,
	sum(sales_amount) total_sales,
	count(DISTINCT customer_key) as total_customers,
	sum(quantity) as total_quantities
from gold.fact_sales
where order_date is not null
group by year(order_date)
order by year(order_date)

-----------------------------------------------------------


select 
	DATETRUNC(month,order_date) order_date,
	sum(sales_amount) total_sales,
	count(DISTINCT customer_key) as total_customers,
	sum(quantity) as total_quantity
from gold.fact_sales
where order_date is not null
group by DATETRUNC(month,order_date)
order by DATETRUNC(month,order_date)

---------------------------------------------------
select 
	FORMAT(order_date,'yyyy-MMM') order_date,
	sum(sales_amount) total_sales,
	count(DISTINCT customer_key) as total_customers,
	sum(quantity) as total_quantity
from gold.fact_sales
where order_date is not null
group by FORMAT(order_date,'yyyy-MMM')
order by FORMAT(order_date,'yyyy-MMM')

---------------------------------------------------
select 
	year(order_date) order_year,
	month(order_date) order_month,
	sum(sales_amount) total_sales,
	count(DISTINCT customer_key) as total_customers,
	sum(quantity) as total_quantity
from gold.fact_sales
where order_date is not null
group by year(order_date) ,month(order_date) 
order by year(order_date) ,month(order_date) 