# DB LAB 9

create schema house_db;

use house_db;

create table house
(hid int primary key,
address varchar(30),
area decimal(5,2),
value decimal(5,2));

create table owner
(oid int,
hid int,
pdate date,
primary key (oid, hid),
foreign key (hid) references house(hid));

select area, avg(value)
from house
group by area
order by area;

select h.hid, h.address, h.area, h.value, o.oid, o.pdate
from house h left outer join owner o on	h.hid = o.hid;

select *
from owner
where oid in
(select oid
from owner
group by oid
having count(*) >= 2);