USE hr_training;

--  Solving 10 SQL Questions Using  SELECT, WHERE, ORDER BY, built-in functions, logical operators, and data conversion-- 


-- QS-1:  List all employees hired after Jan 1, 2022, newest first. -- 
SELECT employee_id,first_name,last_name,gender,hire_date
FROM employees
WHERE hire_date > 2022-01-01
ORDER BY hire_date DESC;


-- QS-2:  Find all active employees in the Sales department. -- 

SELECT employee_id,first_name,last_name,gender,employment_status
FROM employees
WHERE department_id = 2 AND employment_status = 'active';


-- QS-3:  Show employees earning between 50,000 and 80,000, highest first. -- 

SELECT employee_id,first_name,last_name,gender,salary
FROM employees
WHERE salary BETWEEN 50000 AND 80000
ORDER BY salary DESC;


-- QS-4:  Calculate each employee's age today using date_of_birth. -- 

SELECT employee_id,first_name,last_name,gender,date_of_birth,
	TIMESTAMPDIFF(YEAR,date_of_birth,CURDATE()) AS Age_Since_Birth
FROM employees;


-- QS-5: Find employees hired in 2023 OR currently earning commission. -- 

SELECT employee_id,first_name,last_name,gender,hire_date,commission_pct
FROM employees
WHERE YEAR(hire_date) = 2023 OR commission_pct > 0;


-- QS-6: Format every hire_date as "Mon YYYY" (e.g. "Aug 2015"). -- 

SELECT employee_id,first_name,hire_date,
	DATE_FORMAT(hire_date, '%b %y') AS Modified_Format
FROM employees;


-- QS-7: List employees whose employment_status is NOT 'Active'. -- 

SELECT employee_id,first_name,last_name,gender,employment_status
FROM employees
WHERE employment_status != 'active';


-- QS-8: Find employees whose first_name starts with the letter 'A'. -- 

SELECT employee_id,first_name
FROM employees
WHERE first_name LIKE 'A%';


-- QS-9: List all distinct job_id values used in the employees table. --

SELECT DISTINCT job_id
FROM employees;


-- QS-10: Show employees whose last_name contains 'son'. --

SELECT employee_id,last_name
FROM employees
WHERE last_name LIKE '%son%';