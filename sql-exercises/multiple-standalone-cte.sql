--Find the total sales per customer (Standalone CTE)
WITH CTE_total_sales AS
(
SELECT
	customerid,
	SUM(sales) AS totalsales
FROM sales.orders
GROUP BY customerid
)

--Find the last order date for each customer (Standalone CTE)
,CTE_last_order AS 
(
SELECT 
	customerid,
	MAX(TO_CHAR(orderdate,'dd-mm-yyyy')) AS last_order
FROM sales.orders
GROUP BY customerid
)

--Main Query
SELECT
	c.customerid,
	c.firstname,
	COALESCE (c.lastname, '-'),
	cts.totalsales,
	clo.last_order
FROM sales.customers AS c
LEFT JOIN CTE_total_sales AS cts
ON cts.customerid = c.customerid
LEFT JOIN CTE_last_order AS clo
ON clo.customerid = c.customerid
