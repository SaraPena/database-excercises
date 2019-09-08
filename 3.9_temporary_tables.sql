-- Create a file named 3.9_temporary_tables.sql to do your work for this exercise.

/*  -- 1. Using the example from the lesson, re-create the employees_with_departments table.
	a. Add column named full_name to this table. It should be a VARCHAR whole length is the sum of the lengths of the first name and last name columns. */
	
USE `bayes_826`;

CREATE TEMPORARY TABLE employees_with_departments 	(SELECT * FROM employees.employees as e
	 JOIN employees.dept_emp as de using (emp_no));
	 
SELECT * FROM employees_with_departments;

DESCRIBE employees_with_departments;

ALTER TABLE employees_with_departments ADD full_name VARCHAR(30);

-- b. Update the table so that full name column contains the correct data.

UPDATE employees_with_departments
SET full_name = CONCAT(first_name, ' ', last_name);

-- c. remove the first_name and last_name columns from the table.
ALTER TABLE employees_with_departments DROP COLUMN first_name;
ALTER TABLE employees_with_departments DROP COlUMN last_name;

-- d. What is another way you could have ended up with the same table?

CREATE TEMPORARY TABLE employees_with_departments2
(SELECT emp_no, birth_date, gender, hire_date, dept_no, from_date,to_date, CONCAT(first_name, ' ', last_name) as full_name 
 FROM employees.employees as e
 JOIN employees.dept_emp as de using (emp_no));
 
SELECT * FROM employees_with_departments2;

DROP TABLE employees_with_departments2;

-- 2. Create a temporary table based on the payment table from sakila database. Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of centers for the payment. For example,1.99 should become 199.

USE bayes_826;

CREATE TEMPORARY TABLE payment AS
(SELECT *
 FROM sakila.payment);

SELECT * FROM payment;

ALTER TABLE payment ADD amount2 INT(4);
UPDATE payment
SET amount2 = amount*100;

ALTER TABLE payment DROP COLUMN amount;

ALTER TABLE payment Change amount2 amount int(4);


-- 3. Find out how the average pay in each department compares to the overall average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department to work for? the worst?

USE bayes_826;

CREATE TEMPORARY table department_salaries AS
	(SELECT dept_name as dept_name, 
		(AVG(salary) 
		- (SELECT AVG(salary)
		   FROM employees.salaries
		   WHERE to_date = '9999-01-01'))
		/ (SELECT STD(salary)
		   FROM employees.salaries
		   WHERE to_date = '9999-01-01') 
		   as salary_z_score
FROM employees.salaries
JOIN employees.dept_emp using (emp_no)
JOIN employees.departments using (dept_no)
WHERE salaries.to_date = '9999-01-01'
GROUP BY dept_name);

select * FROM department_salaries;

DROP TABLE department_salaries; 

-- --------------------------
-- BREAK IT DOWN -----

CREATE TEMPORARY table average_salaries AS
	SELECT dept_name as dept_name, 
		AVG(salary) 
		FROM employees.salaries
JOIN employees.dept_emp using (emp_no)
JOIN employees.departments using (dept_no)
WHERE salaries.to_date = '9999-01-01'
GROUP BY dept_name;




-- ----- BREAK IT DOWN END//

-- 4. What is the average salary for an employee based on the number of years they have been with the company? Express your answer in terms of Z-score of salary. Since this date is a little older, scale the years of experice by subtracting the minimum from every row.
USE bayes_826;

CREATE TEMPORARY TABLE years_z_score AS
(SELECT ROUND((DATEDIFF(NOW(),e.hire_date)/365)-20) as years, (AVG(salary) 
		- (SELECT AVG(salary)
		   FROM employees.salaries
		   WHERE to_date = '9999-01-01'))
		/ (SELECT STD(salary)
		   FROM employees.salaries
		   WHERE to_date = '9999-01-01') 
as average_salary
FROM employees.employees as e
JOIN employees.salaries as s using (emp_no)
WHERE s.to_date = '9999-01-01'
GROUP by years
ORDER BY years);

SELECT * FROM years_z_score;
--








