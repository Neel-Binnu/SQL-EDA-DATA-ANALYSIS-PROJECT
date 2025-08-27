
--which categories contribute the most to overall sales?


with category_sales as (
select
	category,
	sum(f.sales_amount) as total_sales
	from gold.fact_sales f
	left join gold.dim_products p
	on f.product_key=p.product_key
	group by category 
)
select 
	category,
	total_sales,
	sum(total_sales) over()  as overall_sales,
	CONCAT(ROUND((CAST(total_sales AS FLOAT)/sum(total_sales) over()) * 100,2),'%') as percent_total
from category_sales
order by percent_total desc


select * from gold.fact_sales
select * from gold.dim_products