with comb as (select
p.project_id,
e.experience_years
from 
project p
inner join employee e
on p.employee_id = e.employee_id
),fin as (
    select
    project_id,
    ROUND(sum(experience_years)/count(project_id),2) as average_years
    from comb
    group by project_id
)
select
project_id,
average_years
from fin
