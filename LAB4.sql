set pagesize 200;
set linesize 200;

--SELECT employee_id, job_id
--FROM employees
--UNION
--SELECT employee_id, job_id
--FROM job_history;

SELECT prod_type, Count(*)
FROM products
GROUP BY prod_type
INTERSECT
SELECT prod_type, Count(*)
FROM products
GROUP BY prod_type
ORDER BY 2, 1;