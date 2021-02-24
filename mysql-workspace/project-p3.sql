# DB PROJECT PHASE III

# creating schema for store

create schema estore;

use estore;

# creating table for admins

create table admin
(username varchar(12) not null unique check (length(username) >= 6),
email varchar(32) not null unique check (email like '%@%.%'),
ipassword varchar(24) not null check (length(password) >= 8),
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
(orderid int not null auto_increment unique check (length(orderid) = 6),
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

alter table iorder auto_increment = 600000;

# creating table for carts

create table cart
(cartid int not null auto_increment unique check (length(cartid) = 6),
carttotal float,
customerid varchar(12),
primary key (cartid),
foreign key (customerid) references customer (username) on delete set null on update cascade);

alter table cart auto_increment = 500000;

# creating table for brands

create table brand
(brandid int not null auto_increment unique check (length(brandid) = 6),
bname varchar(24),
primary key (brandid));

alter table brand auto_increment = 200000;

# creating table for categories

create table category
(categoryid int not null auto_increment unique check (length(categoryid) = 6),
cname varchar(24),
primary key (categoryid));

alter table category auto_increment = 300000;

# creating table for products

create table product
(productid int not null auto_increment unique check (length(productid) = 6),
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

alter table product auto_increment = 100000;

# creating table for reviews

create table review
(reviewid int not null auto_increment unique check (length(reviewid) = 6),
rating float check (prating >= 1 and prating <= 5),
icomment varchar(64),
customerid varchar(12),
productid int,
primary key (reviewid),
foreign key (customerid) references customer (username) on delete set null on update cascade,
foreign key (productid) references product (productid) on delete set null on update cascade);

alter table review auto_increment = 400000;

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