# 🍕 Pizza Sales SQL Analysis

**Author:** Himanshu Gupta  
**Role:** Aspiring Data Analyst  
**Tool:** MySQL 8.0+  
**Dataset:** Pizza Sales — 2015

## 📌 Project Overview

This project analyzes pizza sales data using SQL to understand order volume, revenue, product demand, category performance, and ordering patterns.

The project demonstrates practical SQL skills including:

- SELECT, WHERE, ORDER BY, LIMIT
- Aggregate functions: COUNT, SUM, AVG
- GROUP BY and HAVING concepts
- INNER JOINs across relational tables
- Subqueries
- CASE/aggregation-style analytical thinking
- Window functions: DENSE_RANK and SUM OVER
- Time-based analysis
- Revenue and KPI calculations

## 🗂️ Database Structure

The database contains four related tables:

1. `orders` — order date and time
2. `order_details` — quantity and pizza ordered in each order
3. `pizzas` — pizza size and price
4. `pizza_types` — pizza name, category and ingredients

## 📊 Dataset Validation

| Table | Rows |
|---|---:|
| orders | 21,350 |
| order_details | 48,620 |
| pizzas | 96 |
| pizza_types | 32 |

## 🔍 Key Results

- **Total Orders:** 21,350
- **Total Revenue:** $817,860.05
- **Average Pizzas Ordered per Day:** 138.47
- **Highest-Priced Pizza:** The Greek Pizza — $35.95
- **Most Popular Size by Quantity:** L
- **Highest-Quantity Category:** Classic

### Top 5 Pizza Types by Quantity

- The Classic Deluxe Pizza: 2,453
- The Barbecue Chicken Pizza: 2,432
- The Hawaiian Pizza: 2,422
- The Pepperoni Pizza: 2,418
- The Thai Chicken Pizza: 2,371

### Top 3 Pizza Types by Revenue

- The Thai Chicken Pizza: $43,434.25
- The Barbecue Chicken Pizza: $42,768.00
- The California Chicken Pizza: $41,409.50

## 💡 Business Insights

1. Large pizzas account for the highest quantity ordered.
2. The Classic category has the highest overall quantity.
3. Lunch and evening periods are major order-volume windows.
4. A small group of pizza types contributes strongly to overall revenue.
5. Revenue is distributed across all four categories, with Classic leading.

## ▶️ How to Run

### Step 1 — Create the database
Run:

`01_database_setup.sql`

### Step 2 — Import the CSV files
Keep the four CSV files in the same project folder and run:

`02_data_import.sql`

If MySQL reports that `LOCAL INFILE` is disabled, enable it in your MySQL client/server configuration.

### Step 3 — Run the analysis
Run:

`03_analysis_queries.sql`

## 📁 Project Files

- `01_database_setup.sql`
- `02_data_import.sql`
- `03_analysis_queries.sql`
- `orders.csv`
- `order_details.csv`
- `pizzas.csv`
- `pizza_types.csv`
- `Pizza_Sales_SQL_Analysis_Report.pdf`

## 🎯 Portfolio Use

This project is suitable for a Data Analyst fresher portfolio and can be discussed in interviews as an example of relational data analysis, SQL joins, aggregation, KPI calculation, and advanced window-function analysis.
