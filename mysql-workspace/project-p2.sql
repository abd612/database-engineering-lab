# DB PROJECT PHASE II

# creating schema for store

create schema store_db_p2;

use store_db_p2;

# creating table for admins

create table admin
(username varchar(12) not null unique check (length(username) >= 6),
email varchar(32) not null unique check (email like '%@%.%'),
password varchar(24) not null check (length(password) >= 8),
fname varchar(16),
lname varchar(16),
primary key (username));

# creating table for customers

create table customer
(username varchar(12) not null unique check (length(username) >= 6),
email varchar(32) not null unique check (email like '%@%.%'),
ipassword varchar(24) not null check (length(password) >= 8),
fname varchar(16),
lname varchar(16),
birthday date check (birthday < sysdate()),
age int check (age > 0 and age < 120),
gender varchar(6) check (gender in ('male', 'female')),
primary key (username));

# creating table for orders

create table iorder
(orderid int not null unique check (length(orderid) = 6),
ordertotal float,
idate date,
istatus varchar(16),
address varchar(32),
phone varchar(24),
company varchar(24),
itype varchar(12),
inumber varchar(24),
cvv int,
expiry date check (expiry > sysdate()),
customerid varchar(12),
adminid varchar(12),
primary key (orderid),
foreign key (customerid) references customer (username) on delete set null on update cascade,
foreign key (adminid) references admin (username) on delete set null on update cascade);

# creating table for carts

create table cart
(cartid int not null unique check (length(cartid) = 6),
carttotal float,
customerid varchar(12),
primary key (cartid),
foreign key (customerid) references customer (username) on delete set null on update cascade);

# creating table for brands

create table brand
(brandid int not null unique check (length(brandid) = 6),
bname varchar(24),
primary key (brandid));

# creating table for categories

create table category
(categoryid int not null unique check (length(categoryid) = 6),
cname varchar(24),
primary key (categoryid));

# creating table for products

create table product
(productid int not null unique check (length(productid) = 6),
pname varchar(24),
price float,
stock int check (stock >= 0),
prating float check (prating >= 1 and prating <= 5),
picture varchar(32),
description varchar(64),
brandid int,
categoryid int,
primary key (productid),
foreign key (brandid) references brand (brandid) on delete set null on update cascade,
foreign key (categoryid) references category (categoryid) on delete set null on update cascade);

# creating table for reviews

create table review
(reviewid int not null unique check (length(reviewid) = 6),
rating float check (prating >= 1 and prating <= 5),
icomment varchar(64),
customerid varchar(12),
productid int,
primary key (reviewid),
foreign key (customerid) references customer (username) on delete set null on update cascade,
foreign key (productid) references product (productid) on delete set null on update cascade);

# creating table for relationship of carts and products

create table cart_products
(cartid int,
productid int,
cquantity int check (cquantity > 0),
check (cquantity <= product (stock)),
primary key (cartid, productid),
foreign key (cartid) references cart (cartid) on update cascade,	
foreign key (productid) references product (productid) on update cascade);

# creating table for relationship of orders and products

create table order_products
(orderid int,
productid int,
oquantity int check (oquantity > 0),
check (oquantity <= product (stock)),
primary key (orderid, productid),
foreign key (orderid) references iorder (orderid) on update cascade,
foreign key (productid) references product (productid) on update cascade);

# register for admin

insert into admin
values ('abd612', 'abdullah612@outlook.com', 'abdullah', 'Muhammad', 'Abdullah');

# register for customer

insert into customer
values ('awais65', 'awaisismail65@gmail.com', 'awais123', 'Awais', 'Ismail', '1998-05-25', 20, 'male');

# add a brand

insert into brand
values (200000, 'OnePlus');

insert into brand
values (200001, 'Haier');

# add a category

insert into category
values (300000, 'Smartphone');

insert into category
values (300001, 'Laptop');

# add a product

insert into product
values (100000, 'OnePlus 3T', 45000, 10, 5, 'op3t.jpg', 'The latest smartphone from OnePlus', 200000, 300000);

insert into product
values (100001, 'Haier Y11B', 40000, 10, 5, 'y11b.jpg', 'The detachable laptop from Haier.', 200001, 300001);

# edit a product

update product
set stock = 9
where productid = 100000;

# view all products in a category

select p.pname, p.price, p.stock, p.prating, p.picture, p.description, b.bname, c.cname
from product p join category c on p.categoryid = c.categoryid join brand b on p.brandid = b.brandid
where c.cname = 'Smartphone';

# view all products from a brand

select p.pname, p.price, p.stock, p.prating, p.picture, p.description, b.bname, c.cname
from product p join category c on p.categoryid = c.categoryid join brand b on p.brandid = b.brandid
where b.bname = 'OnePlus';

# search for a product

select p.pname, p.price, p.stock, p.prating, p.picture, p.description, b.bname, c.cname
from product p join category c on p.categoryid = c.categoryid join brand b on p.brandid = b.brandid
where p.pname like '%oneplus%';

# give a review

insert into review
values (400000, 5, 'The phone is amazing!', 'awais65', 100000);

update product
set prating = (prating + 4)/2
where productid = 100000;

# read all reviews for a product

select p.pname, r.rating, r.icomment
from review r join product p on r.productid = p.productid
where p.productid = 100000;

#  create cart for a customer

insert into cart
values (500000, 0, 'awais65');

# add item to cart

insert into cart_products
values (500000, 100000, 1);

insert into cart_products
values (500000, 100001, 1);

update product
set stock = (stock - 1)
where productid = 100001;

update cart
set carttotal = carttotal + 40000
where cartid = 500000;

# view cart

select p.pname, p.price, cp.cquantity, c.carttotal
from cart c join cart_products cp on c.cartid = cp.cartid join product p on cp.productid = p.productid
where c.customerid = 'awais65';

# place order

insert into iorder
values (600000, 45000, '2019-04-28', 'order placed', 'Chungi Amir Sidhu, Lahore', '0320-4529016', 'HBL', 'Mastercard', '1234-5678-9012-3456', 786, '2020-12-12', 'awais65', 'abd612');

insert into order_products
values (600000, 100000, 1);

# change order status

update iorder
set istatus = 'order shipped'
where orderid = 600000;

select * from cart_products where cartid = (select cartid from cart where customerid = 'awais65');

insert into iorder (orderid, ordertotal, customerid) values (600000, 85000, awais65);

select ordertotal, idate, istatus
            from iorder
            where customerid = 'awais65';
            
update iorder
set idate = curdate(), istatus = 'Order Placed', address = 'Gulshan Town, Jhelum',
phone = '3009514141', company = 'HBL', itype = 'UnionPay', inumber = '1111-2222-3333-4444', cvv = 786, expiry = '2019-12-31'
where orderid = 100003;

SELECT CURDATE();

delete from cart_products where cartid = 500000;

update cart set carttotal = 0 where cartid = 500000;

create table test
(tid int not null auto_increment unique check (length(brandid) = 6),
tname varchar(24),
primary key (tid));

alter table test auto_increment=100000;

insert into test (tname)
values ('test1');

select *
from test;

drop table test;

insert into brand (bname)
values ('OnePlus');

insert into brand (bname)
values ('Haier');

# add a category

insert into category (cname)
values ('Smartphone');

insert into category (cname)
values ('Laptop');

# add a product

insert into product (pname, price, stock, prating, picture, description, brandid, categoryid)
values ('OnePlus 3T', 45000, 10, 5, 'op3t.jpg', 'The latest smartphone from OnePlus', 200000, 300000);

insert into product (pname, price, stock, prating, picture, description, brandid, categoryid)
values ('Haier Y11B', 40000, 10, 5, 'y11b.jpg', 'The detachable laptop from Haier.', 200001, 300001);

drop schema estore;

insert into cart_products
values (500000, 100000, 1);

insert into cart_products
values (500000, 100001, 1);

update cart
set carttotal = carttotal + 40000
where cartid = 500000;

insert into review (rating, icomment, customerid, productid)
values (5, 'The phone is amazing!', 'awais65', 100000);

update product
set prating = (prating + 4)/2
where productid = 100000;

# read all reviews for a product

select r.customerid, p.pname, r.rating, r.icomment
from review r join product p on r.productid = p.productid
where p.productid = 100000;

insert into cart_products
values (500001, 100000, 1);

drop schema estore;