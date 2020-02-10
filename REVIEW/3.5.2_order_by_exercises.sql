
/*Exercises
1. Create a file named 3.5.2_order_by_exercises.sql make sure to `use` the `employees` database. Copy the contents of your exercise from the previous lesson.
*/
SHOW databases;
USE employees;

/*2a. Find all the employees with the first names `Irena`, `Vidya`, or `Maya`.
  2b. Modify your first query to order by first_name. The result should be Irena Reutenauer and the last result should be Vidya Simmen.*/

SELECT emp_no, first_name, last_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name;

/* 3. Update the query to order by first name, and then last name. The first result should now be Irena Acton, and the last should be Vidya Zweizig*/
SELECT emp_no, first_name, last_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name, last_name;

/* 4. Change the order by clause so that you order by last name before first name. Your first result should still be Irena Acton but now the last result should be Maya Zyda.*/
SELECT emp_no, first_name, last_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name;


/*5a. Find all employees whose last name starts with 'E'.
  5b. Update your queries for employees with 'E' in their last name to sort the results by their employee number. Your results should not change!
 */

SELECT emp_no, last_name, first_name
From employees
WHERE last_name LIKE '%E%'
ORDER BY emp_no;

/* 6. Now reverse the sort order for both queries.*/

SELECT emp_no, first_name, last_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name DESC;

SELECT emp_no, first_name, last_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name DESC;

SELECT emp_no, first_name, last_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name DESC;

SELECT emp_no, first_name, last_name
FROM employees
WHERE last_name LIKE '%E%'
ORDER BY emp_no DESC;



/* 7a. Find all employees hired in the 90s and born on Chirstmas.
   7b. Change the query for employees hired in the 90s and born on Christmas such that the first result is the OLDEST employee who was hired LAST. It should be Khun Bernini.*/

SELECT emp_no, first_name, last_name, birth_date, hire_date
FROM employees
WHERE (hire_date BETWEEN '1990-01-01' AND '1999-12-31') AND (birth_date LIKE '%-12-25')
ORDER BY birth_date, hire_date DESC; 