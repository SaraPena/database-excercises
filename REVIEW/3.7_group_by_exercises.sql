/*
Exercises
1. Create a new file named `3.7_group_by_exercises.sql`

2. In your script, use DISTINCT to find the unique titles in the `titles` table.
*/
SHOW databases;
USE employees;

SELECT DISTINCT title
FROM titles;

/*
3. Find your query for employees who last name starts and ends with 'E'. Update the query find just the unique last names that start and end with 'E' using group by.
*/

SELECT last_name
FROM employees
WHERE last_name LIKE 'e%e'
GROUP BY last_name;

/* 4. Update your previous query to find the unique combinations of first and last name starts and ends with 'E'.*/
SELECT first_name, last_name
FROM employees
WHERE last_name LIKE 'e%e'
GROUP BY first_name, last_name;

/* 5. Find the unique last names with 'q', but not 'qu'.*/
SELECT last_name
FROM employees
WHERE (last_name LIKE '%q%') AND (last_name NOT LIKE '%qu%')
GROUP BY last_name;

/* 6. Add COUNT() to your results and use ORDER BY to make it easier to find employees whose unusual name is shared with others.*/
SELECT last_name, COUNT(last_name) as count
FROM employees
WHERE (last_name LIKE '%q%') AND (last_name NOT LIKE '%qu%')
GROUP BY last_name
ORDER BY count;

/* 7. Update your query for 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names */

SELECT gender, COUNT(*)
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY gender;

/* 8. Recall the query that generated usernames for employees from the last lesson. Are there any duplicate usernames? How many duplicate usernames are there?*/

SELECT  COUNT(*) as duplicate_usernames
FROM (SELECT 
	CONCAT(
	lower(SUBSTR(first_name, 1,1)), 
	lower(SUBSTR(last_name, 1, 4)), 
	'_', 
	DATE_FORMAT(birth_date, '%m%y')
	) as username, 
	COUNT(*) as count
	FROM employees
	GROUP BY username
	ORDER BY count DESC) as table1
WHERE count > 1;

