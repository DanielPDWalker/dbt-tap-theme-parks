{{ config(materialized='table') }}

with destinations as (
    SELECT * FROM {{ source ('theme_parks_source', 'destinations') }}
),
dim_parks as (
    SELECT 
        id AS destination_id
        , "name" AS destination_name
        , slug AS destination_slug
        , unpacked_parks->>'id' AS park_id
        , unpacked_parks->>'name' AS park_name 
    FROM destinations, JSONB_ARRAY_ELEMENTS(parks) AS unpacked_parks
)
SELECT * FROM dim_parks