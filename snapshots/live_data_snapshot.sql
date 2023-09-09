{% snapshot live_data_snapshot %}

{{
    config(
      target_schema=var('schema'),
      unique_key='id',
      strategy='check',
      check_cols=['livedata'],
    )
}}

with live_data as (
    select * from {{ source ('theme_parks_source', 'live_data') }}
)
select * from live_data
{% endsnapshot %}