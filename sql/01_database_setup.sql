CREATE DATABASE IF NOT EXISTS pizzahut;
USE pizzahut;

DROP TABLE IF EXISTS order_details;
DROP TABLE IF EXISTS pizzas;
DROP TABLE IF EXISTS pizza_types;
DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
    order_id INT NOT NULL,
    order_date DATE NOT NULL,
    order_time TIME NOT NULL,
    PRIMARY KEY (order_id)
);

CREATE TABLE pizza_types (
    pizza_type_id VARCHAR(50) NOT NULL,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    ingredients TEXT NOT NULL,
    PRIMARY KEY (pizza_type_id)
);

CREATE TABLE pizzas (
    pizza_id VARCHAR(50) NOT NULL,
    pizza_type_id VARCHAR(50) NOT NULL,
    size VARCHAR(5) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (pizza_id),
    CONSTRAINT fk_pizzas_type
        FOREIGN KEY (pizza_type_id)
        REFERENCES pizza_types(pizza_type_id)
);

CREATE TABLE order_details (
    order_details_id INT NOT NULL,
    order_id INT NOT NULL,
    pizza_id VARCHAR(50) NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (order_details_id),
    CONSTRAINT fk_details_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id),
    CONSTRAINT fk_details_pizza
        FOREIGN KEY (pizza_id)
        REFERENCES pizzas(pizza_id)
);
