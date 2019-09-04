 -- 1. Copy the order by exercise and save it as 3.6_functions_exercises.sql
 
 -- 2. Update your queries for employees who names start and end with 'E'. Use concat() to combine their first and last name together as a single column named full_name.
 -- 3. Convert the names produced in your last query to all uppercase.
 
 USE employees;
 Select UPPER(Concat(first_name,' ',last_name)) as full_name from employees where last_name like '%E' AND last_name like 'E%';
 
-- 4. For your query of employees born on Christmas and hired in the 90s, use datediff() to find out how many days they have been working at the company. (HINT: you will also need to use NOW() or CURDATE()).

SELECT datediff(NOW(),hire_date), hire_date FROM employees 
	WHERE (hire_date BETWEEN '1990-01-01' AND '1999-12-31') 
		AND (birth_date LIKE '%12-25%')
		ORDER BY birth_date, hire_date DESC;
-- 5. Find the smallest and largest salary from the salaries table. 
Select min(salary), max(salary) from salaries;

-- 6. Use your knowledge of built in SQL functions to generate a username for all the employees. A username should be all lowercase, and consist of the first character of the employees first name, the first 4 character of the employees last name, an underscore, the month the employee was born, and the last two digits of the year that they were born.
Select lower(CONCAT(
	SUBSTR(first_name,1,1), 
	SUBSTR(last_name,1,4), "_", 
	SUBSTR(birth_date,6,2), 
	SUBSTR(birth_date,3,2))) 
	as username from employees;

 

