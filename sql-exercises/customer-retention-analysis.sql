SELECT
customerid,
ROUND (AVG(daysuntilnextorder),1) AS avgdays,
RANK() OVER(ORDER BY ROUND (AVG(daysuntilnextorder),1) ASC NULLS LAST) AS rank_avg
FROM(
SELECT 
    orderid, 
    customerid, 
    orderdate AS currentorder, 
    LEAD(orderdate) OVER(PARTITION BY customerid ORDER BY orderdate) AS nextorder, 
    (LEAD(orderdate) OVER(PARTITION BY customerid ORDER BY orderdate))::date - orderdate::date AS daysuntilnextorder 
FROM sales.orders 
)t
GROUP BY customerid
