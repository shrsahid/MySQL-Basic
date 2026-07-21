USE parks_and_recreation;


-- Inner join-- 
SELECT * 
FROM employee_demographics AS ed
INNER JOIN employee_salary AS es
ON ed.employee_id= es.employee_id; 


-- OUTER JOIN-- 
SELECT * 
FROM employee_demographics AS ed
LEFT JOIN employee_salary AS es
ON ed.employee_id= es.employee_id;

SELECT * 
FROM employee_demographics AS ed
RIGHT JOIN employee_salary AS es
ON ed.employee_id= es.employee_id;


-- SELF JOIN -- 
SELECT emp1.employee_id AS emp1_id,
emp1.first_name AS first_name_emp1,
emp1.first_name AS first_name_emp1,
emp1.last_name AS last_name_emp1,
emp2.employee_id AS emp2_id,
emp2.first_name AS first_name_emp2,
emp2.last_name AS last_name_emp2
FROM employee_salary emp1
JOIN employee_salary emp2
ON emp1.employee_id +2 = emp2.employee_id;


-- Joining Multiple tables together -- 
SELECT * 
FROM employee_demographics AS ed
INNER JOIN employee_salary AS es
ON ed.employee_id= es.employee_id
INNER JOIN parks_departments pd
ON es.dept_id = pd.department_id;

SELECT * FROM parks_departments;



-- UNION JOIN -- 
SELECT first_name,last_name,'Old Man' AS Label
FROM employee_demographics
WHERE age>40 AND gender='Male'
UNION
SELECT first_name,last_name,'Old Lady' AS Label
FROM employee_demographics
WHERE age>40 AND gender='Female'
UNION
SELECT first_name,last_name,'Highly paid employee' AS Label
FROM employee_salary
WHERE salary > 70000 
ORDER BY first_name;
