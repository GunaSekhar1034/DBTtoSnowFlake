{{
    config(
        materialized='table',
        pre_hook= ["alter table DEMO_DB.DBT_GUNASEKHAR1034.model_lock rename column runat to run_at",
                   "alter table DEMO_DB.DBT_GUNASEKHAR1034.model_lock rename column staus to status"],
        post_hook= ["insert into DEMO_DB.DBT_GUNASEKHAR1034.model_lock(modelname, status, run_at)
                        values ('m1','S', current_timestamp),
                                ('m2', 'F', dateadd(hour, -1, current_timestamp))"]
    )
}}

WITH orders_cte AS (
    SELECT * FROM DEMO_DB.DBT_GUNASEKHAR1034.orders
),
products_cte AS (
    SELECT * FROM {{ source('demodb', 'products') }}
)

SELECT 
    o.order_id,
    o.customer_id,
    o.status,
    o.order_date,
    p.product_id,
    p.product_name,
    p.price
FROM orders_cte o
JOIN products_cte p
    ON o.product_id = p.product_id