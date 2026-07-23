USE hr_training;

-- SELECT * FROM attendance; 
SELECT * FROM departments; 
-- SELECT * FROM employee_projects; 
SELECT * FROM employees; 
-- SELECT * FROM jobs; 
-- SELECT * FROM locations; 
-- SELECT * FROM performance_reviews; 
-- SELECT * FROM projects; 
-- SELECT * FROM salary_history; 


SELECT first_name,Hire_date,curdate() AS today,
timestampdiff(year,Hire_date,curdate()) AS Age
FROM employees 
WHERE department_id=1 
AND Hire_date >= '2020-01-01'
ORDER BY Age DESC; 

SELECT first_name,DATE_FORMAT(Hire_date,'%d-%b-%y') Hire_Date,salary, round(salary/1000)*1000
FROM employees 
WHERE department_id=1
AND Hire_date >= '2020-01-01';

SELECT * 
FROM employees
-- WHERE (Department_id= 1 OR Department_id=3)
WHERE Department_id IN (1,3)
AND salary>=100000 
AND employment_status='Active'
ORDER BY Salary ;


