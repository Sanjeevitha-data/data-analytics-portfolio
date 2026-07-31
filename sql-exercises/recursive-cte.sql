--Task: Show the employee hierarchy by displaying each employee's level within the organization
WITH RECURSIVE CTE_Emp_Hierarchy AS 
(
	--Anchor Query
	SELECT
		employeeid,
		firstname,
		managerid,
		1 AS Level
	FROM sales.employees
	WHERE managerid IS NULL
	UNION ALL
	--Recursive Query
	SELECT
		e.employeeid,
		e.firstname,
		e.managerid,
		Level + 1
	FROM sales.employees AS e
	INNER JOIN CTE_Emp_Hierarchy AS ceh
	ON e.managerid = ceh.employeeid
)

--Main Query
SELECT
*
FROM CTE_Emp_Hierarchy;