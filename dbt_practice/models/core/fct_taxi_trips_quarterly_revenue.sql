{{
    config(
        materialized='table'
    )
}}

WITH tyq AS (
    SELECT
        service_type,
        EXTRACT(YEAR FROM TIMESTAMP(pickup_datetime)) AS year,
        EXTRACT(QUARTER FROM TIMESTAMP(pickup_datetime)) AS quarter,
        SUM(total_amount) AS total_amount
    FROM {{ ref('fact_trips') }}
    GROUP BY service_type, year, quarter
),
y2019 AS (
    SELECT *
    FROM tyq
    WHERE year = 2019
),
y2020 AS (
    SELECT *
    FROM tyq
    WHERE year = 2020
),
tmp as (
    SELECT
        y2019.service_type,
        y2019.quarter,
        y2019.total_amount AS total_amount_2019,
        y2020.total_amount AS total_amount_2020,
    FROM y2019
    JOIN y2020
        ON y2019.service_type = y2020.service_type
        AND y2019.quarter = y2020.quarter
)
select *,
    (total_amount_2020 - total_amount_2019) / total_amount_2019 * 100 as percentage
from tmp
order by service_type, percentage
