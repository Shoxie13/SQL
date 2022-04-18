--LAB 04
--QUESTION 1
--SELECT last_name, hire_date
--FROM employees
--WHERE hire_date < (SELECT hire_date 
--                    FROM employees 
--                    WHERE employee_id = 144)
--ORDER BY 2;

--QUESTION 2
--SELECT last_name, salary
--FROM employees
--WHERE salary IN (SELECT MIN(salary) FROM employees)
--ORDER BY 1;

--QUESTION 3
--SELECT prod_no, prod_name, prod_type, prod_sell
--FROM products
--WHERE prod_sell IN (SELECT MAX(prod_sell) 
--                    FROM products 
--                    GROUP BY prod_type)
--ORDER BY 3;

--QUESTION 4
--SELECT prod_line, MAX(prod_sell)
--FROM products 
--GROUP BY prod_line
--HAVING MAX(prod_sell) > (SELECT MIN(prod_sell) FROM products);

--QUESTION 5
--SELECT prod_name, prod_sell
--FROM products
--WHERE prod_sell < ANY (SELECT prod_sell FROM products WHERE prod_type = 'Sleeping Bags')
--ORDER BY 2, 1;

--QUESTION 6
--SELECT prod_no, prod_name, prod_type 
--FROM products
--WHERE (prod_type, prod_sell) 
--IN (SELECT prod_type, MAX(prod_sell) 
--                    FROM products 
--                    GROUP BY prod_type);

--QUESTION 7
--SELECT TO_CHAR(SYSDATE + 1, 'MONTH DD"th of year" YYYY') AS "TOMORROW" FROM dual;

--QUESTION 8
--SELECT city, country_cd, COALESCE(prov_state, 'State Missing') AS STATE
--FROM customers
--WHERE city LIKE ('s%') AND LENGTH(city) >= 8;

















