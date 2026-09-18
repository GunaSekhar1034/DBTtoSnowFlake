{{
    config(
        materialized='table'
    )
}}
with source as (
   select * from {{ source('demodb', 'products') }}
)
select * , round({{cent_to_doller('price')}},3) as discount_price
from source