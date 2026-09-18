{{
    config(
        materialized='incremental',
        incremental_strategy= 'delete+insert',
        partition_by= {'field': 'order_date', 'data_type': 'date'}
-- chunck the data by partition column and load based on the partition (eg if i load today the and prtition is by date it will replace with date partition by today)
    )
}}
with source as (
select * from {{ source('demodb', 'orders') }}
)

select *, current_timestamp() as Load_Date from source
{% if is_incremental() %}
    -- this filter will only be applied on an incremental run
    where order_date > (select max(order_date) from {{ this }}) 
{% endif %}