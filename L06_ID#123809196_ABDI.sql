SET SERVEROUTPUT ON

-- ***********************
-- Name: Tareq Abdi
-- Student ID: 123809196
-- Date: 16/03/2021
-- Purpose: Lab 6 DBS311
-- ***********************

--Question 1
--The company wants to calculate what the employees’ annual salary would be

-- Q1 SOLUTION –
CREATE OR REPLACE PROCEDURE calculate_salary(i IN NUMBER) 
AS
    fname VARCHAR2(20 BYTE);
    lname VARCHAR2(25 BYTE);
    bsalary NUMBER(8,2);
    hireDate DATE;
    currentDate DATE;
    DATEDIFF NUMBER;
BEGIN
    SELECT first_name, last_name, salary, hire_date
    INTO fname, lname, bsalary, hireDate
    FROM employees
    WHERE employee_id = i;
    --
    SELECT trunc(sysdate) INTO currentDate FROM dual;
    DATEDIFF := ROUND(((currentDate - hireDate) / 365), 0);
    --
    LOOP
        bsalary := bsalary * 1.05;
        DATEDIFF := DATEDIFF - 1;
        EXIT WHEN DATEDIFF < 1;
    END LOOP;
    --
        DBMS_OUTPUT.PUT_LINE ('First name: ' || fname);
        DBMS_OUTPUT.PUT_LINE ('Last name: ' || lname);
        DBMS_OUTPUT.PUT_LINE ('Salary: ' || bsalary);
        
EXCEPTION
    WHEN OTHERS 
    THEN
        DBMS_OUTPUT.PUT_LINE ('Employee does not exist!');
END calculate_salary;
/

BEGIN
    calculate_salary(100);
END;
/

--Question 2
--Write a stored procedure named employee_works_here to print the employee_id, employee Last name and department name.

-- Q2 SOLUTION –

CREATE OR REPLACE PROCEDURE employee_works_here 
AS
BEGIN
    DBMS_OUTPUT.PUT_LINE ('Employee#    Last Name    Department Name');
    FOR i IN (SELECT employee_id, last_name, department_name, department_id FROM employees e JOIN departments d USING (department_id) ORDER BY 1) LOOP
        IF (i.employee_id BETWEEN 1 AND 105) THEN
            IF (i.department_id IS null OR i.department_id = '') THEN
                DBMS_OUTPUT.PUT_LINE (i.employee_id || '           ' || i.last_name || '           ' || 'no department name');
            ELSE
                DBMS_OUTPUT.PUT_LINE (i.employee_id || '           ' || i.last_name || '         ' || i.department_name);
            END IF;
        END IF;
    END LOOP;
EXCEPTION
    WHEN OTHERS 
    THEN
        DBMS_OUTPUT.PUT_LINE ('Employee does not exist!');
END employee_works_here;
/

BEGIN
    employee_works_here;
END;
/
