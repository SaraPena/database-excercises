
/*Exercises
1. Create a file named 3.5.1_where_exercises.sql make sure to `use` the `employees` database.
*/
USE employees;

/*2. Find all the employees with the first names `Irena`, `Vidya`, or `Maya`. */

SELECT emp_no, first_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya');

/*3. Find all employees whose last name starts with 'E'.*/

SELECT emp_no, last_name
From employees
WHERE last_name LIKE 'E%';

/*4. Find all employees who were hired in the 90'.*/

SELECT emp_no, last_name,hire_date
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'; 

/*5. Find all employees who were born on Christmas.*/

SELECT emp_no, first_name, last_name, birth_date
FROM employees
WHERE birth_date LIKE '%-12-25';

/* 6. Find all employees with q in their last name. */

SELECT emp_no, first_name, last_name
FROM employees
WHERE last_name LIKE '%q%';

/* 7. Update your query for 'Irena','Vidya', or 'Maya' to use `OR` instead of `IN`.*/
SELECT emp_no, first_name, last_name
FROM employees
WHERE first_name = 'Irena' 
	  OR 
	  first_name = 'Maya' 
	  OR 
	  first_name = 'Vidya';
	  
/*8. Add a condition to the previous query to find everybody with those names who is also male.*/

SELECT emp_no, first_name, last_name, gender
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya') AND gender = 'M';

/*9. Find all employees whose last name starts or ends with 'E'.*/

SELECT emp_no, last_name
FROM employees 
WHERE last_name LIKE 'e%' OR (last_name LIKE '%e');

/* 10. Duplicate the previous query and update it to find all employees whose last name starts and ends with 'E'.*/

SELECT emp_no, first_name, last_name
FROM employees
WHERE last_name LIKE 'e%e';

/* 11. Find all employees hired in the 90s and born on Chirstmas.'*/

SELECT emp_no, first_name, last_name, birth_date, hire_date
FROM employees
WHERE (hire_date BETWEEN '1990-01-01' AND '1999-12-31') AND (birth_date LIKE '%-12-25'); 

/* 12. Find all employees with a 'q' in their `last_name` but NOT 'qu'.*/

SELECT last_name
FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';