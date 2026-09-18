{{
    config(
        materialized='incremental',
        incremental_strategy= 'delete+insert',
        unique_key='id'
    )
}}
with source as (
select * from {{ source('demodb', 'orders') }}
)

select * from source
{% if is_incremental() %}
    -- this filter will only be applied on an incremental run
    where order_date > (select max(order_date) from {{ this }}) 
{% endif %}