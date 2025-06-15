{{
    config(
        materialized='table'
    )
}}


with cte as (
    select 
    service_type,
    EXTRACT(YEAR FROM TIMESTAMP(pickup_datetime)) AS year,
    EXTRACT(MONTH FROM TIMESTAMP(pickup_datetime)) AS month,
    fare_amount
    from {{ ref('fact_trips') }}
    WHERE
        fare_amount > 0 AND
        trip_distance > 0 AND
        payment_type_description IN ('Cash', 'Credit card')
),
cte2 as (
    select *,
        PERCENTILE_CONT(fare_amount, 0.97) OVER (
            PARTITION BY service_type, year, month
        ) AS p97_fare,
        PERCENTILE_CONT(fare_amount, 0.95) OVER (
            PARTITION BY service_type, year, month
        ) AS p95_fare,
        PERCENTILE_CONT(fare_amount, 0.90) OVER (
            PARTITION BY service_type, year, month
        ) AS p90_fare
    from cte
)
select DISTINCT cte2.service_type,
    cte2.year,
    cte2.month,
    cte2.p97_fare,
    cte2.p95_fare,
    cte2.p90_fare
from cte2
where 
    service_type IN ('Green', 'Yellow') AND
    year = 2020 AND
    month = 4

