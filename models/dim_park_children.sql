{{ config(materialized='table') }}

with parks as (
    SELECT * FROM {{ source ('theme_parks_source', 'park_children') }}
),
dim_park_children as (
    SELECT 
        id AS park_id
        , "name" AS park_name
        , timezone AS park_timezone
        , unpacked_children->>'id' AS child_id
        , unpacked_children->>'name' AS child_name
        , unpacked_children->>'slug' AS child_slug
        , unpacked_children->>'entityType' AS child_entity_type
    FROM parks, JSONB_ARRAY_ELEMENTS(children) AS unpacked_children
)
SELECT * FROM dim_park_children