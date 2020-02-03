-- Exercises
-- Connect to the database server
/* 1. List all the databases */
SHOW Databases;

/* 2. Switch to a database using the USE statement */
USE chipotle;

/* 3. Show the currently selected database */
SELECT database();

/* 4. Find out the query used to create the database */
SHOW CREATE DATABASE chipotle;

/* 5. Switch to a different database */
USE titanic_db;

/* 6. Show the currently selected database */
SELECT database();