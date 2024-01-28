{% snapshot destination_children_snapshot %}

{{
    config(
      target_schema=var('schema'),
      unique_key='id',
      strategy='check',
      check_cols=['children'],
    )
}}

with destination_children as (
    select * from {{ source ('theme_parks_source', 'destination_children') }}
)
select * from destination_children
{% endsnapshot %}