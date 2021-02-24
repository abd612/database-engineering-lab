CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `username` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


create schema reg;

use reg;

drop table admin;

create table admin
(username varchar(12) not null unique check (length(username) >= 6),
email varchar(32) not null unique check (email like '%@%.%'),
ipassword varchar(24) not null check (length(password) >= 8),
fname varchar(16),
lname varchar(16),
primary key (username));

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