{{
    config(
        materialized='table'
    )
}}


with cte as (
    select *,
    TIMESTAMP_DIFF(TIMESTAMP(dropoff_datetime), TIMESTAMP(pickup_datetime), SECOND) as trip_duration
    from {{ ref('dim_fhv_trips') }}
    where
        pickup_zone in ('Newark Airport', 'SoHo',  'Yorkville East') AND
        year = 2019 AND
        month = 11
), cte2 as (
    select *,
        PERCENTILE_CONT(trip_duration, 0.90) OVER (
            PARTITION BY year, month, pulocationid, dolocationid
        ) AS p90_duration
    from cte
),
ranked as (
    select *,
    dense_rank() over(PARTITION by pickup_zone order by p90_duration desc) as rk
    from cte2
)
select distinct dropoff_zone
from ranked
where rk = 2 

    