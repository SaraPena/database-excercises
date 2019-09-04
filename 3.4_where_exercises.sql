-- 1. Create a file named 3.5.1_where_exercises.sql Make sure to use the employees database.
USE employees;

-- 2. Find all employees with first names  'Irena', 'Vidya' or 'Maya' - 709 rows.
SELECT * FROM employees;
SELECT first_name, last_name FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya');

-- Find all employees whose last name starts with or ends with 'E' - 7,330 rows.
SELECT first_name, last_name FROM employees WHERE last_name LIKE 'E%';

-- Find all employees hired in the 90s - 135,214
describe employees;
SELECT * FROM employees WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31';

-- Find all employees born on Christmas. 842 rows.
Select * FROM employees;
Select * FROM employees WHERE birth_date LIKE '%12-25%';

-- Find all employees with a 'q' in their last name. 1873 rows.
SELECT * FROM employees WHERE last_name LIKE '%q%';

-- Update your query for 'Irena', 'Vidya' or 'Maya' to use OR instead of IN rows. 709 rows.
 SELECT first_name, last_name FROM employees WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya';
 
-- Add a condition to the previous query to find everybody with those names who is also male. 441 rows.

SELECT first_name,last_name,gender FROM employees WHERE (first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya') AND gender = 'M';

-- Find all employees whose last name starts or ends with 'E'. 30,723
SELECT * FROM employees WHERE last_name LIKE '%E' OR last_name LIKE 'E%';

-- Duplicate the previous query and update it to find all employees whose last name starts AND ends with 'E'. 899 rows.

SELECT * FROM employees WHERE last_name LIKE '%E' AND last_name LIKE 'E%';

SELECT * FROM employees WHERE last_name LIKE 'E%E';

-- Find all employees hired in the 90s and born on Christmas. 362 rows.

SELECT * FROM employees WHERE (hire_date BETWEEN '1990-01-01' AND '1999-12-31') AND (birth_date LIKE '%12-25%');
 

-- Find all employees with a 'q' in their last name but NOT 'qu' - 547.
SELECT * FROM employees WHERE last_name 
	LIKE '%q%' AND last_name NOT LIKE '%qu%';

