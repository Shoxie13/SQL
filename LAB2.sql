/*
--LAB-02

--QUESTION - 1
SELECT job_id AS "ABDI", COUNT(*)
FROM employees
GROUP BY job_id
ORDER BY 2 DESC;

--QUESTION - 2
SELECT 
ROUND(MAX(salary),0) "HIGHEST SALARY",
ROUND(MIN(salary),0) "LOWEST SALARY",
ROUND(AVG(salary),0) "AVERAGE SALARY"
FROM employees;

--QUESTION - 3
SELECT c.cname, COUNT(*)
FROM customers c 
INNER JOIN orders o ON c.cust_no = o.cust_no
INNER JOIN orderlines ol ON o.order_no = ol.order_no
WHERE (ol.price * ol.qty) > 50000
GROUP BY c.cname
ORDER BY 2 ASC;

--QUESTION - 4
SELECT prod_type, SUM(sales_2015 + sales_2016)
FROM products
GROUP BY prod_type
ORDER BY 1;

-QUESTION - 5
SELECT c.cname, COUNT(*)
FROM customers c
INNER JOIN orders o ON c.cust_no = o.cust_no
WHERE (c.cname LIKE 'A%' OR c.cname LIKE 'G%')
GROUP BY c.cname
ORDER BY 2;

--QUESTION - 6
SELECT o.cust_no, c.cname, SUM(ol.price*ol.qty), COUNT(*) 
FROM customers c
INNER JOIN orders o ON c.cust_no = o.cust_no
INNER JOIN orderlines ol ON o.order_no = ol.order_no
GROUP BY c.cname, o.cust_no
ORDER BY 2 ASC;

--QUESTION - 7
SELECT o.cust_no, c.cname, SUM(ol.price*ol.qty), COUNT(*) 
FROM customers c
INNER JOIN orders o ON c.cust_no = o.cust_no
INNER JOIN orderlines ol ON o.order_no = ol.order_no
WHERE c.cname LIKE '%A' OR c.cname LIKE '%D%'
GROUP BY c.cname, o.cust_no
ORDER BY 4;
*/

