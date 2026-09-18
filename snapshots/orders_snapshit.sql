{% snapshot orders_snapshit %}
    {{
        config(
            unique_key='order_id',
            strategy='timestamp',
            invalidate_hard_deletes=False,
            updated_at='load_date_time'
        )
    }}

    select *, current_timestamp() as load_date_time
     from {{ source('demodb', 'orders') }}
 {% endsnapshot %}