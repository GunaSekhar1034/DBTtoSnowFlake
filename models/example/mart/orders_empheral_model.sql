{{ config(materialized='table') }}

WITH orders_cte AS (
    SELECT * FROM {{ ref('orders_empheral') }}
)

SELECT
    order_id,
    customer_id,
    status,
    order_date,
    CASE 
        WHEN status = 'Delivered' THEN 'Completed'
        ELSE 'Open'
    END AS status_flag
FROM orders_cte
