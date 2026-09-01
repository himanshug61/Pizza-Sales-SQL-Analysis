USE pizzahut;

-- Keep the four CSV files in the same project folder.
-- LOCAL INFILE must be enabled in MySQL.

LOAD DATA LOCAL INFILE 'orders.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(@order_id, @order_date, @order_time)
SET
    order_id = @order_id,
    order_date = STR_TO_DATE(@order_date, '%Y-%m-%d'),
    order_time = @order_time;

LOAD DATA LOCAL INFILE 'pizza_types.csv'
INTO TABLE pizza_types
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'pizzas.csv'
INTO TABLE pizzas
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'order_details.csv'
INTO TABLE order_details
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- Quick validation
SELECT 'orders' AS table_name, COUNT(*) AS row_count FROM orders
UNION ALL
SELECT 'order_details', COUNT(*) FROM order_details
UNION ALL
SELECT 'pizzas', COUNT(*) FROM pizzas
UNION ALL
SELECT 'pizza_types', COUNT(*) FROM pizza_types;
