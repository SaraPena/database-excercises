/* For example, to select the fruits and their quantity in our fruits database */
SHOW databases;
USE fruits_db;

SELECT name, quantity
FROM fruits;

/* If we want to retrieve all of the available columns for a database table, we can use the wildcard *. */

SELECT * FROM fruits;

