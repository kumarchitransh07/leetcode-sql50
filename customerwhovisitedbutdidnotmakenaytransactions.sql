with notvis as (
    select
    customer_id,
    visit_id
    from 
    visits
    where visit_id not in (select visit_id from transactions)
)
select
customer_id,
count(customer_id) as count_no_trans
from
notvis
group by customer_id
