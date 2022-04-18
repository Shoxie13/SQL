SET SERVEROUTPUT ON

-- ***********************
-- Name: Tareq Abdi
-- Student ID: 123809196
-- Date: 27/02/2021
-- Purpose: Lab 5 DBS311
-- ***********************

--Question 1 
-- Write a stored procedure that gets an integer number and prints
-- The number is even.
-- If a number is divisible by 2.
-- Otherwise, it prints 
-- The number is odd.

--Question 1 SOLUTION

CREATE OR REPLACE PROCEDURE check_num(i IN NUMBER) IS
BEGIN
    IF MOD(i, 2) = 0
    THEN
        DBMS_OUTPUT.PUT_LINE ('The number is even.');
    ELSE
        DBMS_OUTPUT.PUT_LINE ('The number is odd.');
    END IF;
EXCEPTION
	WHEN OTHERS
  THEN 
      DBMS_OUTPUT.PUT_LINE ('Error!');
END check_num;
/

BEGIN
  check_num(5);
END;
/

--Question 2 
--Create a stored procedure named find_employee. This procedure gets an employee number and prints the following employee information:
--First name 
--Last name 
--Email
--Phone 	
--Hire date 
--Job ID
--
--The procedure gets a value as the employee ID of type NUMBER.
--See the following example for employee ID 107:   This is not the answer you will get for employee 107
--
--First name: Summer
--Last name: Payn
--Email: summer.payne@example.com
--Phone: 515.123.8181
--Hire date: 07-JUN-16
--Job title: Public Accountant
--
--The procedure displays a proper error message if any error occurs.

--Question 2 SOLUTION

CREATE OR REPLACE PROCEDURE find_employee(i IN NUMBER) AS
    fname VARCHAR2(20 BYTE);
    lname VARCHAR2(25 BYTE);
    email VARCHAR2(25 BYTE);
    phone VARCHAR2(20 BYTE);
    hdate DATE;
    jobid VARCHAR2(10 BYTE);
BEGIN
    SELECT first_name, last_name, email, phone_number, hire_date, job_id 
    INTO fname, lname, email, phone, hdate, jobid
    FROM employees
    WHERE employee_id = i;
        DBMS_OUTPUT.PUT_LINE ('First name: ' || fname);
        DBMS_OUTPUT.PUT_LINE ('Last name: ' || lname);
        DBMS_OUTPUT.PUT_LINE ('Email: ' || email || '@companyName.com');
        DBMS_OUTPUT.PUT_LINE ('Phone: ' || phone);
        DBMS_OUTPUT.PUT_LINE ('Hire date: ' || hdate);
        DBMS_OUTPUT.PUT_LINE ('Job title: ' || jobid);
EXCEPTION
	WHEN no_data_found THEN
	        DBMS_OUTPUT.PUT_LINE ('No Data Found!');
END find_employee;
/

BEGIN
    find_employee(107);
END;
/

-- Question 3 – 
--Every year, the company increases the price of all products in one product type. 
--For example, the company wants to increase the selling price of products in type Tents by $5. 
--Write a procedure named update_price_tents to update the price of all products in the given type and the given amount to be added to the current selling price if the price is greater than 0. 
--The procedure shows the number of updated rows if the update is successful.
--The procedure gets two parameters:
--•	Prod_type IN VARCHAR2
--•	amount 	NUMBER(9,2)
--To define the type of variables that store values of a table column, you can also write:
--	variable_name table_name.column_name%type;
--The above statement defines a variable of the same type as the type of the table column.
--	Example: category_id 	products.category_id%type;
--Or you need to see the table definition to find the type of the prod_type update column. Make sure the type of your variable is compatible with the value that is stored in your variable.
--To show the number of affected rows the update query, declare a variable named rows_updated of type NUMBER and use the SQL variable sql%rowcount to set your variable. Then, print its value in your stored procedure. (Something like this is in the notes supplied to you)
--Rows_updated := sql%rowcount;
--SQL%ROWCOUNT stores the number of rows affected by an INSERT, UPDATE, or DELETE.
--NOTE: Do not forget ROLLBACK;

--Question 3 SOLUTION

CREATE OR REPLACE PROCEDURE update_price_tents(ptype IN VARCHAR2 ,amount IN NUMBER)
AS
    rows_updated NUMBER;
BEGIN
    UPDATE products
    SET prod_sell = prod_sell + amount
    WHERE prod_type = ptype AND prod_sell > 0;
    --
    IF SQL%ROWCOUNT != 0 
    THEN
      rows_updated := sql%rowcount;
    END IF;
    --
    DBMS_OUTPUT.PUT_LINE ('UPDATED ROWS: ' || rows_updated);
EXCEPTION
	WHEN no_data_found THEN
	        DBMS_OUTPUT.PUT_LINE ('No Data Found!');
END update_price_tents;
/

BEGIN
    update_price_tents('Tents', 5);
END;
/

ROLLBACK;

-- Question 4 
--Every year, the company increases the price of products by 1 or 2% (Example of 2% -- prod_sell * 1.02) based on if the selling price (prod_sell) is less than the average price of all products. 
--Write a stored procedure named update_low_prices_123456789 where 123456789 is replaced by your student number.
--This procedure does not have any parameters. You need to find the average sell price of all products and store it into a variable of the same data type. If the average price is less than or equal to $1000, then update the products selling price by 2% if that products sell price is less than the calculated average. 
--If the average price is greater than $1000, then update products selling price by 1% if the price of the products selling price is less than the calculated average. 
--The query displays an error message if any error occurs. Otherwise, it displays the number of updated rows.
--
--An example of an output produced by your code might be the following or perhaps nicer
--
--*** OUTPUT update_low_prices_123456789  STARTED ***
--
--Number of updates:  27
--
------ENDED --------
--NOTE: Do not forget ROLLBACK;

--Question 4 SOLUTION

CREATE OR REPLACE PROCEDURE update_low_prices_123809196
AS
    average NUMBER;
    rows_updated NUMBER;
BEGIN
    SELECT ROUND(AVG(prod_sell), 2) INTO average
    FROM products;
    --
    IF average <= 1000
    THEN
        UPDATE products
        SET prod_sell = prod_sell * 1.02
        WHERE prod_sell < average;
    ELSE
        UPDATE products
        SET prod_sell = prod_sell * 1.01
        WHERE prod_sell < average;
    END IF;
    --
    IF SQL%ROWCOUNT != 0 
    THEN
      rows_updated := sql%rowcount;
    END IF;
    --
    DBMS_OUTPUT.PUT_LINE ('-------------------------------');
    DBMS_OUTPUT.PUT_LINE ('|       **** OUTPUT ****      |');
    DBMS_OUTPUT.PUT_LINE ('| update_low_prices_123456789 |');
    DBMS_OUTPUT.PUT_LINE ('|      **** STARTED ****      |');
    DBMS_OUTPUT.PUT_LINE ('| Number of updates: ' || rows_updated || '       |');
    DBMS_OUTPUT.PUT_LINE ('|       **** ENDED ****       |');
    DBMS_OUTPUT.PUT_LINE ('-------------------------------');
EXCEPTION
	WHEN no_data_found THEN
	        DBMS_OUTPUT.PUT_LINE ('No Data Found!');
END update_low_prices_123809196;
/

BEGIN
    update_low_prices_123809196;
END;
/

ROLLBACK;

-- QUESTION 5.	
--The company needs a report that shows three categories of products based their prices. The company needs to know if the product price is cheap, fair, or expensive. Let us assume that
--	- If the list price is less than the (average sell price – minimum sell price) divided by 2
--		The product’s price is LOW.
--	- If the list price is greater than the maximum less the average divided by 2
--	The product’ price is HIGH.
--	- If the list price is between 
--o	(average price – minimum price) / 2  AND   (maximum price – average price) / 2 INCLUSIVE
--	The product’s price is fair.
--Write a procedure named price_report_123456789  to show the number of products in each price category:
--The following is a sample output of the procedure if no error occurs:
--Low:  10
--Fair: 50
--High: 18  
--The values in the above examples are just random values and may not match the real numbers in your result.
--The procedure has no parameter. First, you need to find the average, minimum, and maximum prices (list_price) in your database and store them into variables avg_price, min_price, and max_price.
--You need three more variables to store the number of products in each price category:
--low_count
--fair_count
--high_count
--Make sure you choose a proper type for each variable. You may need to define more variables based on your solution.
--NOTE: Do not forget ROLLBACK;

--Question 5 SOLUTION

CREATE OR REPLACE PROCEDURE price_report_123809196
AS
    CURSOR n IS SELECT prod_sell FROM products;
    avg_price NUMBER := 0;
    min_price NUMBER := 0;
    max_price NUMBER := 0;
    --
    case_one NUMBER := 0;
    case_two NUMBER := 0;
    case_three NUMBER := 0;
    --
    low_count NUMBER := 0;
    fair_count NUMBER := 0;
    high_count NUMBER := 0;
BEGIN
    SELECT ROUND(AVG(prod_sell),0), ROUND(MIN(prod_sell),0), ROUND(MAX(prod_sell),0)
    INTO avg_price, min_price, max_price
    FROM products;
    
    case_one := (avg_price - min_price) / 2;
    case_two := (max_price - avg_price) / 2;
    case_three := avg_price / 2;
    --
    FOR r IN n
    LOOP
        IF r.prod_sell < case_one
        THEN
            low_count := low_count + 1;
        ELSIF r.prod_sell > case_two
        THEN
            high_count := high_count + 1;
        ELSIF r.prod_sell BETWEEN case_one AND case_two
        THEN
            fair_count := fair_count + 1;
        END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE ('Low: ' || low_count);
    DBMS_OUTPUT.PUT_LINE ('Fair: ' || fair_count);
    DBMS_OUTPUT.PUT_LINE ('High: ' || high_count);
EXCEPTION
	WHEN no_data_found THEN
	        DBMS_OUTPUT.PUT_LINE ('No Data Found!');
END price_report_123809196;
/

BEGIN
    price_report_123809196;
END;
/

ROLLBACK;