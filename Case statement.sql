USE parks_and_recreation;

SELECT first_name,last_name,age,
CASE
WHEN age<=30 THEN 'Young'
WHEN age BETWEEN 31 AND 50 THEN 'Middle Age'
WHEN age >=50 THEN 'Old Age'
END AS Age_Level
FROM employee_demographics;


-- Pay Increase and Bonus -- 

SELECT first_name,last_name,salary,
CASE
	WHEN salary < 50000 THEN salary * 1.05
    WHEN salary >= 50000 THEN salary * 1.07
END AS  New_Salary,
CASE
	WHEN dept_id= 1 THEN (salary * 1.07) * 0.10
END AS Bonus
FROM employee_salary;