USE hr_training;

SELECT a.first_name,a.last_name, b.department_name,city
FROM employees AS a
INNER JOIN departments AS b
	ON a.department_id = b.department_id 
INNER JOIN locations AS c
	ON b.location_id = c.location_id;
    

SELECT a.first_name,a.last_name, b.department_name,city
FROM employees AS a,departments AS b,locations AS c
WHERE a.department_id = b.department_id AND b.location_id = c.location_id;

SELECT a.first_name,a.last_name, b.department_name
FROM employees AS a
INNER JOIN departments AS b
	ON a.department_id = b.department_id 
WHERE b.department_name IN ('sale','engineering');

SELECT b.department_name, COUNT(*) AS emp_count
FROM employees AS a
INNER JOIN departments AS b
	ON a.department_id = b.department_id 
GROUP BY department_name
ORDER BY emp_count DESC;


SELECT b.department_name, SUM(salary)/COUNT(*) AS avg_salary
FROM employees AS a
INNER JOIN departments AS b
	ON a.department_id = b.department_id 
WHERE a.employment_status ='active'
GROUP BY b.department_name;


SELECT department_name, first_name, salary,t.rnk
FROM (
    SELECT b.department_name,a.first_name,a.salary,
        RANK() OVER (PARTITION BY b.department_name ORDER BY a.salary DESC) AS rnk
    FROM employees AS a
    INNER JOIN departments AS b
        ON a.department_id = b.department_id
    WHERE a.employment_status = 'active'
    ORDER BY a.salary DESC
) AS t
WHERE rnk <=2
ORDER BY department_name,rnk;
