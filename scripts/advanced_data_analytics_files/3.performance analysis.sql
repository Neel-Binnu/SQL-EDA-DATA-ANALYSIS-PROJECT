
/* Analyze the yearly performance of products by comparing their sales to both the 
average sales performance of the product and the previous year's sales */


with yearly_product_sales as(
	select 
	year(f.order_date) as order_year,
	p.product_name,
	sum(f.sales_amount) as current_sales
	from gold.fact_sales f
	left join gold.dim_products p
	on f.product_key=p.product_key
	group by year(f.order_date),p.product_name
)

select 
	order_year,
	product_name,
	current_sales,
	AVG(current_sales) over(partition by product_name ) as average_sales,
	current_sales - AVG(current_sales) over(partition by product_name)  as diff_avg, 
	CASE 
		WHEN (current_sales - AVG(current_sales) over(partition by product_name ))  < 0  THEN  'below average'
		WHEN (current_sales - AVG(current_sales) over(partition by product_name ))  > 0  THEN  'above average'
		ELSE 'avg'
	END	avg_change,
	LAG(current_sales) OVER(partition by product_name order by order_year ) as py_sales,
	current_sales - LAG(current_sales) OVER(partition by product_name order by order_year) as diff_py,
	CASE 
		WHEN (current_sales - LAG(current_sales) OVER(partition by product_name order by order_year ))  < 0  THEN  'Increasing'
		WHEN (current_sales - LAG(current_sales) OVER(partition by product_name order by order_year ))  > 0  THEN  'Decreasing'
		ELSE 'No change'
	END	avg_change
	from yearly_product_sales


