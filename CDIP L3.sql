USE hr_training;

SELECT *
FROM performance_reviews
WHERE rating <= 2;

SELECT employee_id,COUNT(1)
FROM performance_reviews
GROUP BY employee_id;

SELECT employee_id,AVG(rating)
FROM performance_reviews
GROUP BY employee_id;

SELECT COUNT(1)
FROM(
SELECT employee_id,AVG(rating) AS avg_rating
FROM performance_reviews
GROUP BY employee_id) A
WHERE avg_rating <= 2;

SELECT * 
FROM(
	SELECT employee_id,first_name
    FROM employees
    WHERE employment_status = 'Terminated'
) a
INNER JOIN(
	SELECT*
	FROM(
	SELECT employee_id,AVG(rating) AS avg_rating
	FROM performance_reviews
	GROUP BY employee_id) A
	WHERE avg_rating <= 2
) b
ON a.employee_id = b.employee_id;


SELECT * 
FROM employees;

ALTER TABLE employees ADD COLUMN Retention_Risk VARCHAR(8);
SET SQL_SAFE_UPDATES = 0;

UPDATE employees
SET Retention_Risk ='High'
WHERE Retention_Risk IS NULL;



