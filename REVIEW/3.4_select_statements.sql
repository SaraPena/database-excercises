/* For example, to select the fruits and their quantity in our fruits database */
SHOW databases;
USE fruits_db;

SELECT name, quantity
FROM fruits;

/* If we want to retrieve all of the available columns for a database table, we can use the wildcard *. */

SELECT * FROM fruits;

/* For example, if we just wanted to view the dragonfruit record, we could write: */

SELECT *
FROM fruits
WHERE name = 'dragonfruit';

/* Also remember, the guaranteed fastest and most precise way to find a single record in a table is to use the table's primary key: */

SELECT *
FROM fruits
WHERE id = 5;

/* All of the following operators can be used as part of a WHERE clause. To illustrate the use of these operators, we can also use them with a SELECT. */

SELECT
    2 = 2,
    1 = 2,
    1 < 2,
    2 <= 3,
    2 BETWEEN 1 AND 3,
    2 != 2,
    1 > 2;
    
/* Aliases allow us to temporarily rename a column, table, or miscellaneous pieces of our query. We use aliases with the AS keyword. Here is a simple example: */

SELECT 1+1 as two;


/* For example, if we wanted to view the rows in the fruits table where our inventory is low, we might write a query like the following: */

SELECT id, name as low_quantity_fruit, quantity as inventory
FROM fruits
Where quantity < 4;

/* Miscellaneous Output -
Sometimes it may be useful to output arbitrary data from our SQL scripts. We can do this by selecting an arbitrary string and giving it a name like so: */
SELECT 'I am output!' as Info;



