USE hr_training;

SELECT * FROM salary_history;



WITH employee_performance AS (
    SELECT 
        employee_id,
        AVG(rating) AS avg_performance_rating
    FROM performance_reviews
    GROUP BY employee_id
),

first_salary_change AS (
    SELECT 
        employee_id,
        MIN(change_date) AS first_change_date
    FROM salary_history
    GROUP BY employee_id
),

employee_analysis AS (
    SELECT 
        e.employee_id,
        ep.avg_performance_rating,

        TIMESTAMPDIFF(
            MONTH,
            e.hire_date,
            fsc.first_change_date
        ) AS months_to_first_raise,

        CASE
            WHEN ep.avg_performance_rating < 3 THEN 'Below Average'
            WHEN ep.avg_performance_rating <= 4 THEN 'Solid Performer'
            ELSE 'High Performer'
        END AS performance_band

    FROM employees AS e

    JOIN employee_performance AS ep
        ON e.employee_id = ep.employee_id

    JOIN first_salary_change AS fsc
        ON e.employee_id = fsc.employee_id
)

SELECT 
    performance_band,
    COUNT(*) AS employee_count,
    ROUND(
        AVG(months_to_first_raise),
        2
    ) AS avg_months_to_first_raise

FROM employee_analysis

GROUP BY performance_band

ORDER BY avg_months_to_first_raise;


SELECT 
employee_id,
	AVG(rating) AS avg_performance_rating
FROM performance_reviews
GROUP BY employee_id;





WITH first_salary_change AS (
    SELECT 
        employee_id,
        MIN(change_date) AS first_change_date
    FROM salary_history
    GROUP BY employee_id
),

employee_performance AS (
    SELECT 
        employee_id,
        AVG(rating) AS avg_rating
    FROM performance_reviews
    GROUP BY employee_id
)

SELECT 
    CASE
        WHEN ep.avg_rating < 3 THEN 'Below Average'
        WHEN ep.avg_rating <= 4 THEN 'Solid Performer'
        ELSE 'High Performer'
    END AS performance_band,

    sh.change_reason,
    COUNT(*) AS change_count

FROM employees e

JOIN employee_performance ep
    ON e.employee_id = ep.employee_id

JOIN first_salary_change fsc
    ON e.employee_id = fsc.employee_id

JOIN salary_history sh
    ON sh.employee_id = fsc.employee_id
    AND sh.change_date = fsc.first_change_date

GROUP BY performance_band, sh.change_reason

ORDER BY performance_band, change_count DESC;




