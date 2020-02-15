/*EXERCISES
Create a file named 3.10_case_exercises.sql and craft queries to return the results for the following criteria:

1. Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and a 0 if they are not.
*/

SHOW databases;
USE employees;

SELECT *, IF (to_date > CURDATE(), 1, 0) as is_current_employee
FROM dept_emp;

/*
2. Write a query that returns all employees names, and an 'alpha_group' that returns 'A-H', 'I-Q' or 'R-Z' depending on the first letter of their last name.
*/

SELECT CONCAT(first_name, ' ', last_name) as full_name,
		CASE
			WHEN last_name REGEXP '^[A-H]' THEN 'A-H'
			WHEN last_name REGEXP '^[I-Q]' THEN 'I-Q'
			ELSE 'R-Z'
			END AS alpha_group
FROM employees;

/*
3. How many employees where born in each decade?
*/

SELECT decade, count(*) 
FROM (SELECT YEAR(birth_date),
	CASE 
		WHEN YEAR(birth_date) between '1950' AND '1959' then '50\'s'
		WHEN YEAR(birth_date) between '1960' AND '1969' then '60\'s'
		WHEN YEAR(birth_date) between '1970' AND '1979' then '70\'s'
		WHEN YEAR(birth_date) between '1980' AND '1989' then '80\'s'
		ELSE 0
		END as decade
FROM employees) as bd
GROUP BY decade;

/*
BONUS
1. What is the average salary for each of the following department groups: R&D, Sales and Marketing, Prod and QM, Finance & HR, Customer Service?
*/

SELECT dept_group, AVG(salary) as average_salary
FROM dept_emp
LEFT JOIN departments using (dept_no)
LEFT JOIN (SELECT dept_name,
        CASE 
            WHEN dept_name IN ('research', 'development') THEN 'R&D'
            WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing' 
            WHEN dept_name in ('Production', 'Quality Management') THEN 'Prod & QM'
            ELSE dept_name
            END AS dept_group
FROM employees.departments) as groups using (dept_name)
LEFT JOIN salaries using (emp_no)
WHERE salaries.to_date > CURDATE() AND dept_emp.to_date > CURDATE()
GROUP BY dept_group;

SELECT COUNT(*)
FROM dept_emp
WHERE to_date > CURDATE();