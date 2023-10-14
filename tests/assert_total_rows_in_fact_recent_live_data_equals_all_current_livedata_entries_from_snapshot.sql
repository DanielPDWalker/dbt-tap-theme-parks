-- assert that the number of nows in fact_recent_live_data equals the count of entries in the livedata arrays
-- of all current live data from live_data_snapshot

SELECT
    COUNT(unpacked_live_data)
FROM {{ ref('live_data_snapshot') }} lds, JSONB_ARRAY_ELEMENTS(lds.livedata) AS unpacked_live_data
WHERE dbt_updated_at IS NULL
HAVING COUNT(unpacked_live_data) != (
    SELECT
        COUNT(*)
    FROM {{ ref('fact_recent_live_data') }}
)