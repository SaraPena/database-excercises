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
SELECT name as genre, SUM(amount) as gross_revenue
FROM film
LEFT JOIN film_category using (film_id)
LEFT JOIN category using (category_id)
LEFT JOIN inventory using (film_id)
LEFT JOIN rental using (inventory_id)
LEFT JOIN payment using (rental_id)
GROUP BY genre
ORDER BY gross_revenue DESC
LIMIT 5;

/*
1. SELECT Statements
	a. select all columns from the actor table
*/

SELECT * 
FROM actor;

/*
	b. Select only the last name column from the actors table.
*/

SELECT last_name
FROM actor;

/*
2. DISTINCT operator
	a. SELECT all distinct last_names from the actor table.
*/

SELECT DISTINCT last_name
FROM actor;

/*
	b. SELECT all distinct postal codes from the address table.
*/

SELECT DISTINCT postal_code
FROM address;

/*
	c. Select all distinct ratings from the film table.
*/

SELECT DISTINCT rating
from film;

/*
3. WHERE clause
	a. Select the title, description, rating, movie length columns from the films table that lasts three hours or longer.
*/

SELECT title, description, rating, length as movie_length
from film
WHERE length >= 60*3
ORDER BY movie_length DESC;

/*
What is the average replacement cost of a film? Does this change depending on the rating of the film?
*/

SELECT AVG(replacement_cost)
FROM film;

SELECT rating, AVG(replacement_cost)
FROM film
GROUP by rating;


/*
2. How many different films of each genre are in the database?
*/

SELECT name as genre, count(*) as count
FROM film_category
LEFT JOIN category using (category_id)
GROUP BY genre;

/*
What are the 5 frequently rented films?
*/

SELECT title, count(*) as count
FROM rental
LEFT join inventory using (inventory_id)
LEFT join film using (film_id)
GROUP BY title
ORDER BY count DESC
LIMIT 5;

/*
What are the most profitable films in terms of gross revenue?
*/

SELECT title, SUM(amount) as gross_revenue
from payment
LEFT JOIN rental using (rental_id)
LEFT JOIN inventory using (inventory_id)
LEFT JOIN film using (film_id)
GROUP BY title
ORDER BY gross_revenue DESC
LIMIT 5;

/*
Who is the best customer?
*/

SELECT customer_id, full_name, total
FROM (/*Create a table that is grouped by customer_id payments*/
	SELECT customer_id, CONCAT(first_name, ' ', last_name) as full_name, 		SUM(amount) as total
	FROM payment
	LEFT JOIN customer using (customer_id)
	GROUP BY customer_id
	ORDER BY total DESC) as rev
WHERE total = (
		/*Create a table that selects the max(total) from the 'rev' table in the first FROM statment*/
		SELECT MAX(total)
		FROM (
			SELECT customer_id, SUM(amount) as total
			FROM payment
			LEFT JOIN customer using (customer_id)
			GROUP BY customer_id
			ORDER BY total DESC) as rev);
			
/*
Who are the top 5 actors (who have appeared in the most films).
*/
SELECT actor_id, CONCAT(first_name, ' ', last_name) as full_name, count(*) as film_amt
FROM film_actor
LEFT JOIN actor using (actor_id)
GROUP BY actor_id, full_name
ORDER BY film_amt DESC
LIMIT 5;

/*
What are the sales for each store in each month of 2005?
*/

SELECT MONTH(payment_date) as month, store_id, SUM(amount)
FROM payment
LEFT JOIN rental using (rental_id)
LEFT JOIN inventory using (inventory_id)
WHERE YEAR(payment_date) = '2005' AND store_id IS NOT NULL
GROUP BY month, store_id;

/*
BONUS:
Find the film title, customer name, customer phone number, and customer address for all outstanding DVD's
*/

SELECT inventory_id, title, CONCAT(last_name, ', ', first_name) as customer_name, phone, DATEDIFF(rental.last_update, rental_date) as days_out, rental_date, rental.last_update
from rental
LEFT JOIN inventory using (inventory_id)
LEFT JOIN film using (film_id)
LEFT JOIN customer using (customer_id)
LEFT JOIN address using (address_id)
WHERE return_date IS NULL
ORDER BY days_out DESC;
