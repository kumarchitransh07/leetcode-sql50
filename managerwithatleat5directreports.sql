select 
name
from 
employee
where id in (select
managerId
from
employee
group by managerId
having count(*) >= 5 )


count(name)  = non null values so will fail in below test case 

| id  | name | department | managerId |
| --- | ---- | ---------- | --------- |
| 101 | null | A          | null      |
| 102 | null | A          | 101       |
| 103 | null | A          | 101       |
| 104 | null | A          | 101       |
| 105 | null | A          | 101       |
| 106 | null | B          | 101       |
