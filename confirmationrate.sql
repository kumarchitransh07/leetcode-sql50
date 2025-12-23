with tot_conf as (
    select 
    user_id,
    count(action) as cnfac
    from
    confirmations
    where action = 'confirmed'
    group by user_id
),
tot_msg as (
    select
    user_id,
    count(action) as totac
    from
    confirmations
    group by user_id
)
select
s.user_id,
COALESCE(ROUND((tot_conf.cnfac / tot_msg.totac),2),0) as confirmation_rate 
from
signups s
left join tot_conf on s.user_id = tot_conf.user_id
left join  tot_msg on s.user_id = tot_msg.user_id


