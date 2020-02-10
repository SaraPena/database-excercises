/*
Exercises
1. Copy the order by exercise and save it as 3.6_functions_exercises.sql.

2. Update your queries for employees whose names start and end with 'E'. Use 'concat()' to combine their first and last name together as a single column named `full_name`. 
*/
SHOW databases;
Use employees;

SELECT concat(first_name,' ', last_name) as full_name
FROM employees
WHERE last_name LIKE 'e%e';

/* 3. Convert the names produced in your last query to all uppercase*/

SELECT UPPER(concat(first_name, ' ', last_name)) as full_name
FROM employees
WHERE last_name LIKE 'e%e';

/* 4. For your query of employees born on Christmas and hired in the 90s use datediff() to find how many days they have been working at that company (HINT: you'll also need to use NOW() or CURDATE()) */

SELECT emp_no, first_name, last_name, birth_date, hire_date, datediff(CURDATE(), hire_date) as days_worked
FROM employees
WHERE (hire_date BETWEEN '1990-01-01' and '1999-12-31') AND (birth_date LIKE '%-12-25');

/* 5. Find the smallest and the largest salary from the `salaries` table*/

SELECT MAX(salary) as max_salary, MIN(salary) as min_salary
FROM salaries;

/* 6. Use your knowledge of built-in SQL functions to generate a username for all of the employees. A username should be all lowercase, and consist of the first character of the employees first name, and the first 4 characters of the employees last name, an underscore, the month the employee was born, and the last two digits of the year that they were born.
*/

/* first 4 character, last name.*/
SELECT CONCAT(lower(SUBSTR(first_name, 1,1)), lower(SUBSTR(last_name, 1, 4)), '_', DATE_FORMAT(birth_date, '%m%y')) as username, first_name, last_name, birth_date
FROM employees;