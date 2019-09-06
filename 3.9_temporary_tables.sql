-- Create a file named 3.9_temporary_tables.sql to do your work for this exercise.

/*  -- 1. Using the example from the lesson, re-create the employees_with_departments table.
	a. Add column named full_name to this table. It should be a VARCHAR whole length is the sum of the lengths of the first name and last name columns. */
	
USE `bayes_826`;

CREATE TEMPORARY TABLE employees_with_departments 	(SELECT * FROM employees.employees as e
	 JOIN employees.dept_emp as de using (emp_no));
	 
SELECT * FROM employees_with_departments;

DESCRIBE employees_with_departments;

ALTER TABLE employees_with_departments ADD full_name VARCHAR(30);

UPDATE employees_with_departments
SET full_name = CONCAT(first_name, ' ', last_name);
	
