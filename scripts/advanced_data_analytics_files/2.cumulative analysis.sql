--CUMULATIVE ANALYSIS

select 
	order_date,
	total_sales,
	sum(total_sales) over(partition by order_date order by order_date) running_total_sales 
	from(
		SELECT 
			DATETRUNC(month,order_date) as order_date,
			sum(sales_amount) as total_sales
			from gold.fact_sales
			where order_date is not null
			group by DATETRUNC(month,order_date)
			)t

	
------------==============================================================-

WITH monthly_sales AS (
    SELECT
        CAST(DATEFROMPARTS(YEAR(order_date), MONTH(order_date), 1) AS DATE) AS month_start,
        SUM(sales_amount) AS total_sales
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY YEAR(order_date), MONTH(order_date)
)
SELECT
    month_start,
    total_sales,
    SUM(total_sales) OVER (
        PARTITION BY YEAR(month_start)
        ORDER BY month_start
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total_sales
FROM monthly_sales
ORDER BY month_start;
