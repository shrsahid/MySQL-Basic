USE hr_training;

-- FINDING AVERAGE SALARY PER DEPT -- 

SELECT ROUND(AVG(salary), 2) AS avg_salary
FROM employees
GROUP BY department_id;

-- FINDING AVERAGE RATING PER DEPT -- 

SELECT employee_id,
ROUND(AVG(rating),2) AS average_rating
FROM performance_reviews
GROUP BY employee_id;

-- FINDING AVERAGE WORKLOAD PER DEPT -- 

SELECT employee_id,
ROUND(AVG(hours_allocated),2) AS average_workload
FROM employee_projects
GROUP BY employee_id;

-- FINDING AVERAGE REJECTION RATE PER DEPT -- 

SELECT employee_id,
ROUND(AVG(
	CASE
		WHEN status= 'Rejected' THEN 1
        ELSE 0
	END
	
    )*100,2) AS rejection_rate
FROM leave_requests
GROUP BY employee_id;


-- FINDING ATTRITION RATE PER DEPT -- 

SELECT department_id,
	ROUND(100* SUM(
		CASE
			WHEN employment_status='Terminated' THEN 1
            ELSE 0
		END) / COUNT(employee_id),2) AS attrition_rate
FROM employees
GROUP BY department_id
ORDER BY attrition_rate DESC;



-- FINAL PART -- 

SELECT department_id,d.department_name,
	ROUND(
        100.0 * SUM(
            CASE 
                WHEN e.employment_status = 'Terminated' THEN 1
                ELSE 0
            END
        ) / COUNT(e.employee_id),
        2
    ) AS attrition_rate,
	ROUND(AVG(ep.hours_allocated),2) AS average_workload,
    ROUND(AVG(pr.rating),2) AS average_rating,
    ROUND(AVG(e.salary), 2) AS avg_salary,
    ROUND(AVG(
	CASE
		WHEN status= 'Rejected' THEN 1
        ELSE 0
	END
	
    )*100,2) AS rejection_rate
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
LEFT JOIN performance_reviews AS pr
ON e.employee_id =pr.employee_id
LEFT JOIN employee_projects AS ep
ON e.employee_id = ep.employee_id
LEFT JOIN leave_requests AS lr
ON e.employee_id = lr.employee_id

GROUP BY d.department_id,d.department_name
ORDER BY attrition_rate DESC;



-- FINAL PART ERROR SOLUTION -- 

WITH performance_data AS (
    SELECT 
        employee_id,
        AVG(rating) AS avg_rating
    FROM performance_reviews
    GROUP BY employee_id
),

workload_data AS (
    SELECT 
        employee_id,
        AVG(hours_allocated) AS avg_workload
    FROM employee_projects
    GROUP BY employee_id
),

leave_data AS (
    SELECT 
        employee_id,
        AVG(
            CASE 
                WHEN status = 'Rejected' THEN 1
                ELSE 0
            END
        ) * 100 AS rejection_rate
    FROM leave_requests
    GROUP BY employee_id
)

SELECT 
     d.department_id,d.department_name,

    ROUND(
        100.0 * SUM(
            CASE 
                WHEN e.employment_status = 'Terminated' THEN 1
                ELSE 0
            END
        ) / COUNT(e.employee_id),
        2
    ) AS attrition_rate,

    ROUND(AVG(e.salary), 2) AS avg_salary,

    ROUND(AVG(pd.avg_rating), 2) AS avg_performance_rating,

    ROUND(AVG(wd.avg_workload), 2) AS avg_project_workload,

    ROUND(AVG(ld.rejection_rate), 2) AS leave_rejection_rate

FROM employees e

JOIN departments d
    ON e.department_id = d.department_id

LEFT JOIN performance_data pd
    ON e.employee_id = pd.employee_id

LEFT JOIN workload_data wd
    ON e.employee_id = wd.employee_id

LEFT JOIN leave_data ld
    ON e.employee_id = ld.employee_id

GROUP BY d.department_id, d.department_name

ORDER BY attrition_rate DESC;
