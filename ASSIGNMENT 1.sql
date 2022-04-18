set pagesize 200;
set linesize 200;

--QUESTION 2
--SELECT c.cust_no, c.cname, o.order_no 
--FROM customers c JOIN orders o 
--ON o.cust_no = c.cust_no JOIN orderlines ol
--ON ol.order_no = o.order_no
--WHERE ol.prod_no IN ('40301','40303', '40310', '40306') AND 
--c.cname LIKE ('%Out%')
--ORDER BY 3;

--QUESTION 3
--SELECT cust_no, cname, country_cd
--FROM customers
--WHERE country_cd LIKE UPPER('&country_cd');

--QUESTION 4


--QUESTION 5
--SELECT c.cname, o.order_no, SUM(price * qty) TOTAL
--FROM customers c JOIN orders o 
--ON c.cust_no = o.cust_no JOIN orderlines ol 
--ON ol.order_no = o.order_no
--WHERE c.city = 'London' 
--GROUP BY c.cname, o.order_no
--ORDER BY 3 DESC;

--QUESTION 6
--SELECT o.cust_no, c.cname, c.address1, c.city, c.country_cd
--FROM customers c JOIN orders o
--ON c.cust_no = o.cust_no
--WHERE order_dt LIKE '%14'
--AND c.country_cd IN ('DE','CA', 'ES', 'IT')
--GROUP BY o.cust_no, c.cname, c.address1, c.city, c.country_cd
--ORDER BY o.cust_no;

--QUESTION 7
--SELECT order_dt, COUNT(*)
--FROM orders
--GROUP BY order_dt
--HAVING ((order_dt LIKE '%14') OR (order_dt LIKE '%15'))
--AND COUNT(*) > 2;

--QUESTION 8
--SELECT d.department_id, e.job_id, MIN(e.salary)
--FROM employees e JOIN departments d 
--ON e.department_id = d.department_id
--group by d.department_id, e.job_id
--HAVING (MIN(e.salary) BETWEEN 5000 AND 10000)
--AND (NOT e.job_id LIKE '%REP')
--ORDER BY 1, 2;

--QUESTION 9
--SELECT c.cust_no, cname
--FROM customers c LEFT JOIN orders o 
--ON o.cust_no = c.cust_no
--WHERE order_no IS NULL
--ORDER BY 1, 2;

--QUESTION 10
--SELECT CUST_NO, CNAME, COUNTRY_CD
--FROM CUSTOMERS
--WHERE COUNTRY_CD IN (SELECT COUNTRY_CD FROM CUSTOMERS WHERE CNAME LIKE 'Su%')
--AND (CNAME LIKE 'A%' OR CNAME LIKE 'C%')
--ORDER BY 1;

--QUESTION 11
--SELECT employee_id, last_name, job_id, 
--CASE
--WHEN salary NOT BETWEEN 6000 AND 11000 AND job_id LIKE '%VP' THEN salary*1.3
--WHEN salary NOT BETWEEN 6000 AND 11000 AND job_id LIKE '%MGR' THEN salary*1.2
--ELSE salary END AS mod_salary
--FROM employees
--WHERE (salary NOT BETWEEN 6000 AND 11000 AND (job_id LIKE '%VP' OR job_id LIKE '%MGR'))
--ORDER BY salary;

--QUESTION 12
SELECT last_name, salary, job_id, department_id, country_id
FROM employees LEFT JOIN departments
USING (department_id)
LEFT JOIN locations
USING (location_id)
WHERE salary> (SELECT MIN(salary)FROM employees
                LEFT JOIN departments
                USING (department_id)
                LEFT JOIN locations
                USING (location_id)
                WHERE country_id <> 'US')
AND job_id NOT IN ( 'AD_PRES', 'AD_VP' )
ORDER BY 3;

--QUESTION 13
--SELECT m.last_name AS Manager, e.last_name AS Employee
--FROM employees e INNER JOIN employees m
--ON e.manager_id = m.employee_id;

--QUESTION 14
--SELECT m.last_name AS Manager, count(e.last_name) // your query doesn't work
--FROM employees e INNER JOIN employees m
--ON e.manager_id = m.employee_id
--GROUP BY m.last_name
--HAVING count(e.last_name) > 2
--ORDER BY 2;





















