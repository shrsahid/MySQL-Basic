USE hr_training;

-- Show the list of employees who resigned and the department they belonged to -- 

SELECT dp.department_name,em.first_name,employment_status AS Resigned
FROM employees AS em 
JOIN departments AS dp
	ON em.department_id = dp.department_id
WHERE employment_status = 'Terminated'
ORDER BY department_name;


-- Which department has the highest number of resigned/terminated employees? -- 

SELECT dp.department_name,employment_status AS Resigned,COUNT(*) AS T_count
FROM employees AS em 
JOIN departments AS dp
	ON em.department_id = dp.department_id
WHERE employment_status = 'Terminated'
GROUP BY dp.department_name
ORDER BY T_count DESC;



-- Analyze the possible reasons behind employee resignation -- 

SELECT e.employee_id, e.first_name,e.employment_status AS Status,
    d.department_name,COUNT(ep.project_id) AS t_projects,e.salary,
    ROUND(dept_avg.avg_salary) AS avg_salary,
    ROUND(e.salary - dept_avg.avg_salary) AS salary_gap
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id
LEFT JOIN employee_projects ep
    ON e.employee_id = ep.employee_id
JOIN (
    SELECT
        department_id,
        AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
) AS dept_avg
    ON e.department_id = dept_avg.department_id
WHERE e.employment_status IN ('Resigned', 'Terminated') 
GROUP BY e.employee_id,e.first_name,d.department_name,
    e.salary,dept_avg.avg_salary
ORDER BY d.department_name ASC,t_projects DESC,salary_gap ASC;


