-- 1. Create a new file named 3.7_group_by_exercises.sql.
USE employees;

-- 2. In your script, use DISTINCT to find the unique titles in the titles table.
SELECT DISTINCT title FROM titles;

-- 3. Find your query for employees whose last names start AND end with 'E'. Update the query find just the unique last names that start and end with 'E' using GROUP By.

SELECT last_name 
	FROM employees
	WHERE last_name LIKE 'e%e'
	GROUP BY last_name;

-- 4. Update your previous query to now find the unique combinations of first and last name where the last name starts and end with 'E'. You should get 846 rows.

SELECT DISTINCT first_name, last_name 
	FROM employees
	WHERE last_name LIKE 'e%e'
	GROUP BY last_name, first_name;
	
-- 5. Find the unique last names with a 'q' but not 'qu'.
SELECT DISTINCT last_name
	FROM employees
	WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';
	
-- 6. Add a COUNT() to your results and use ORDER BY to make it easier to find employees whose unusual name is shared with others.
SELECT DISTINCT last_name, COUNT(last_name)
	FROM employees
	WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'
	GROUP BY last_name;

-- 7. Update your query for 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.
SELECT * FROM employees;
SELECT  CONCAT( count(gender)," ", gender) as count_gender
	FROM employees 
	WHERE first_name IN ('Irena', 'Vidya', 'Maya')
	GROUP BY gender;
	
-- 8. Recall the query that generated usernames for the employees from the last lesson. Are there any duplicate usernames? BONUS: How many duplicate usernames are there?
	
Select COUNT(DISTINCT (lower(CONCAT(
	SUBSTR(first_name,1,1), 
	SUBSTR(last_name,1,4), "_", 
	SUBSTR(birth_date,6,2), 
	SUBSTR(birth_date,3,2)))))
	as username_distinct, count(*) as all_records from employees
	;
	
	

