--which 5 products generates the highest revenue


select TOP 5
	p.product_name,
	sum(f.sales_amount) as total_revenue
	from gold.fact_sales f
	left join gold.dim_products p
	on f.product_key=p.product_key
	group by p.product_name
	order by total_revenue desc


--what are the 5 worst performing products in terms of sales?

select TOP 5
	p.product_name,
	sum(f.sales_amount) as total_revenue
	from gold.fact_sales f
	left join gold.dim_products p
	on f.product_key=p.product_key
	group by p.product_name
	order by total_revenue 

-------------------------------------------------------------------------------
select *
from(
	SELECT
		p.product_name,
		sum(f.sales_amount) as total_revenue,
		dense_rank() over(order by sum(f.sales_amount) desc) as rn
		from gold.fact_sales f
		left join gold.dim_products p
		on f.product_key=p.product_key
		group by p.product_name
		)t
where rn<=5	

--top 10 customers who generated highest revenue

select TOP 10
	c.customer_key,
	c.first_name,
	c.last_name,
	sum(f.sales_amount) as total_revenue
	from gold.fact_sales f
	left join gold.dim_customers c
	on c.customer_key=f.customer_key
	group by 
		c.customer_key,
		c.first_name,
		c.last_name
	order by total_revenue desc

-------------------------------------------------------

--top 3 with lowest orders

select TOP 3
	c.customer_key,
	c.first_name,
	c.last_name,
	count(DISTINCT order_number) as total_orders
	from gold.fact_sales f
	left join gold.dim_customers c
	on c.customer_key=f.customer_key
	group by 
		c.customer_key,
		c.first_name,
		c.last_name
	order by total_orders 