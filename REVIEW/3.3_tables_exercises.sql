/* Use the employees database */
SHOW DATABASES;
USE employees;

/* List all the tables in the database */
SHOW tables;

/* Explore the `employees` table. What different datatypes are present in this table? */

DESCRIBE employees;

/* Data types present:
emp_no: integer, Primary Key
birth_date: date
first_name: string
last_name: string
gender: string
hire_date: date
*/

/* What is the relationship between the `employees` table and the `departments` table? */
DESCRIBE employees;
DESCRIBE departments;

/* The `employees` table and `departments` table to not share a common key value*/

/* Show the sql query that created the `dept_manager` table. */

SHOW CREATE TABLE dept_manager;