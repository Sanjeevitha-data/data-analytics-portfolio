SELECT
	*,
	CASE
		WHEN Buckets =1 THEN 'High'
		WHEN Buckets =2 THEN 'Medium'
		WHEN Buckets =3 THEN 'Low'
	END SalesSegmentations
FROM(
	SELECT
		orderid,
		sales,
		NTILE(3) OVER(ORDER BY sales DESC) AS Buckets
	FROM sales.orders
)t;