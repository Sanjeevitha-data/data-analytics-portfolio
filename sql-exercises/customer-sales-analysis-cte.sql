--Customer sales analysis using Standalone CTE's and Nested CTE
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

--Rank Customers based on total sales per customer(Nested CTE)
,CTE_customer_rank AS
(
SELECT
	customerid,
	totalsales,
	RANK() OVER (ORDER BY totalsales DESC) AS customerrank
FROM CTE_total_sales
)

--Segment customers based on their total sales (Nested CTE)
,CTE_customer_segments AS
(
SELECT
	customerid,
	CASE 
		WHEN totalsales > 100 THEN 'High'
		WHEN totalsales >80 THEN 'Medium'
		ELSE 'Low'
	END customersegments
FROM CTE_total_sales
)

--Main Query
SELECT
	c.customerid,
	c.firstname,
	COALESCE (c.lastname, '-') AS lastname,
	cts.totalsales,
	clo.last_order,
	ccr.customerrank,
	ccs.customersegments
FROM sales.customers AS c
LEFT JOIN CTE_total_sales AS cts
ON cts.customerid = c.customerid
LEFT JOIN CTE_last_order AS clo
ON clo.customerid = c.customerid
LEFT JOIN CTE_customer_rank AS ccr
ON ccr.customerid = c.customerid
LEFT JOIN CTE_customer_segments AS ccs
ON ccs.customerid = c.customerid;
