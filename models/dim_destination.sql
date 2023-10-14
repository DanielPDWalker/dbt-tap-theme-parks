{{ config(materialized='table') }}

with destination_detail as (
    SELECT * FROM {{ source ('theme_parks_source', 'destination_detail') }}
),
destination as (
    SELECT 
        id
        , "name"
        , slug
        , timezone
        , "location"
    FROM destination_detail
)
SELECT * FROM destination