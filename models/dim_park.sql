{{ config(materialized='table') }}

with parks as (
    SELECT * FROM {{ source ('theme_parks_source', 'park_detail') }}
),
dim_park as (
    SELECT 
        id
        , "name"
        , slug
        , timezone
        , "location"
        , destinationid as destination_id
    FROM parks
)
SELECT * FROM dim_park