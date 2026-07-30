 SELECT
 c.customerid,
 firstname || ' ' || COALESCE (lastname, ' ') AS fullname,
 c.country,
 c.score,
 o.totalorders
 FROM sales.customers AS c
 LEFT JOIN(
	SELECT
	customerid,
	COUNT(*) AS totalorders
	FROM sales.orders
	GROUP BY customerid) AS o
ON c.customerid = o.customerid
