-- Q1
SELECT tablename
FROM pg_tables 
WHERE schemaname = 'public';

-- Q2
SELECT table_name, column_name 
FROM information_schema.columns
WHERE table_schema = 'public'

-- Q3
SELECT SUM(dim_store.staff_numbers) 
AS "UK Staff Numbers"
FROM dim_store
WHERE country = 'UK';

-- Q4
SELECT SUM(o.product_quantity * dp.sale_price) AS "Total Sales", dd.month_name as "Month"
FROM orders o 
INNER JOIN dim_date dd ON dd.date = o.order_date
INNER JOIN dim_product dp ON dp.product_code = o.product_code
WHERE dd.year = 2022
GROUP BY "Month"
ORDER BY "Total Sales" DESC 
LIMIT 1;

-- Q5
SELECT SUM(o.product_quantity * dp.sale_price) AS "Total Revenue", ds.store_type AS "Type" 
FROM orders o 
INNER JOIN dim_date dd ON dd.date = o.order_date
INNER JOIN dim_product dp ON dp.product_code = o.product_code
INNER JOIN dim_store ds ON ds.store_code = o.store_code
WHERE dd.year = 2022 AND ds.country = 'Germany'
GROUP BY "Type"
ORDER BY "Total Revenue" DESC
LIMIT 1;

CREATE VIEW Store_facts AS
SELECT 
    "Store Type",
    "Total Revenue",
    "Total Revenue" / SUM("Total Revenue") OVER ()AS "Total Revenue / Out Of Total Revenue Across Rows",
    "Orders"
FROM (
    SELECT 
        ds.store_type AS "Store Type", 
        SUM(o.product_quantity * dp.sale_price) AS "Total Revenue",
        COUNT(o.user_id) AS "Orders"
    FROM 
        orders o
    INNER JOIN 
        dim_store ds ON ds.store_code = o.store_code
    INNER JOIN 
        dim_product dp ON dp.product_code = o.product_code
    GROUP BY 
        "Store Type"
) AS info;


SELECT SUM((o.product_quantity * dp.sale_price) - dp.cost_price) AS "Profit",
dp.category AS "Category", ds.full_region
FROM orders o 
INNER JOIN dim_date dd ON dd.date = o.order_date
INNER JOIN dim_product dp ON dp.product_code = o.product_code
INNER JOIN dim_store ds ON ds.store_code = o.store_code
WHERE dd.year = 2021 AND ds.full_region = 'Wiltshire, UK'
GROUP BY "Category", ds.full_region
ORDER BY "Profit" DESC
LIMIT 1;