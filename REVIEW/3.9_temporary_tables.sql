/*Exercises
Create a file named 3.9_temporary_tables.sql to do your work for this exercise

1. Using the example from this lesson, re-create the employees_with_departments table.
	a. add a columns named `full_name` to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns.
*/

SHOW databases;
USE employees;
USE sakila;
USE bayes_826;

CREATE TEMPORARY TABLE employees_with_departments(
SELECT CONCAT(first_name, ' ', last_name) as full_name
FROM employees.employees);

DESCRIBE employees_with_departments;

/*
2. Create a temporary table based off the `payments` table in the `sakila` database.

Write the SQL necessary to transform the `amount` column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.
*/

CREATE TEMPORARY TABLE payments(
SELECT amount
FROM sakila.payment);

DESCRIBE payments;

SELECT *
FROM payments;

ALTER TABLE payments ADD amount_100 INT;


UPDATE payments
SET amount_100 = amount*100.00;


ALTER TABLE payments DROP amount;
ALTER TABLE payments CHANGE COLUMN amount_100 amount INT NOT NULL;

DESCRIBE payments;

SELECT *
FROM payments;


/*
3. Find out how the average pay in each department compares to the overall average pay. In order to make the comparison easier, you should use the z score for salaries. In terms of salary what is the best department to work for?
*/

USE employees;

SELECT dept_name, (AVG(salary) - (SELECT AVG(salary) FROM salaries WHERE salaries.to_date > CURDATE()))/(SELECT STD(salary) FROM salaries WHERE salaries.to_date > CURDATE()) as salary_z_score
FROM salaries
LEFT JOIN dept_emp using (emp_no)
LEFT JOIN departments using (dept_no)
WHERE dept_emp.to_date > CURDATE() and salaries.to_date > CURDATE()
GROUP BY dept_no
ORDER BY dept_name;
