USE employees; 
SELECT * FROM employees;
SELECT  gender, count(gender) 
	FROM employees 
	WHERE first_name IN ('Irena', 'Vidya', 'Maya')
	GROUP BY gender;
	
Select COUNT(DISTINCT (lower(CONCAT(
	SUBSTR(first_name,1,1), 
	SUBSTR(last_name,1,4), "_", 
	SUBSTR(birth_date,6,2), 
	SUBSTR(birth_date,3,2)))))
	as username, count(*) from employees
	;
	
	

