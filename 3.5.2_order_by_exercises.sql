-- 1. Create a file named 3.5.2_order_by_exercises.sql and copy in the contents of your exercise from the previous lesson (3.5.1_where_exercises).
-- 1(3.5.1). Create a file named 3.5.1_where_exercises.sql Make sure to use the employees database.
-- 
USE employees;

-- 2(3.5.1). Find all employees with first names  'Irena', 'Vidya' or 'Maya' - 709 rows.
-- 2. Modify your first query to order by first name. The first result should be Irena Reutenauer and the last result should be Vidya Simmen
SELECT * FROM employees;
SELECT first_name, last_name 
	FROM employees 
		WHERE first_name IN ('Irena', 'Vidya', 'Maya')
		ORDER BY first_name;

-- 3. Update the query to order by first name and then last name. The first result should now be Irena Action and the last should be Vidya Zweizig.
SELECT first_name, last_name 
	FROM employees 
		WHERE first_name IN ('Irena', 'Vidya', 'Maya')
		ORDER BY first_name,last_name;
		
-- 4. Change the order by clause so that you order by last name before first name. Your first result should still be Irena Acton but now the last result should be May Zyda.
SELECT *
	FROM employees 
		WHERE first_name IN ('Irena', 'Vidya', 'Maya')
		ORDER BY last_name,first_name;

		

-- 5. Update your queries for employees with 'E' in their last name to sort the results by their employee number. Your result should NOT change!
-- 3(3.5.1). Find all employees whose last name starts with or ends with 'E' - 7,330 rows.
describe `employees`; -- find employee number column name
SELECT emp_no, first_name, last_name 
	FROM employees 
		WHERE last_name LIKE 'E%'
		ORDER BY emp_no;

-- 6. Now reverse the sort order for both queries
SELECT *
	FROM employees 
		WHERE first_name IN ('Irena', 'Vidya', 'Maya')
		ORDER BY last_name DESC,first_name DESC;
		
SELECT emp_no, first_name, last_name 
	FROM employees 
		WHERE last_name LIKE 'E%'
		ORDER BY emp_no DESC;


-- 7. Change the query for employees hired in the 90s and born on Christmas such that the first result is the OLDEST employee who was hired LAST. It should be Khun Bernini.
-- Find all employees hired in the 90s and born on Christmas. 362 rows.

SELECT * FROM employees 
	WHERE (hire_date BETWEEN '1990-01-01' AND '1999-12-31') 
		AND (birth_date LIKE '%12-25%')
		ORDER BY birth_date, hire_date DESC;
	

