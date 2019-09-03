-- 1. Use the employees database
use employees;

-- 2. List all the tables in the database.
SHOW TABLES;

Select * FROM employees;

Describe employees;
-- 5. Data Types in employees are: int, date, varchar(), enum.

-- 6. emp_no will be a numberic type column
-- 7. first_name, last_name are string type columns
-- 8. birth_date, hire_date is a date type columns
-- 9. The dept_emp and dept_manager tables use the employees table by connecting it to the emp_no

-- Show the SQL that created the dept_manager table.

SHOW CREATE TABLE dept_manager;

-- CREATE TABLE `dept_manager` (
--  `emp_no` int(11) NOT NULL,
--  `dept_no` char(4) NOT NULL,
--  `from_date` date NOT NULL,
-- `to_date` date NOT NULL,
--  PRIMARY KEY (`emp_no`,`dept_no`),
--  KEY `dept_no` (`dept_no`),
--  CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE,
--  CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE
-- ) ENGINE=InnoDB DEFAULT CHARSET=latin1




