/*
===============================================================================
Data Segmentation Analysis
===============================================================================
Purpose:
    - To group data into meaningful categories for targeted insights.
    - For customer segmentation, product categorization, or regional analysis.

SQL Functions Used:
    - CASE: Defines custom segmentation logic.
    - GROUP BY: Groups data into segments.
===============================================================================
*/


/*
segment products into cost ranges and count how 
many products fall into each segment
*/


with cost_ranges as (
select 
	product_key,
	product_name,
	cost,
	CASE
		when cost <100 then 'below 100'
		when cost between 100 and 500 then '100-500'
		when cost between 500 and 1000 then '500-1000'
		ELSE 'above 1000'
	END as cost_ranges
	from gold.dim_products
)

select 
	cost_ranges,
	count(*) segment
	from cost_ranges
	group by cost_ranges
	order by segment desc

 
/*Group customers into three segments based on their spending behavior:
	- VIP: Customers with at least 12 months of history and spending more than €5,000.
	- Regular: Customers with at least 12 months of history but spending €5,000 or less.
	- New: Customers with a lifespan less than 12 months.
And find the total number of customers by each group
*/

with customer_spending AS(
	select 
		c.customer_key,
		sum(f.sales_amount) as total_spending,
		min(order_date) as first_order,
		max(order_date) as last_order,
		DATEDIFF(month,min(order_date),max(order_date)) as lifespan
	from gold.fact_sales f
	left join gold.dim_customers c
	on c.customer_key=f.customer_key
	group by c.customer_key
)
SELECT 
    customer_segment,
    COUNT(customer_key) AS total_customers
FROM (
    SELECT 
        customer_key,
        CASE 
            WHEN lifespan >= 12 AND total_spending > 5000 THEN 'VIP'
            WHEN lifespan >= 12 AND total_spending <= 5000 THEN 'Regular'
            ELSE 'New'
        END AS customer_segment
    FROM customer_spending
)t
GROUP BY customer_segment
ORDER BY total_customers DESC;




