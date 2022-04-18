SET SERVEROUTPUT ON

-- find_customer (customer_id IN NUMBER, found OUT NUMBER)
CREATE OR REPLACE PROCEDURE find_customer (customer_id IN NUMBER, found OUT NUMBER) AS
BEGIN
   SELECT COUNT(*)
   INTO found
   FROM customers 
   WHERE cust_no = customer_id;
EXCEPTION
	WHEN NO_DATA_FOUND
  	THEN 
      	found := 0;
END;

/

-- find_product (product_id IN NUMBER, price OUT products.prod_sell%TYPE)
CREATE OR REPLACE PROCEDURE find_product (product_id IN NUMBER, price OUT products.prod_sell%TYPE) AS
BEGIN
    SELECT prod_sell
    INTO price
    FROM products
    WHERE prod_no = product_id;
EXCEPTION
    WHEN NO_DATA_FOUND 
    THEN
        price := 0;
END;
/

-- add_order (customer_id IN NUMBER, new_order_id OUT NUMBER)
CREATE OR REPLACE PROCEDURE add_order (customer_id IN NUMBER, new_order_id OUT NUMBER) AS
new_order_date Orders.order_dt%TYPE;
BEGIN
    SELECT MAX(order_no)+1 
    INTO new_order_id
    FROM orders;
    
    SELECT TO_CHAR(SYSDATE, 'DD-MON-YYYY')
    INTO new_order_date
    FROM dual;
    
    INSERT INTO orders
    (order_no, rep_no, cust_no, order_dt, status)
    VALUES (new_order_id, 36, customer_id,  new_order_date, 'C');
    --rollback;
END;
/

-- add_orderline (orderId IN orderlines.order_no%type, itemId IN orderlines.line_no%type, productId IN orderlines.prod_no%type, 
--                quantity IN orderlines.qty%type, price IN orderlines.price%type)
CREATE OR REPLACE PROCEDURE add_orderline (orderId IN orderlines.order_no%type, 
                                            itemId IN orderlines.line_no%type, 
                                            productId IN orderlines.prod_no%type, 
                                            quantity IN orderlines.qty%type, 
                                            price IN orderlines.price%type) AS
BEGIN
    INSERT INTO orderlines
    (order_no, line_no, prod_no, price, qty)
    VALUES (orderId, itemId, productId, quantity, price);
END;
/


-- show orders in 2021
SELECT cname, order_no, prod_no, SUM(price*qty)
FROM customers 
JOIN orders
USING (cust_no)
JOIN orderlines
USING (order_no)
WHERE (SELECT SUBSTR(order_dt,8,4) FROM DUAL) = '2021'
GROUP BY (cname, order_no, prod_no);




-- cleaning stuff
DELETE FROM orders
WHERE channel is null;

DELETE FROM orderlines
WHERE disc_perc is null;

