# Write your MySQL query statement below

with endd as (
    select 
    machine_id,
    process_id,
    timestamp
    from 
    activity
    where activity_type = 'end'
),
startt as (
    select 
    machine_id,
    process_id,
    timestamp
    from 
    activity
    where activity_type = 'start'
),
diff as (
    select
    startt.machine_id as a1,
    startt.process_id as a2, 
    endd.machine_id as a3,
    endd.process_id as a4,
    startt.timestamp as a5,
    endd.timestamp as a6,
    ROUND(endd.timestamp-startt.timestamp,3) as difftime
    from
    endd 
    inner join startt on startt.machine_id = endd.machine_id
    and startt.process_id = endd.process_id
),
stg as (
    select
    a1,
    sum(difftime) as r1,
    count(*) as r2
    from 
    diff
    group by 
    a1
)
select 
a1 as machine_id,ROUND(r1/r2,3) as processing_time
from 
stg
