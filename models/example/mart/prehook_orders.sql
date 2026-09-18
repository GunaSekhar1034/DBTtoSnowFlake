{{
    config(
        materialized='table',
        pre_hook = ["drop table DEMO_DB.DBT_GUNASEKHAR1034.temp_orders_v ",
                    "create or replace table DEMO_DB.DBT_GUNASEKHAR1034.temp_orders_v 
                        as 
                        select * from DEMO_DB.DBT_GUNASEKHAR1034.orders"]
    )
}}
with t1 as (
    select * from DEMO_DB.DBT_GUNASEKHAR1034.temp_orders_v
)
select * from t1