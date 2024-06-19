-- mart_more_comprehensive.sql
WITH comprehensive_data AS (
    SELECT
        city,
        date_trunc('day', extracted_at) as day,
        AVG((extracted_data -> 'forecast' -> 'forecastday' -> 0 -> 'day' ->> 'avgtemp_c')::FLOAT) AS avg_daily_temp_c,
        MIN((extracted_data -> 'forecast' -> 'forecastday' -> 0 -> 'day' ->> 'mintemp_c')::FLOAT) AS min_daily_temp_c,
        MAX((extracted_data -> 'forecast' -> 'forecastday' -> 0 -> 'day' ->> 'maxtemp_c')::FLOAT) AS max_daily_temp_c,
        COUNT(*) AS data_points
    FROM weather_raw
    GROUP BY city, day
)
SELECT * FROM comprehensive_data
WHERE city = 'Berlin' AND day BETWEEN '2024-01-01' AND '2024-12-31';
