/*Exercises
Create a file named 3.8.3_subqueries_exercises.sql and craft queries to return the results for the following criteria
*/

SHOW databases;
USE employees;

/*
1. Find all of employees with the same hire date as employee `101010` using a sub-query.
*/

SELECT CONCAT(first_name, ' ', last_name) as full_name, hire_date
FROM employees
WHERE hire_date in (SELECT hire_date FROM employees WHERE emp_no = '101010');

/*
2. Find all the titles held by all employees with the first name Aamod*/

SELECT title, count(*) as count
FROM titles
LEFT JOIN employees using (emp_no)
WHERE first_name = (SELECT DISTINCT first_name FROM employees WHERE first_name = 'Aamod')
GROUP BY title
ORDER BY count;

/*
3. How many people from the employees table are no longer working for the company?
*/

SELECT count(*)
FROM employees
JOIN salaries using (emp_no)
WHERE to_date < (SELECT DISTINCT to_date FROM titles WHERE to_date > CURDATE());

/*
4. Find the current department managers that are female.
*/

SELECT CONCAT(first_name, ' ', last_name) as manager_name, dept_name
FROM dept_manager
LEFT join departments using (dept_no)
LEFT JOIN employees using (emp_no)
WHERE to_date = (SELECT DISTINCT to_date FROM dept_manager WHERE to_date > CURDATE()) AND gender = (SELECT DISTINCT gender FROM employees where gender = 'F');

/*Find all employees who have a higher than average salary*/
SELECT first_name, last_name, salary
FROM employees
JOIN salaries using (emp_no)
WHERE to_date = (SELECT DISTINCT to_date FROM salaries WHERE to_date > CURDATE()) AND salary > (SELECT AVG(salary) FROM salaries);

/*How many current salaries are within 1 standard deviation of the highest salary? What percentage of salaries is this?*/

SELECT (SELECT count(*)
FROM salaries
WHERE salary >= (SELECT MAX(salary) - STD(salary) from salaries) and to_date > CURDATE()) /(SELECT count(*)
FROM salaries
WHERE to_date > CURDATE());

/* BONUS: Find the fist and last name of the highest paid employee, and their department, and gender*/

SELECT first_name, last_name, gender, dept_name, hire_date, title, birth_date, salary
FROM employees
LEFT JOIN salaries using (emp_no)
LEFT JOIN dept_emp using (emp_no)
LEFT JOIN titles using (emp_no)
LEFT JOIN departments using (dept_no)
WHERE salary = (SELECT MAX(salary) FROM salaries) and salaries.to_date = (SELECT DISTINCT to_date FROM salaries WHERE to_date >CURDATE()) and titles.to_date > CURDATE();