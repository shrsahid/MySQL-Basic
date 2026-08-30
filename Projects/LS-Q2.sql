USE hr_training;

-- Q2:- Find active employees who have been with the company at least 3 years and are currently paid more than 10% below the average salary for their exact job 
-- title. Order your results so the longest-tenured, most underpaid people surface first



-- Finding Employee who work at least 3 year in a company
SELECT employee_id,timestampdiff(year,Hire_date,curdate()) AS Age
FROM employees
WHERE timestampdiff(year,Hire_date,curdate()) >=3;

SELECT *
FROM employees;

SELECT *
FROM jobs;

-- Checking Purpose
SELECT job_id,employee_id,salary
FROM employees
WHERE employee_id=34;

-- Finding avg as per job title

SELECT job_id,ROUND(AVG(salary),2) AS t_avg
FROM employees
GROUP BY job_id;



-- Final Result 
SELECT employee_id,t_avg,salary,em.job_id,
(t_avg-salary) as salary_gap,
timestampdiff(year,Hire_date,curdate()) AS Age
FROM employees AS em
JOIN(SELECT job_id,ROUND(AVG(salary),2) AS t_avg
FROM employees
GROUP BY job_id) AS av
ON em.job_id = av.job_id
WHERE t_avg*(1 - 0.1)>salary AND timestampdiff(year,Hire_date,curdate()) >=3
ORDER BY salary_gap DESC;


-- Counting Underpaying employees
SELECT COUNT(employee_id)
FROM (SELECT employee_id,t_avg,salary,em.job_id,
(t_avg-salary) as salary_gap,
timestampdiff(year,Hire_date,curdate()) AS Age
FROM employees AS em
JOIN(SELECT job_id,ROUND(AVG(salary),2) AS t_avg
FROM employees
GROUP BY job_id) AS av
ON em.job_id = av.job_id
WHERE t_avg*(1 - 0.1)>salary AND timestampdiff(year,Hire_date,curdate()) >=3
ORDER BY salary_gap DESC)A

