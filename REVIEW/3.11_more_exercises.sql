/* Extra SQL Exercises
Create a file named 3.11_more_exercises.sql to do your work in. Write the appropriate `USE` statments to switch databases as necessary
*/

SHOW databases;

/*Employees Database
1. How much to the current managers in each department get paid, relative to the average salary for the department? Is there any department where the department manager gets paid LESS than the average salary?
*/

USE employees;

SELECT emp_no, dept_no, dept_name, first_name, last_name, salary, avg_salary,
	IF(salary > avg_salary, 'yes', 'no') as more_than_avg
FROM dept_manager
LEFT JOIN employees using (emp_no)
LEFT JOIN departments using (dept_no)
LEFT JOIN salaries using (emp_no)
LEFT JOIN (SELECT dept_no,AVG(salary) as avg_salary
			FROM salaries
			LEFT JOIN dept_emp using (emp_no)
			WHERE dept_emp.to_date > CURDATE() AND salaries.to_date > CURDATE()
			GROUP by dept_no) as avgsal using (dept_no)
WHERE dept_manager.to_date > CURDATE() AND salaries.to_date > CURDATE()
ORDER BY salary DESC;

/* World Database 
Use the world database for the questions below

What languages are spoken in Santa Monica?
*/

USE world;

SELECT language, percentage
FROM countrylanguage
LEFT JOIN city using (CountryCode)
WHERE name = 'Santa Monica'
ORDER BY percentage;

/*
How many countries are in each region?
*/

SELECT REGION, COUNT(*)
FROM country
GROUP BY REGION
ORDER BY COUNT(*);

/*
What is the population for each region?
*/

SELECT REGION, SUM(Population)
FROM country
GROUP BY REGION
ORDER BY SUM(Population) DESC;

/*
What is the population for each continent?
*/

SELECT Continent, SUM(Population)
FROM country
GROUP BY Continent
ORDER BY SUM(Population) DESC;

/*
What is the average life expectancy globally?
*/

SELECT avg(LifeExpectancy)
from country;

/*
What is the average life expectancy for each region, each continent? Sort the results from shortest to longest.
*/

SELECT REGION, AVG(LifeExpectancy)
FROM country
GROUP BY REGION
ORDER BY AVG(LifeExpectancy);

SELECT Continent, AVG(LifeExpectancy)
FROM country
GROUP BY Continent
ORDER BY AVG(LifeExpectancy);


/*
Find all countries whose local name is different from the official name
*/

SELECT Name
FROM country
WHERE LocalName NOT LIKE Name;

/*
How many countries have a life expectancy less than 55 years?
*/

SELECT COUNT(*)
FROM country
WHERE LifeExpectancy < 55;

/*
What state is Los Angeles located in?
*/

SELECT city.Name, District, CountryCode, country.Name
FROM city
JOIN country ON country.Code = city.CountryCode
WHERE city.Name LIKE 'Los Angeles';

/*
What region on the world is Los Angeles located in?
*/

SELECT city.Name, District, CountryCode, country.Name, Region
FROM city
JOIN country ON country.Code = city.CountryCode
WHERE city.Name LIKE 'Los Angeles';

/*
What is the life expectancy in Los Angeles?
*/

SELECT city.Name, District, CountryCode, country.Name, Region, LifeExpectancy
FROM city
JOIN country ON country.Code = city.CountryCode
WHERE city.Name LIKE 'Los Angeles';



