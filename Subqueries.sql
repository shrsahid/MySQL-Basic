USE parks_and_recreation;

SELECT * 
FROM employee_demographics
WHERE employee_id IN (
	SELECT employee_id 
    FROM employee_salary
    WHERE dept_id =1)
;

 -- Finding AVG using subqueries)
SELECT first_name,salary,
(SELECT AVG(salary) 
FROM employee_salary)
FROM employee_salary;


SELECT *
FROM
( SELECT gender,
AVG(age) AS avg_age,
MAX(age) AS max_age,
MIN(age) AS min_age,
COUNT(age)
FROM employee_demographics
GROUP BY gender) AS Agg_table;
