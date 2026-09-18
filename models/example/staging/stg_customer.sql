{{
    config(
        materialized='table'
    )
}}

with source as (
select * from {{ source('demodb', 'customers') }}
)
select customer_id, customer_name, email, join_date, replace(split(email,'@')[0], '.', ', ') as shortName
from source 
