CREATE DATABASE supply_chain_project;
SHOW DATABASES;
USE supply_chain_project;
SHOW TABLES;

-- How efficient is delivery overall?
-- Calculates the average number of days taken to deliver orders 
SELECT ROUND(AVG(delivery_delay_days),2) AS avg_delivery_days
FROM order_cleaned;

-- What % of orders are late?
-- Counts late orders and calculates their percentage.
SELECT ROUND((SUM(CASE WHEN late_delivery = 'YES' THEN 1 ELSE 0 END)/COUNT(*))*100,2) AS late_delivery_percentage 
FROM order_cleaned;


-- Top 5 Suppliers with Highest Delay
-- Sorts suppliers by their average delay.
SELECT supplier,ROUND(avg_delivery_delay,2) AS avg_delivery_delay
FROM supplier_performance
ORDER BY avg_delivery_delay DESC
LIMIT 5;


-- Warehouse Load by Region
-- Shows shipment volume per region.
SELECT warehouse_region,total_quantity,ROUND(total_sales,2) AS total_sales
FROM warehouse_load
ORDER BY total_quantity DESC;


-- Region-wise Late Deliveries
-- Counts late orders per region.
SELECT region, SUM(CASE WHEN late_delivery = 'YES' THEN 1 ELSE 0 END) AS late_orders,
COUNT(*) AS total_orders,
ROUND((SUM(CASE WHEN late_delivery = 'YES' THEN 1 ELSE 0 END)/COUNT(*))*100,2) AS late_delivery_percentage 
FROM order_cleaned
GROUP BY region
ORDER BY late_delivery_percentage DESC;

-- Shipping Mode Impact on Delivery Delay
-- Which shipping mode is the slowest?
SELECT ship_mode,ROUND(AVG(delivery_delay_days),2) AS avg_delivery_delay
FROM order_cleaned
GROUP BY ship_mode
ORDER BY avg_delivery_delay DESC;

-- Product Category vs Delivery Delay
-- Which product category faces the most delivery issues?
SELECT category,ROUND(AVG(delivery_delay_days),2) AS avg_delivery_delay
FROM order_cleaned
GROUP BY category
ORDER BY avg_delivery_delay DESC;

-- Sub-Category Delay Analysis
-- Which specific product sub-categories cause most delays?
SELECT sub_category,ROUND(AVG(delivery_delay_days),2) AS avg_delivery_delay
FROM order_cleaned
GROUP BY sub_category
ORDER BY avg_delivery_delay DESC
LIMIT 5;

-- Return Orders vs Delay Relationship
-- Return Orders vs Delay Relationship
SELECT returned, COUNT(*) AS total_orders, ROUND(AVG(delivery_delay_days),2) AS avg_delivery_delay
FROM order_cleaned
GROUP BY returned;
