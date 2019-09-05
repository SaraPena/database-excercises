-- Create a file named 3.8.2_join_exercises.sql to do your work in.


-- JOIN Example Database

-- 1. Use the join_example_db. Select all the records from both the users and roles tables. Created bayes_826 db with tables "roles", and "users"
Use bayes_826;
SELECT * FROM users;
SELECT * FROM roles;

-- 2. Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.

-- JOIN: JOIN roles ON users.role_id = roles.id. This will join the table basted on the role_id in the "users" table and id in the "roles" table. This will result in the users being matched to their role name.

SELECT users.name as user_name, roles.name as role_name, roles.id as role_id
FROM users
JOIN roles ON users.role_id = roles.id; 

-- LEFT JOIN: LEFT JOIN roles ON users.role_id = roles.id. This will take the data from users from the user table and join it to the roles table it will let us know if each user is maded to a role id. If the user role id is NULL we will see this result as a null role_name in the query.

SELECT users.name AS user_name, users.role_id as role_id, roles.name AS role_name
FROM users
LEFT JOIN roles ON users.role_id = roles.id;

-- RIGHT JOIN:RIGHT JOIN roles ON users.role_id = roles.id. This will join the users and roles table based on the roles.id. If a user does not have a role_id their name will show as null.
SELECT users.name AS user_name, roles.name AS role_name, roles.id, users.role_id
FROM users
RIGHT JOIN roles ON users.role_id = roles.id;

 -- 3. Although not excplicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will need to use the GROUP BY in the query.
 SELECT COUNT(users.role_id) as role_count, roles.name
 	FROM users
 	RIGHT JOIN roles ON users.role_id = roles.id
 	GROUP by users.role_id, roles.name;
 	
-- Employees Database

-- 1. Use the employees database.
Use employees;

-- 2. Using the example in the Associative Table Joins section as a guide write a query that shows each department along with the name of the CURRENT manager for that department.

SELECT departments.dept_name as department_name, CONCAT(employees.first_name, ' ', employees.last_name) AS full_name
FROM departments
JOIN dept_manager
	ON dept_manager.dept_no = departments.dept_no
JOIN employees
	ON employees.emp_no = dept_manager.emp_no
WHERE dept_manager.to_date = '9999-01-01'
ORDER BY departments.dept_name; 

-- 3. Find the name of all departments currently managed by women

SELECT departments.dept_name as department_name, CONCAT(employees.first_name, ' ', employees.last_name) AS full_name
FROM departments
JOIN dept_manager
	ON dept_manager.dept_no = departments.dept_no
JOIN employees
	ON employees.emp_no = dept_manager.emp_no
WHERE dept_manager.to_date = '9999-01-01' AND employees.gender = 'F'
ORDER BY departments.dept_name; 

-- 4. Find the current titles of employees currently working in the Customer Service department. 

SELECT titles.title, COUNT(*)
FROM departments
JOIN dept_emp
	ON dept_emp.dept_no = departments.dept_no
JOIN titles
	ON titles.emp_no = dept_emp.emp_no
WHERE titles.to_date = '9999-01-01' AND departments.dept_name = "Customer Service"
GROUP BY titles.title;

-- 5. Find the current salary of all current managers.

SELECT departments.dept_name as department_name, CONCAT(employees.first_name, ' ', employees.last_name) as full_name, salaries.salary as salary
FROM employees 
JOIN salaries
	ON salaries.emp_no = employees.emp_no
JOIN dept_manager
	ON dept_manager.emp_no = salaries.emp_no
JOIN departments
	ON departments.dept_no = dept_manager.dept_no
WHERE dept_manager.to_date = '9999-01-01' AND salaries.to_date = '9999-01-01'
GROUP by full_name, salary, departments.dept_name
ORDER BY department_name;

-- 6. Find the number of employees in each department. 

Select departments.dept_no as dept_no, departments.dept_name as dept_name, COUNT(*)
FROM employees
JOIN dept_emp
	ON dept_emp.emp_no = employees.emp_no
JOIN departments
	ON departments.dept_no = dept_emp.dept_no
WHERE dept_emp.to_date = '9999-01-01'
GROUP BY departments.dept_name
ORDER BY dept_no;

-- 7. Which department has the highest average salary?
Select AVG(salaries.salary) as average_salary, MAX(departments.dept_name) as dept_name
FROM salaries
JOIN dept_emp
	ON dept_emp.emp_no = salaries.emp_no
JOIN departments
	ON departments.dept_no = dept_emp.dept_no
WHERE dept_emp.to_date = '9999-01-01' AND salaries.to_date = '9999-01-01'
GROUP BY dept_name
ORDER BY average_salary DESC
LIMIT 1;

-- 7. Who is the highest paid employee in the Marketing department?

SELECT CONCAT(employees.first_name, ' ', employees.last_name) as full_name, salaries.salary
FROM employees 
JOIN salaries
	ON salaries.emp_no = employees.emp_no
JOIN dept_emp
	ON dept_emp.emp_no = salaries.emp_no
JOIN departments
	ON departments.dept_no = dept_emp.dept_no
WHERE salaries.to_date = '9999-01-01' AND dept_emp.to_date = '9999-01-01' AND departments.dept_name = 'Marketing'
ORDER BY salaries.salary DESC
LIMIT 1;

-- 9. Which current department manager has the highest salary?

SELECT CONCAT(employees.first_name, ' ', employees.last_name) as full_name, salaries.salary as salary, departments.dept_name as dept_name
FROM employees 
JOIN salaries
	ON salaries.emp_no = employees.emp_no
JOIN dept_manager
	ON dept_manager.emp_no = salaries.emp_no
JOIN departments
	ON departments.dept_no = dept_manager.dept_no
WHERE salaries.to_date = '9999-01-01' AND dept_manager.to_date = '9999-01-01' 
ORDER BY salary DESC
Limit 1;

-- BONUS: Find the names of all current employees, their department name, and their current manager's name.

SELECT CONCAT(employees.first_name, ' ', employees.last_name) as full_name, departments.dept_no, CONCAT(employees.first_name, ' ', employees.last_name) as manager_name
FROM employees 
JOIN salaries
	ON salaries.emp_no = employees.emp_no
JOIN dept_emp
	ON dept_emp.emp_no = salaries.emp_no
JOIN departments
	ON departments.dept_no = dept_emp.dept_no
WHERE salaries.to_date = '9999-01-01' AND dept_emp.to_date = '9999-01-01' AND departments.dept_name = 'Marketing'
ORDER BY salaries.salary DESC;


 




