{{ config(materialized='table') }}

with live_data_snapshot as (
    SELECT
        *
    FROM {{ ref ('live_data_snapshot') }}
    WHERE dbt_valid_to is null
),
unpacked_live_data as (
    SELECT 
        id as park_id
        , entitytype
        , "name" as park_name
        , timezone as park_timezone
        , dbt_updated_at as data_sync_time
        , unpacked_livedata->>'id' as attraction_id
        , unpacked_livedata->>'name' as attraction_name
        , unpacked_livedata->>'queue' as attraction_queue
        , unpacked_livedata->>'status' as attraction_status
        , unpacked_livedata->>'entityType' as attraction_entity_type
        , unpacked_livedata->>'lastUpdated' as attraction_last_updated
    FROM live_data_snapshot, JSONB_ARRAY_ELEMENTS(livedata) AS unpacked_livedata
)
SELECT * FROM unpacked_live_data