USE hr_training;

-- Finding active department which have at least more than 3 people

SELECT manager_id,department_id, COUNT(employee_id) direct_report
FROM employees
WHERE employment_status='Active'
GROUP BY manager_id,department_id
HAVING direct_report>3;



SELECT *
FROM employees;

SELECT *
FROM performance_reviews;


-- Finding department Avergae

SELECT department_id,AVG(rating) AS dept_avg
FROM employees AS em
JOIN performance_reviews AS pr
ON em.employee_id = pr.employee_id
WHERE department_id IS NOT NULL
GROUP BY department_id ;

-- Finding team Avergae

-- SELECT DISTINCT em.manager_id, department_id,pr.rating, COUNT(DISTINCT em.employee_id) team_size,AVG(rating)
-- FROM employees AS em
-- JOIN performance_reviews AS pr
-- ON em.employee_id = pr.employee_id
-- WHERE department_id IS NOT NULL
-- GROUP BY em.manager_id,em.department_id,pr.rating
-- HAVING team_size>3;  -- made some mistake with group by and output printing of rating



-- Correct one 

SELECT manager_id,department_id,AVG(rating) AS team_avg,COUNT( DISTINCT em.employee_id) team_size
FROM employees AS em
JOIN performance_reviews AS pr
ON em.employee_id = pr.employee_id
WHERE (department_id IS NOT NULL) AND (employment_status='Active')
GROUP BY manager_id,department_id 
HAVING team_size>3;


-- Joining both average and finding rating_gap with rank
-- .......................................................-- 
SELECT team.department_id,manager_id,team_size,team_avg,dept_avg,
(team.team_avg - dept.dept_avg) AS rating_gap,
DENSE_RANK() OVER(ORDER BY (team.team_avg - dept.dept_avg) ASC) AS P_Rank
FROM(
SELECT manager_id,department_id,AVG(rating) AS team_avg,COUNT( DISTINCT em.employee_id) team_size
FROM employees AS em
JOIN performance_reviews AS pr
ON em.employee_id = pr.employee_id
WHERE (department_id IS NOT NULL) AND (employment_status='Active')
GROUP BY manager_id,department_id 
HAVING team_size>3) team

JOIN

(SELECT department_id,AVG(rating) AS dept_avg
FROM employees AS em
JOIN performance_reviews AS pr
ON em.employee_id = pr.employee_id
WHERE department_id IS NOT NULL
GROUP BY department_id ) dept
ON team.department_id = dept.department_id

-- WHERE (team.team_avg - dept.dept_avg)<0
ORDER BY rating_gap ;
-- .........................-- 



-- Checking to find futher errors by some specific dept and manager id -- 
SELECT manager_id,department_id,AVG(rating) AS dept_avg
FROM employees AS em
JOIN performance_reviews AS pr
ON em.employee_id = pr.employee_id
WHERE department_id =1 AND manager_id =5
GROUP BY manager_id, department_id ;

SELECT manager_id,COUNT(DISTINCT employee_id)
FROM employees
WHERE employment_status='Active'
GROUP BY  manager_id;


-- For identify finding the team_size avg
SELECT ROUND(AVG(S.team_size),2)
FROM(
SELECT manager_id,department_id,AVG(rating) AS team_avg,COUNT( DISTINCT em.employee_id) team_size
FROM employees AS em
JOIN performance_reviews AS pr
ON em.employee_id = pr.employee_id
WHERE (department_id IS NOT NULL) AND (employment_status='Active')
GROUP BY manager_id,department_id 
HAVING team_size>3) S



