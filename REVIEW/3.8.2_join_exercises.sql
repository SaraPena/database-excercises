/*Exercises
Create a file named '3.8.2_join_exercises.sql' to do your work in.

Join Example Database
1. Use the `join_example_db`. Select all of the records from both the `users` and `roles` tables. */

SHOW databases;
USE join_example_db;

SELECT * FROM roles;
SELECT * FROM users;

/*
3. Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. HINT: You will also need to use the `group by` in the query.
*/


SELECT role_id, roles.name, count(*) as count
FROM users
JOIN roles on roles.id = users.role_id
GROUP BY role_id;

/* Employees Database
1. Use the `employees` database.
*/
SHOW databases;
USE employees;

/* 
2. Write a query that shows each department along with the name of the current manager for that department.
*/

/*Current Managers*/
SELECT dept_manager.emp_no, dept_manager.dept_no, departments.dept_name as 'Department Name', CONCAT(first_name, ' ', last_name) as 'Department Manager'
FROM employees
JOIN dept_manager on dept_manager.emp_no = employees.emp_no
JOIN departments on departments.dept_no = dept_manager.dept_no
WHERE dept_manager.to_date > CURDATE()
ORDER BY dept_name;

/*
3. Find the name of all departments managed by women.
*/

SELECT departments.dept_name as Department_Name, CONCAT(first_name, ' ', last_name) as 'Manager Name'
FROM employees
JOIN dept_manager using (emp_no)
JOIN departments using(dept_no)
WHERE dept_manager.to_date > CURDATE() AND employees.gender = 'F'
ORDER BY Department_Name;

/*
4. Find the current titles of employees currently working in Customer Service department
*/

SELECT title, COUNT(*)
FROM departments as d
JOIN dept_emp as de using (dept_no)
JOIN titles as t using (emp_no)
WHERE t.to_date > CURDATE() AND de.to_date > CURDATE() AND d.dept_name = 'Customer Service'
GROUP BY title;

/*
5. Find the current salary of all current managers.
*/

SELECT dept_name, CONCAT(first_name, ' ', last_name) as Name, salary
FROM titles
JOIN salaries using (emp_no)
JOIN dept_emp using (emp_no)
JOIN employees using (emp_no)
JOIN departments using (dept_no)
WHERE title = 'Manager' AND titles.to_date > CURDATE() AND salaries.to_date > CURDATE()
ORDER BY dept_name;

/*
6. Find the number of employees in each department
*/

SELECT dept_no, dept_name, count(*) as num_employees
FROM dept_emp
LEFT JOIN departments using (dept_no)
WHERE to_date > CURDATE()
GROUP BY dept_no;

/*
7. Which department has the highest average salary.
*/

SELECT departments.dept_name, AVG(salary) as avg_salary
FROM salaries
JOIN dept_emp using (emp_no)
JOIN departments using (dept_no)
WHERE dept_emp.to_date > CURDATE() AND salaries.to_date > CURDATE()
GROUP BY dept_no
ORDER BY avg_salary DESC
LIMIT 1;

/*
8. Who is the highest paid employee in the Marketing department?
*/
SELECT emp_no, dept_name, first_name, last_name, salary, title
FROM employees
JOIN salaries using (emp_no)
JOIN dept_emp using (emp_no)
JOIN titles using (emp_no)
JOIN departments using (dept_no)
WHERE dept_name = 'Marketing' AND dept_emp.to_date > CURDATE() AND salaries.to_date > CURDATE()
ORDER BY salary DESC
LIMIT 1;

/*
9. Which current department manager has the highest salary?
*/

SELECT emp_no, first_name, last_name, title, salary
FROM titles
JOIN salaries using (emp_no)
JOIN employees using (emp_no)
WHERE title = 'Manager' AND titles.to_date > CURDATE() AND salaries.to_date > CURDATE()
ORDER BY salary DESC
LIMIT 1;

/*
10. BONUS: Find the names of all current employees, their department name, and their current managers name
*/

SELECT employee_name, ce.dept_name, manager_name

FROM (SELECT CONCAT(first_name, ' ', last_name) as employee_name, dept_name
	FROM employees
	JOIN dept_emp using (emp_no)
	JOIN departments using (dept_no)
	WHERE to_date > CURDATE()) as ce
	
LEFT JOIN (SELECT CONCAT(first_name, ' ', last_name) as manager_name, dept_name
		 FROM employees
		 RIGHT JOIN dept_manager using (emp_no)
		 JOIN departments using (dept_no)
		 WHERE to_date > CURDATE()) as mt on mt.dept_name = ce.dept_name;

/*
11. BONUS FIND THE HIGHEST PAID EMPLOYEE BY DEPARTMENT
*/

/*TAKE IT FURTHER: What is the frequency of gender amoung highest paid employees?*/
SELECT hp.gender, (count(*)/10)*100 as frequency

FROM (
	/*Create a table of employee number, max salary, deptarment name, employee name, and gender (alias name:hp)*/
	SELECT ce.emp_no, ms.max_salary, ms.dept_name, employee_name, gender
	FROM (
		/* Create a table of max salaries (alias_name: ms) */
		SELECT dept_name, dept_no, MAX(salary) as max_salary
		FROM salaries
		JOIN dept_emp using (emp_no)
		JOIN departments using (dept_no)
		WHERE salaries.to_date > CURDATE() AND dept_emp.to_date > CURDATE()
		GROUP BY dept_no) as ms

	LEFT JOIN(
		/*Create a table of all current employees with their 
		employee number,
		current salary,
		department number,
		name, 
		and gender (alias name: ce)*/
		SELECT emp_no, salary, dept_no, CONCAT(first_name, ' ', last_name) as employee_name, gender
		FROM salaries
		JOIN employees using (emp_no)
		LEFT JOIN dept_emp using (emp_no)
		WHERE salaries.to_date > CURDATE() AND dept_emp.to_date > CURDATE()) as ce ON ce.salary = ms.max_salary
	ORDER BY max_salary DESC) as hp
	
GROUP BY hp.gender;