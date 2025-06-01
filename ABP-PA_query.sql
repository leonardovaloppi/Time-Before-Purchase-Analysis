WITH init_data AS (
    SELECT 
        PARSE_DATE('%Y%m%d', CAST(event_date AS STRING)) AS readable_event_date,
        TIMESTAMP_MICROS(event_timestamp) AS readable_event_timestamp,
        *
    FROM `tc-da-1.turing_data_analytics.raw_events`
),

daily_first_event AS (
    SELECT 
        event_name AS daily_first_event_name,
        readable_event_timestamp AS daily_first_event_time,
        *
    FROM (
        SELECT 
            *,
            ROW_NUMBER() OVER (PARTITION BY user_pseudo_id, readable_event_date ORDER BY readable_event_timestamp) AS rn
        FROM init_data
    )
    WHERE rn = 1
),

daily_first_purchase AS (
    SELECT 
        user_pseudo_id,
        readable_event_date,
        MIN(readable_event_timestamp) AS daily_first_purchase_time,
        MAX(purchase_revenue_in_usd) AS revenue,
    FROM init_data
    WHERE event_name = 'purchase'
    GROUP BY user_pseudo_id, readable_event_date
),

output AS (
    SELECT 
        dfe.user_pseudo_id,
        dfe.readable_event_date,
        dfe.daily_first_event_name,
        dfe.daily_first_event_time,
        dfp.daily_first_purchase_time,
        CAST(TIMESTAMP_DIFF(dfp.daily_first_purchase_time, dfe.daily_first_event_time, SECOND) AS INT64) AS seconds_to_purchase,
        dfe.category AS device,
        dfe.mobile_brand_name,
        dfe.mobile_model_name,
        dfe.operating_system,
        dfe.language,
        dfe.browser,
        dfe.browser_version,
        dfe.country,
        dfe.medium,
        dfe.campaign,
        dfp.revenue,
        CASE WHEN dfp.revenue = 0 THEN 1 ELSE 0 END AS is_gift
    FROM daily_first_event dfe
    JOIN daily_first_purchase dfp
      ON dfe.user_pseudo_id = dfp.user_pseudo_id
     AND dfe.readable_event_date = dfp.readable_event_date
),

percentiles AS (
    SELECT 
        PERCENTILE_CONT(seconds_to_purchase, 0.25) OVER() AS p25,
        PERCENTILE_CONT(seconds_to_purchase, 0.75) OVER() AS p75
    FROM output
    LIMIT 1
)

SELECT 
    output.*,
    CASE WHEN seconds_to_purchase > (p75 + 1.5 * (p75 - p25))
        OR seconds_to_purchase < (p25 - 1.5 * (p75 - p25)) 
        THEN 1
        ELSE 0
        END AS is_outlier
FROM output
CROSS JOIN percentiles
ORDER BY readable_event_date