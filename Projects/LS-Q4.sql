USE hr_training;

-- LS-Q4
-- Using CTEs, build a working definition of “overallocated” (how many concurrent projects, and/or how many total hours_allocated, counts as too many — you 
-- decide and justify it) and a working definition of “irregular attendance” (what share of Absent/Late records is concerning — you decide and justify it). 
-- Combine both into one query that flags employees meeting both conditions at once. How many employees are flagged, and is any one department 
-- overrepresented on this list?




-- Calculating total projects and work allocated as per employee -- 

SELECT employee_id,
	COUNT(DISTINCT project_id) AS project_count,
	SUM(hours_allocated) AS total_hours
FROM employee_projects
GROUP BY employee_id;

-- Finding average hours allocated -- 

SELECT AVG(A.total_hours)
FROM(SELECT employee_id,
	COUNT(DISTINCT project_id) AS project_count,
	SUM(hours_allocated) AS total_hours
FROM employee_projects
GROUP BY employee_id) A ;


-- Calculating attendence Record -- 

SELECT 
employee_id,
COUNT(*) AS total_records,
	SUM(
	CASE 
		WHEN status IN ('Absent', 'Late') THEN 1
		ELSE 0
	END
	) AS irregular_records,
	100.0 * SUM(
	CASE 
		WHEN status IN ('Absent', 'Late') THEN 1
		ELSE 0
	END
	) / COUNT(*) AS irregular_attendance_rate
FROM attendance
GROUP BY employee_id;

-- Calulating Final Result -- 

WITH workload AS(
	SELECT employee_id,
		COUNT(DISTINCT project_id) AS project_count,
		SUM(hours_allocated) AS total_hours
	FROM employee_projects
	GROUP BY employee_id),
irr_att_rate AS(
	SELECT 
	employee_id,
	COUNT(*) AS total_records,
		SUM(
		CASE 
			WHEN status IN ('Absent', 'Late') THEN 1
			ELSE 0
		END
		) AS irregular_records,
		100.0 * SUM(
		CASE 
			WHEN status IN ('Absent', 'Late') THEN 1
			ELSE 0
		END
		) / COUNT(*) AS irregular_attendance_rate
FROM attendance
GROUP BY employee_id)
    
SELECT d.department_id,d.department_name,
	COUNT(*) AS flagged_employee_count
FROM employees AS e
JOIN departments AS d
	ON e.department_id = d.department_id
JOIN workload  AS wl
	ON e.employee_id = wl.employee_id
JOIN irr_att_rate AS iar
	ON e.employee_id = iar.employee_id
WHERE wl.project_count >= 2
      AND wl.total_hours >= 340
      AND iar.irregular_attendance_rate >= 10
GROUP BY d.department_name,d.department_id
ORDER BY flagged_employee_count DESC;


    
    
    
    
    
    
    
    
    
    
    
    