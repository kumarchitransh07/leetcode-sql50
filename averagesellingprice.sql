with cal as (select
p.product_id,
us.units as un,
COALESCE(price*units,0) as pu
from
prices p
inner join unitssold us
on p.product_id = us.product_id
and us.purchase_date between p.start_date and p.end_date),
fin as (
    select
    product_id,
    ROUND(sum(pu)/sum(un),2) as average_price
    from
    cal
    group by product_id
)
select
product_id,
average_price
from
fin
