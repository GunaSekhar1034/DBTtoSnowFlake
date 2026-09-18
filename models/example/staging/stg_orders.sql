with source as(
    select * from {{ source('demodb', 'orders') }}
),
renamed as (
        SELECT 
        order_id   AS o_id,
        product_id AS p_id,
        customer_id AS cust_id,
        quantity,
        status,
        order_date
    FROM source
    WHERE order_date IS NOT NULL
)
select * from renamed;