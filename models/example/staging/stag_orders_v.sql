{{config(materialized='view')}}

with source as(
    select * from {{ ref('stg_orders') }}
)
select o_id as odr_id, cust_id as c_id, status,
CASE 
        WHEN status = 'Delivered' THEN 'Completed'
        WHEN status = 'Shipped'   THEN 'In Transit'
        WHEN status = 'Pending'   THEN 'Awaiting Fulfillment'
        WHEN status = 'Cancelled' THEN 'Closed'
        ELSE 'Unknown'
    END AS status_category,

    -- Example: flag large orders
    CASE 
        WHEN quantity >= 3 THEN 'Bulk Order'
        ELSE 'Regular Order'
    END AS order_type
from source
