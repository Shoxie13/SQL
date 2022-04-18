SELECT SYSDATE + 1 AS "Next Day"
FROM sys.dual;

SELECT employee_id, first_name ||' '|| last_name AS "Employee Name", hire_date
FROM employees
WHERE hire_date BETWEEN '01-JUN-2016' AND '01-DEC-2016'
ORDER BY hire_date DESC, last_name;

SELECT job_id , first_name || ' ' || last_name AS "Full Name"
FROM employees
WHERE (first_name LIKE '%e%' OR first_name LIKE '%E%')
AND (first_name LIKE '%a%' 
OR first_name LIKE '%g%'
OR last_name LIKE '%a%'
OR last_name LIKE '%g%');

SELECT job_id , 
    first_name || ' ' || last_name AS "Full Name"
FROM employees
WHERE (first_name LIKE '%e%' OR first_name LIKE '%E%')
AND (first_name LIKE '%a%' 
OR first_name LIKE '%g%'
OR last_name LIKE '%a%'
OR last_name LIKE '%g%');

SELECT LAST_NAME||','||FIRST_NAME||' works as a '||JOB_ID
FROM employees
WHERE manager_id = 124;

SELECT last_name, hire_date
FROM employees
WHERE hire_date < '01-OCT-2010';

SELECT last_name, hire_date,
        TO_CHAR(NEXT_DAY(ADD_MONTHS(hire_date, 12), 'TUESDAY'),'fmDAY, " the " Ddspth " of " Month, YYYY') as "REVIEW"
FROM employees
WHERE hire_date > '01-JAN-2019'
ORDER BY 3;

SELECT last_name, hire_date, TO_CHAR(ROUND((sysdate - hire_date) / 365)) AS "Worked Years"
FROM employees
WHERE hire_date < '01-OCT-2010'
ORDER BY 3;

SELECT prod_no, prod_name, prod_sell, 
    ROUND(prod_sell + (prod_sell * 2.0 / 100.0)) AS "Increased Price"
FROM products
WHERE (prod_no > 50000 AND prod_no < 60000)
AND (prod_name LIKE 'G%' OR prod_name LIKE 'AS%');

SELECT employee_id, first_name ||' '|| last_name AS "Employee Name", hire_date
FROM employees
WHERE hire_date BETWEEN '01-JUN-2016' AND '01-DEC-2016'
ORDER BY hire_date DESC, last_name;