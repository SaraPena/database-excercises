-- Create a file named 3.8.3_subqueries_exercises.sql and craft queries to return the results of the following criteria.

-- 1. Find all the employees with the same hire date as employee 101010 using a sub-query. 69 rows.

USE employees;
SELECT CONCAT(e.first_name, ' ', e.last_name), e.hire_date
FROM employees as e
WHERE e.hire_date 
	IN(
		SELECT e.hire_date
		FROM employees as e
		WHERE e.emp_no = 101010);
		
 -- 2. Find all the titles held by all employees with the first name Aamod.
 
SELECT CONCAT(e.first_name, ' ', e.last_name), t.title
FROM employees as e
JOIN titles as t
	ON t.emp_no = e.emp_no
WHERE e.first_name 
	IN(
		SELECT e.first_name
		FROM employees as e
		WHERE e.first_name LIKE 'Aamod');
		
SELECT COUNT(DISTINCT title), COUNT(*)
FROM employees as e
JOIN titles as t
	ON t.emp_no = e.emp_no
WHERE e.first_name 
	IN(
		SELECT e.first_name
		FROM employees as e
		WHERE e.first_name LIKE 'Aamod');
		
 -- 3. How many  people in the employees table are no longer working for the company?
 
 SELECT COUNT(*)
 FROM employees
  WHERE emp_no
 	NOT IN(
 			SELECT emp_no
 			FROM dept_emp as de
 			WHERE to_date = '9999-01-01');
 			
 SELECT COUNT(*)
 FROM employees;
 
 SELECT COUNT(*)
 FROM dept_emp;
 			
-- 4. Find all the current department manager that are female.

-- WITHOUT A SUBQUERY:
SELECT CONCAT(e.first_name, ' ', e.last_name), d.dept_name, e.emp_no
FROM employees as e
JOIN dept_manager as dm
	ON dm.emp_no = e.emp_no
JOIN departments as d
	ON d.dept_no = dm.dept_no
WHERE e.gender LIKE 'F' and dm.to_date = '9999-01-01';

-- WITH A SUBQUERY
SELECT CONCAT(e.first_name, ' ', e.last_name) as full_name, e.emp_no as employee_no, d.dept_name as department_name
from employees as e
JOIN dept_manager as dm
	ON dm.emp_no = e.emp_no
JOIN departments as d
	ON d.dept_no = dm.dept_no
WHERE e.emp_no 
	IN (
		SELECT e.emp_no
		FROM employees
		WHERE e.gender LIKE 'F')
	AND dm.to_date = '9999-01-01';

-- 5. Find all the employees that currently have a highter than average salary. 154543 rows in total 

SELECT CONCAT(e.first_name, ' ', e.last_name) as full_name, s.salary as salary
FROM employees as e
JOIN salaries as s
	ON e.emp_no = s.emp_no
WHERE s.salary > (SELECT AVG(s.salary)
				  FROM salaries as s) 
	  AND s.to_date = '9999-01-01'; 

-- 6. How many current salaries are with 1 standard deviation of the hightest salary? (HINT you can use a built in function to calculate the standard deviation. What percentage of all salaries is this?

SELECT COUNT(salary), (COUNT(salary)/(SELECT COUNT(*) FROM salaries WHERE to_date = '9999-01-01'))*100
FROM salaries
WHERE salary > 
		(SELECT MAX(salary) - STDDEV(salary)
		FROM salaries)
	AND to_date = '9999-01-01';

