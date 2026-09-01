/* ============================================================
   PIZZA SALES SQL ANALYSIS
   Data Import
   Author: Himanshu Gupta
   Tool: MySQL 8.0+
   ============================================================ */

USE pizzahut;

/*
   Place these four CSV files in the same project folder.
   LOCAL INFILE avoids the old machine-specific D:/ path.
   If LOCAL INFILE is disabled in MySQL, enable it in your
   MySQL client/server configuration before running this file.
*/

LOAD DATA LOCAL INFILE 'orders.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@order_id, @order_date, @order_time)
SET
    order_id = @order_id,
    order_date = STR_TO_DATE(@order_date, '%Y-%m-%d'),
    order_time = @order_time;

LOAD DATA LOCAL INFILE 'pizza_types.csv'
INTO TABLE pizza_types
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'pizzas.csv'
INTO TABLE pizzas
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'order_details.csv'
INTO TABLE order_details
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Quick validation
SELECT 'orders' AS table_name, COUNT(*) AS row_count FROM orders
UNION ALL
SELECT 'order_details', COUNT(*) FROM order_details
UNION ALL
SELECT 'pizzas', COUNT(*) FROM pizzas
UNION ALL
SELECT 'pizza_types', COUNT(*) FROM pizza_types;
