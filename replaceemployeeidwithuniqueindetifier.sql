select
coalesce(unique_id,null) as unique_id,
name
from
employees e
left join employeeuni eu 
on e.id = eu.id
