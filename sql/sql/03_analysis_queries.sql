USE pizzahut;

-- Q1. Total number of orders
SELECT COUNT(*) AS total_orders
FROM orders;

-- Q2. Total revenue generated from pizza sales
SELECT ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM order_details od
JOIN pizzas p
    ON p.pizza_id = od.pizza_id;

-- Q3. Highest-priced pizza
SELECT
    pt.name,
    p.size,
    p.price
FROM pizzas p
JOIN pizza_types pt
    ON pt.pizza_type_id = p.pizza_type_id
ORDER BY p.price DESC
LIMIT 1;

-- Q4. Most common pizza size by quantity ordered
SELECT
    p.size,
    SUM(od.quantity) AS pizzas_ordered
FROM pizzas p
JOIN order_details od
    ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY pizzas_ordered DESC
LIMIT 1;

-- Q5. Top 5 most ordered pizza types
SELECT
    pt.name,
    SUM(od.quantity) AS quantity_ordered
FROM pizza_types pt
JOIN pizzas p
    ON p.pizza_type_id = pt.pizza_type_id
JOIN order_details od
    ON od.pizza_id = p.pizza_id
GROUP BY pt.name
ORDER BY quantity_ordered DESC
LIMIT 5;

-- Q6. Total quantity ordered by pizza category
SELECT
    pt.category,
    SUM(od.quantity) AS quantity_ordered
FROM pizza_types pt
JOIN pizzas p
    ON p.pizza_type_id = pt.pizza_type_id
JOIN order_details od
    ON od.pizza_id = p.pizza_id
GROUP BY pt.category
ORDER BY quantity_ordered DESC;

-- Q7. Distribution of orders by hour of day
SELECT
    HOUR(order_time) AS order_hour,
    COUNT(*) AS order_count
FROM orders
GROUP BY HOUR(order_time)
ORDER BY order_hour;

-- Q8. Number of pizza types in each category
SELECT
    category,
    COUNT(*) AS pizza_type_count
FROM pizza_types
GROUP BY category
ORDER BY pizza_type_count DESC;

-- Q9. Average number of pizzas ordered per day
SELECT
    ROUND(AVG(daily_quantity), 2) AS avg_pizzas_per_day
FROM (
    SELECT
        o.order_date,
        SUM(od.quantity) AS daily_quantity
    FROM orders o
    JOIN order_details od
        ON od.order_id = o.order_id
    GROUP BY o.order_date
) AS daily_sales;

-- Q10. Top 3 pizza types by revenue
SELECT
    pt.name,
    ROUND(SUM(od.quantity * p.price), 2) AS revenue
FROM pizza_types pt
JOIN pizzas p
    ON p.pizza_type_id = pt.pizza_type_id
JOIN order_details od
    ON od.pizza_id = p.pizza_id
GROUP BY pt.name
ORDER BY revenue DESC
LIMIT 3;

-- Q11. Percentage contribution of each category to total revenue
SELECT
    pt.category,
    ROUND(
        SUM(od.quantity * p.price) /
        (
            SELECT SUM(od2.quantity * p2.price)
            FROM order_details od2
            JOIN pizzas p2
                ON p2.pizza_id = od2.pizza_id
        ) * 100,
        2
    ) AS revenue_percentage
FROM pizza_types pt
JOIN pizzas p
    ON p.pizza_type_id = pt.pizza_type_id
JOIN order_details od
    ON od.pizza_id = p.pizza_id
GROUP BY pt.category
ORDER BY revenue_percentage DESC;

-- Q12. Cumulative revenue over time
SELECT
    order_date,
    ROUND(
        SUM(daily_revenue) OVER (ORDER BY order_date),
        2
    ) AS cumulative_revenue
FROM (
    SELECT
        o.order_date,
        SUM(od.quantity * p.price) AS daily_revenue
    FROM orders o
    JOIN order_details od
        ON od.order_id = o.order_id
    JOIN pizzas p
        ON p.pizza_id = od.pizza_id
    GROUP BY o.order_date
) AS daily_revenue_data
ORDER BY order_date;

-- Q13. Top 3 revenue-generating pizza types within each category
WITH pizza_revenue AS (
    SELECT
        pt.category,
        pt.name,
        SUM(od.quantity * p.price) AS revenue
    FROM pizza_types pt
    JOIN pizzas p
        ON p.pizza_type_id = pt.pizza_type_id
    JOIN order_details od
        ON od.pizza_id = p.pizza_id
    GROUP BY pt.category, pt.name
),
ranked_pizzas AS (
    SELECT
        category,
        name,
        ROUND(revenue, 2) AS revenue,
        DENSE_RANK() OVER (
            PARTITION BY category
            ORDER BY revenue DESC
        ) AS revenue_rank
    FROM pizza_revenue
)
SELECT
    category,
    name,
    revenue,
    revenue_rank
FROM ranked_pizzas
WHERE revenue_rank <= 3
ORDER BY category, revenue_rank;
