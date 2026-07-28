SELECT
	customerid,
	firstname || ' ' || COALESCE(lastname,'')
	AS FullName,
	country,
	
	CASE country
		WHEN 'Germany' THEN 'DE'
		WHEN 'USA' THEN 'US'
		ELSE 'n/a'
	END countryabbrv,
	COALESCE(score,0) AS score,
	10 AS Bonus,
	COALESCE(score,0) +10 AS score_after_bonus,
	
	RANK() OVER(ORDER BY COALESCE(score,0) DESC ) AS leaderboard_position
FROM 
	sales.customers;