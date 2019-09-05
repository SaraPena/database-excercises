-- 1. Create a new SQL script named 3.5.3_limit_exercises.sql.
USE employees;
-- 2. MySQL provides a way to return only unique results from our queries with the keyword DISTINCT.List the first 10 distinct last name sorted in descending order. 
SELECT DISTINCT last_name 
	FROM employees
		ORDER BY last_name DESC
		LIMIT 10;
		
-- 3. Find your query for employees born on Christmas and hired in the 90s from order_by_exercises.sql. Update it to find just the first 5 employees. 
SELECT * FROM employees 
	WHERE (hire_date BETWEEN '1990-01-01' AND '1999-12-31') 
		AND (birth_date LIKE '%12-25%')
		ORDER BY birth_date, hire_date DESC
		Limit 5;

-- 4. Try to think of your results as batches, sets, or pages. The first five results are your first page. The five after that would be your second page, etc. Update the query to find the tenth page of results.
SELECT * FROM employees 
	WHERE (hire_date BETWEEN '1990-01-01' AND '1999-12-31') 
		AND (birth_date LIKE '%12-25%')
		ORDER BY birth_date, hire_date DESC
		Limit 5 Offset 45;
