{{
    config(
        materialized='ephemeral'
    )
}}
-- Ephemeral dont create table but it will but you can use this model in different model (like store procedure or view)
with source as (
    select * from {{ source('demodb', 'orders') }}
)

select * from source 
where order_date is null