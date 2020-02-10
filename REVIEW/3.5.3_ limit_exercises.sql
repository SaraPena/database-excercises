
/*Exercises
1. Create a new SQL script named 3.5.3_limit_exercises.sql.
*/
SHOW databases;
USE employees;

/* 
2. MySQL provides a way to return only unique results from our queries using the keyword DISTINCT. For example, to find all the unique titles within the company we could run the following query:
*/

SELECT DISTINCT title
FROM titles;

/* List the first 10 distinct last name sorted in descending order.*/

SELECT DISTINCT last_name
FROM employees
ORDER by last_name DESC
LIMIT 10;

/* 3a. Find all employees hired in the 90s and born on Chirstmas.
   3b. Change the query for employees hired in the 90s and born on Christmas such that the first result is the OLDEST employee who was hired LAST. It should be Khun Bernini.
   3c. Find your query for employees born on Christmas and hired in the 90s from order_by_exercises.sql. Update it to find just the first 5 employees.*/

SELECT emp_no, first_name, last_name, birth_date, hire_date
FROM employees
WHERE (hire_date BETWEEN '1990-01-01' AND '1999-12-31') AND (birth_date LIKE '%-12-25')
ORDER BY birth_date, hire_date DESC
LIMIT 5; 

/*
4. Try to think of your results as batches, sets, or pages. The first five results are your first page. The five after that is your second page, etc. Update your query to find the tenth page of results.
*/

SELECT emp_no, first_name, last_name, birth_date, hire_date
FROM employees
WHERE (hire_date BETWEEN '1990-01-01' AND '1999-12-31') AND (birth_date LIKE '%-12-25')
ORDER BY birth_date, hire_date DESC
LIMIT 5 OFFSET 45; 