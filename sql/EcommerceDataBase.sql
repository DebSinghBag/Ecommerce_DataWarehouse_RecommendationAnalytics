CREATE DATABASE ecommerce_db;
USE DATABASE ecommerce_db;
CREATE SCHEMA IF NOT EXISTS warehouse;
USE SCHEMA warehouse;
CREATE OR REPLACE TABLE fact_sales (
sale_id INT,
customer_id INT,
product_id INT,
date_id INT,
quantity INT,
total_amount FLOAT
);

CREATE OR REPLACE TABLE dim_product (
product_id INT,
category STRING,
sub_category STRING,
price FLOAT
);
CREATE OR REPLACE TABLE dim_customer (
customer_id INT,
name STRING,
email STRING,
city STRING,
segment STRING
);
SELECT * FROM fact_sales;
ALTER TABLE fact_sales ADD COLUMN price FLOAT;
SELECT * FROM fact_sales;
DROP TABLE IF EXISTS fact_sales;
CREATE TABLE fact_sales (
sale_id INT,
customer_id INT,
product_id INT,
date_id INT,
quantity INT,
price FLOAT,
total_amount FLOAT
);
WITH revenue_cte AS (
    SELECT 
        customer_id,
        SUM(total_amount) AS total_spent
    FROM fact_sales
    GROUP BY customer_id
)
SELECT *
FROM revenue_cte
ORDER BY total_spent DESC;
SELECT 
    customer_id,
    SUM(total_amount) AS total_spent,
    RANK() OVER (ORDER BY SUM(total_amount) DESC) AS customer_rank
FROM fact_sales
GROUP BY customer_id;
SELECT 
    date_id,
    SUM(total_amount) AS daily_revenue
FROM fact_sales
GROUP BY date_id
ORDER BY date_id;
SELECT 
    a.product_id AS product_A,
    b.product_id AS product_B,
    COUNT(*) AS frequency
FROM fact_sales a
JOIN fact_sales b
    ON a.customer_id = b.customer_id
    AND a.product_id <> b.product_id
GROUP BY a.product_id, b.product_id
ORDER BY frequency DESC;
ALTER TABLE fact_sales CLUSTER BY (product_id, date_id);
CREATE ROLE analyst_role;

GRANT SELECT ON fact_sales TO ROLE analyst_role;
CREATE OR REPLACE ROLE analyst_role;
GRANT USAGE ON DATABASE ecommerce_db TO ROLE analyst_role;
GRANT USAGE ON SCHEMA ecommerce_db.warehouse TO ROLE analyst_role;
GRANT SELECT ON TABLE ecommerce_db.warehouse.fact_sales TO ROLE analyst_role;
SELECT * FROM fact_sales;
