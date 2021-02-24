# DB LAB 7

create schema hotelBooking;

use hotelBooking;

create table hotel
(hotelno varchar(10) primary key,
hotelname varchar(20),
city varchar(20));

insert into hotel
values('fb01', 'Grosvenor', 'London');
insert into hotel
values('fb02', 'Watergate', 'Paris');
insert into hotel
values('ch01', 'Omni Shoreham', 'London');
insert into hotel
values('ch02', 'Phoenix Park', 'London');
insert into hotel
values('dc01', 'Latham', 'Berlin');

create table room
(roomno numeric(5),
hotelno varchar(10),
type varchar(10),
price decimal(5,2),
primary key (roomno, hotelno),
foreign key (hotelno) REFERENCES hotel(hotelno));

insert into room
values(501, 'fb01', 'single', 19);
insert into room
values(601, 'fb01', 'double', 29);
insert into room
values(701, 'fb01', 'family', 39);
insert into room
values(1001, 'fb02', 'single', 58);
insert into room
values(1101, 'fb02', 'double', 86);
insert into room
values(1001, 'ch01', 'single', 29.99);
insert into room
values(1101, 'ch01', 'family', 59.99);
insert into room
values(701, 'ch02', 'single', 10);
insert into room
values(801, 'ch02', 'double', 15);
insert into room
values(901, 'dc01', 'single', 18);
insert into room
values(1001, 'dc01', 'double', 30);
insert into room
values(1101, 'dc01', 'family', 35);

create table guest
(guestno numeric(5),
guestname varchar(20),
guestaddress varchar(50),
primary key (guestno));

insert into guest
values(10001, 'John Kay', '56 High St, London');
insert into guest
values(10002, 'Mike Ritchie', '18 Tain St, London');
insert into guest
values(10003, 'Mary Tregear', '5 Tarbot Rd, Aberdeen');
insert into guest
values(10004, 'Joe Keogh', '2 Fergus Dr, Aberdeen');
insert into guest
values(10005, 'Carol Farrel', '6 Achray St, Glasgow');
insert into guest
values(10006, 'Tina Murphy', '63 Well St, Glasgow');
insert into guest
values(10007, 'Tony Shaw', '12 Park Pl, Glasgow');

create table booking
(hotelno varchar(10),
guestno numeric(5),
datefrom datetime,
dateto datetime,
roomno numeric(5),
primary key (hotelno, guestno, datefrom),
foreign key (roomno, hotelno) REFERENCES room(roomno, hotelno),
foreign key (guestno) REFERENCES guest(guestno));

insert into booking
values('fb01', 10001, '02-04-01', '02-04-08', 501);
insert into booking
values('fb01', 10004, '04-04-15', '04-05-15', 601);
insert into booking
values('fb01', 10005, '03-05-02', '03-05-07', 501);
insert into booking
values('fb01', 10001, '04-05-01', null, 701);
insert into booking
values('fb02', 10003, '09-04-05', '10-04-04', 1001);
insert into booking
values('ch01', 10006, '04-04-21', null, 1101);
insert into booking
values('ch02', 10002, '04-04-25', '04-05-06', 801);
insert into booking
values('dc01', 10007, '06-05-13', '06-05-15', 1001);
insert into booking
values('dc01', 10003, '12-05-20', null, 1001);

# Q1
select g.guestname, g.guestaddress
from guest g join booking b on g.guestno = b.guestno join hotel h on b.hotelno = h.hotelno
where h.city = 'London'
order by g.guestname;

# Q2
select h.hotelname, count(*) as roomcount
from hotel h join room r on h.hotelno = r.hotelno
group by h.hotelno;

# Q3
select h.hotelname, avg(r.price) as averageprice
from hotel h join room r on h.hotelno = r.hotelno
where h.city = 'London'
group by h.hotelno;

# Q4
select r.type, r.roomno, max(r.price) as maxprice
from room r
group by r.type
order by r.type = 'family', r.type = 'single', r.type = 'double';

# Q5
select h.hotelname, h.city, count(r.type) as roomtypes
from hotel h join room r on h.hotelno = r.hotelno
group by h.hotelno;

# Q6
select distinct h.hotelname, h.city
from hotel h join booking b on h.hotelno = b.hotelno join guest g on b.guestno = g.guestno
where g.guestaddress like '%London%';

# Q7
select distinct h.hotelname, h.city, count(*) as reservations
from hotel h join booking b on h.hotelno = b.hotelno
group by h.hotelno
order by reservations desc;

# Q8
select g.guestname
from guest g join booking b on g.guestno = b.guestno
where b.dateto is null;

# Q9
select h.hotelname, b.roomno, b.guestno
from hotel h join booking b on h.hotelno = b.hotelno
where b.datefrom like '2003%' or b.datefrom like '2004%';

# Q10
select h.hotelname, h.city
from hotel h
where h.hotelno not in
(select b.hotelno
from booking b);

# Q11
select h.hotelname, h.hotelno, r.roomno, r.price
from hotel h left join
(select *
from room r
where r.type = 'family') r
on h.hotelno = r.hotelno
order by r.price desc;

# Q12
select min(r.price) as minprice, h.city
from room r join hotel h on r.hotelno = h.hotelno
group by h.city;

# Q13
select count(distinct b.guestno) as distinctguests
from booking b
where b.datefrom <= '2015-05-31';

# Q14
select *
from room r
where (r.type = 'double' or r.type = 'family') and r.price < 40
order by r.price asc;