# DB LAB 8

create schema hotel_booking;

use hotel_booking;

create table hotel
(hotelno varchar(10) primary key,
hotelname varchar(20),
city varchar(20));

insert into hotel
values('fb01', 'Pearl Continental', 'Bhurbhan');
insert into hotel
values('fb02', 'Hospitality Inn', 'Lahore');
insert into hotel
values('ch01', 'Avari', 'Lahore');
insert into hotel
values('ch02', 'Marriott', 'Islamabad');
insert into hotel
values('dc01', 'Hotel Inn', 'Lahore');

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
values(10001, 'Awais Ismail', 'Ferozpur Road, Lahore');
insert into guest
values(10002, 'Mehmood Ahmed', 'Nishtar Colony, Lahore');
insert into guest
values(10003, 'Muhammad Abdullah', 'Gulshan Town, Jhelum');
insert into guest
values(10004, 'Muaaz Saqiq', 'Karim Bloack, Lahore');
insert into guest
values(10005, 'Sohaib Javed', 'Wapda Town, Lahore');
insert into guest
values(10006, 'Saad Ali', 'Baghbanpura, Lahore');
insert into guest
values(10007, 'Muhammad Arham', 'Sadiq Colony, Saqdiqabad');

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
values('fb01', 10004, '04-08-15', '04-08-15', 601);
insert into booking
values('fb01', 10005, '03-05-02', '03-05-07', 501);
insert into booking
values('fb01', 10001, '04-08-01', null, 701);
insert into booking
values('fb02', 10003, '09-04-05', '10-04-04', 1001);
insert into booking
values('ch01', 10006, '04-04-21', null, 1101);
insert into booking
values('ch02', 10002, '19-03-29', '19-04-06', 801);
insert into booking
values('dc01', 10007, '19-04-01', '19-04-03', 1001);
insert into booking
values('dc01', 10003, '12-05-20', null, 1001);

# Q1
select sum(r.price) as totalrevenue
from room r
where r.type = 'double';

# Q2
select count(distinct b.guestno)
from booking b
where dateFrom like '____-08-%';

# Q3
select r.price, r.type
from room r join hotel h on r.hotelno = h.hotelno
where h.hotelname ='Avari' and h.city = 'Lahore';

# Q4
select g.guestno, g.guestname
from guest g join booking b on g.guestno = b.guestno join hotel h on b.hotelno = h.hotelno
where h.hotelname = 'Marriott' and sysdate() between b.dateFrom and b.dateTo;

# Q5
select sum(r.price) as totalincome
from room r join booking b on r.hotelno = b.hotelno and r.roomno = b.roomno join hotel h on b.hotelno = h.hotelno
where h.hotelname = 'Hotel Inn' and sysdate() between b.dateFrom and b.dateTo;

# Q6
select r.roomno
from room r join hotel h on r.hotelno = h.hotelno
where h.hotelname = 'Hotel Inn' and r.roomno not in
(select b.roomno
from booking b
where sysdate() between b.dateFrom and b.dateTo);

# Q7
select sum(r.price) as lostincome
from room r join hotel h on r.hotelno = h.hotelno
where h.hotelname = 'Hotel Inn' and r.roomno not in
(select b.roomno
from booking b
where sysdate() between b.dateFrom and b.dateTo);

# Q8
select sum(r.price) as lostincome
from room r
where r.roomno not in
(select b.roomno
from booking b
where sysdate() between b.dateFrom and b.dateTo);

# Q9
select sum(r.price) as lostincome
from room r
where r.roomno not in
(select b.roomno
from booking b
where sysdate() between b.dateFrom and b.dateTo)
and r.hotelno in
(select r.hotelno
from room r
group by r.hotelno
having count(r.type) > 2);

# Q10

update room
set price = 1.02*price;

select r.roomno, r.price
from room r;