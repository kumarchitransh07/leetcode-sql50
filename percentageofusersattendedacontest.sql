select
    r.contest_id,
    round(count(r.user_id) * 100.0 / (select count(*) from users), 2) as percentage
from
    users u
    left join register r on r.user_id = u.user_id
where
    r.contest_id is not null
group by
    r.contest_id
order by
    percentage desc,
    r.contest_id;
