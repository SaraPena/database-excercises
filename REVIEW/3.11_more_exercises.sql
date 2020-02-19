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


/* Sakila Datbase
1. Display the first and last names in all lowercase of all the actors.

*/

USE sakila;

SELECT lower(CONCAT(first_name, ' ', last_name)) as full_name
FROM actor;

/*
2. You need to find the ID number, first name, and last name of an actor, of whom you only know the first name "Joe". What is one query you could use to obtain this information?
*/

SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name LIKE '%JOE%';

/*
3. Find all actors whose last name contain the letters 'gen'
*/

SELECT first_name, last_name
FROM actor
WHERE last_name LIKE '%gen%';

/*
4. Find all actors whose last names contain the letter 'li'. This time order the names by last name and first name in that order.
*/

SELECT first_name, last_name
FROM actor
WHERE last_name LIKE '%li%'
ORDER BY last_name, first_name;

/*
5. Using IN, display the `country_id` and `country` columns for the following countries: Afghanistan, Bangledesh, and China.
*/

SELECT country_id, country
from country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

/*
6. List the last names of all actors, as well as how many actors have the last name.
*/

SELECT last_name, count(*) as count
FROM actor
GROUP BY last_name;

/*
7. List last names of actors and the number of actors who have that last name, but only for names that are shared by as least two actors.
*/

SELECT last_name, count
FROM (SELECT last_name, count(*) as count
		FROM actor
		GROUP BY last_name) as lc
WHERE count >= 2
ORDER BY count, last_name;

/*
8. You cannot locate the schema of the address table, which query would you use to recreate it?
*/

DESCRIBE address;

/*
9. Use JOIN to display the first and last names, as well as the address, of each staff member.
*/

SELECT first_name, last_name, address
FROM staff
LEFT JOIN address using (address_id);

/*
10. Use JOIN to display the total amount rung up by each staff member in August 2005
*/

SELECT staff_id, SUM(amount) as amount_rung_up
FROM payment
LEFT JOIN staff using (staff_id)
WHERE payment_date LIKE '2005-08%'
GROUP BY staff_id;

/*
11. List each film and the number of actors who are listed for that film.
*/

SELECT title, count(*) as actor_count
FROM film
LEFT JOIN film_actor using (film_id)
LEFT JOIN actor using (actor_id)
GROUP BY title
ORDER BY actor_count DESC;

/*
12. How many copies of the film Hunchback Impossible exist in the inventory system?
*/

SELECT title, count(*)
FROM film
RIGHT JOIN inventory using (film_id)
WHERE title = 'Hunchback Impossible'
GROUP BY title
ORDER BY count(*) DESC;

/*
13. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English. 
*/

SELECT title 
FROM film
LEFT join language using (language_id)
WHERE (title LIKE 'k%' OR title like 'Q%') AND language.name = 'English';

/*
14. Use subqueries to display all actors who appear in the film Alone Trip.
*/

SELECT actor_id, film_id, first_name, last_name
FROM actor
LEFT JOIN film_actor using (actor_id)
LEFT JOIN film using (film_id)
WHERE title = 'Alone Trip';

/*
15. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers.
*/

Select first_name, last_name, email
FROM customer
LEFT JOIN address using (address_id)
LEFT JOIN city using (city_id)
LEFT JOIN country using (country_id)
WHERE country = 'Canada';

/*
16. Sales have been lagging amoung young families, and you wish to target all family movies for a promotion. Identify all movies catagorized as family films.
*/

SELECT title
FROM film
LEFT JOIN film_category using (film_id)
LEFT JOIN category using (category_id)
WHERE category.name = 'Family';

/*
17. Write a query to display how much business, in dollars, each store has brought in.
*/

SELECT store_id, staff_id, SUM(amount)
FROM payment
LEFT JOIN staff using (staff_id)
LEFT JOIN store using (store_id)
GROUP BY store_id, staff_id;

/*
18. Write a query to display for each store it's store_id, city, and country. 
*/

SELECT store_id, city, country
FROM store
LEFT JOIN address using (address_id)
LEFT JOIN city using (city_id)
LEFT JOIN country using (country_id);

/*
19. List the top 5 genres in gross revenue in decending order.
*/