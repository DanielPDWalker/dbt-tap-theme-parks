{{ config(materialized='table') }}

with destinations as (
    SELECT * FROM {{ source ('theme_parks_source', 'destination_detail') }}
),
destinations as (
    SELECT 
        id
        , "name"
        , slug
        , timezone
        , "location"
    FROM parks
)
SELECT * FROM destinations