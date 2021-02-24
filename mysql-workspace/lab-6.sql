CREATE SCHEMA BOAT_DB;

CREATE TABLE SAILOR
(sid int NOT NULL,
sname varchar(20),
rating int,
age FLOAT,
PRIMARY KEY (sid));

CREATE TABLE BOAT
(bid int NOT NULL,
bname VARCHAR(20),
color VARCHAR(10),
PRIMARY KEY (bid));

CREATE TABLE RESERVE
(sid int NOT NULL,
bid int NOT NULL,
day DATE,
FOREIGN KEY (sid) REFERENCES SAILOR (sid),
FOREIGN KEY (bid) REFERENCES BOAT (bid));

INSERT INTO SAILOR
VALUES
(22, 'Dustin', 7, 45.0),
(29, 'Brutus', 1, 33.0),
(31, 'Lubber', 8, 55.5),
(32, 'Andy', 8, 25.5),
(58, 'Rusty', 10, 35.0),
(64, 'Horatio', 7, 35.0),
(71, 'Zorba', 10, 16.0),
(74, 'Horatio', 9, 35.0),
(85, 'Art', 3, 25.5),
(95, 'Bob', 3, 63.5);

INSERT INTO BOAT
VALUES
(101, 'Interlake', 'Blue'),
(102, 'Interlake', 'Red'),
(103, 'Clipper', 'Green'),
(104, 'Marine', 'Red');

INSERT INTO RESERVE
VALUES
(22, 101, '1998-10-10'),
(22, 102, '1998-10-10'),
(22, 103, '1998-08-10'),
(22, 104, '1998-07-10'),
(31, 102, '1998-10-11'),
(31, 103, '1998-06-11'),
(31, 104, '1998-12-11'),
(64, 101, '1998-05-09'),
(64, 102, '1998-08-09'),
(74, 103, '1998-08-09');

# Q1
SELECT S.sname, S.age
FROM SAILOR S;

# Q2
SELECT *
FROM SAILOR S
WHERE S.rating > 7;

# Q3
SELECT S.sname
FROM SAILOR S, RESERVE R
WHERE S.sid = R.sid AND R.bid = 103;

# Q4
SELECT DISTINCT S.sid
FROM SAILOR S, RESERVE R, BOAT B
WHERE S.sid = R.sid AND R.bid = B.bid AND B.color = 'Red';

# Q5
SELECT S.sname
FROM SAILOR S, RESERVE R, BOAT B
WHERE S.sid = R.sid AND R.bid = B.bid AND B.color = 'Red';

# Q6
SELECT B.color
FROM BOAT B, RESERVE R, SAILOR S
WHERE B.bid = R.bid AND R.sid = S.sid AND S.sname = 'Lubber';

# Q7
SELECT DISTINCT S.sname
FROM SAILOR S, RESERVE R
WHERE S.sid = R.sid;

SELECT DISTINCT S.sname
FROM SAILOR S, RESERVE R
WHERE EXISTS
(SELECT *
FROM RESERVE R
WHERE S.sid = R.sid);

# Q8
SELECT DISTINCT S.sname, S.rating+1 as rating
FROM SAILOR S, RESERVE R1, RESERVE R2
WHERE S.sid = R1.sid AND S.sid = R2.sid AND R1.day = R2.day AND R1.bid != R2.bid;

# Q9
SELECT S.age
FROM SAILOR S
WHERE S.sname LIKE 'b_%b';


# Q10
(SELECT S.sname
FROM SAILOR S, RESERVE R, BOAT B
WHERE S.sid = R.sid AND R.bid = B.bid AND B.color = 'Red')
UNION
(SELECT S.sname
FROM SAILOR S, RESERVE R, BOAT B
WHERE S.sid = R.sid AND R.bid = B.bid AND B.color = 'Green');

SELECT DISTINCT S.sname
FROM SAILOR S, RESERVE R, BOAT B
WHERE S.sid = R.sid AND R.bid = B.bid AND (B.color = 'Red' OR B.color = 'Green');

# Q11
SELECT DISTINCT S.sname
FROM SAILOR S, RESERVE R, BOAT B
WHERE S.sid = R.sid AND R.bid = B.bid AND B.color = 'Red'
AND S.sid IN
(SELECT DISTINCT S.sid
FROM SAILOR S, RESERVE R, BOAT B
WHERE S.sid = R.sid AND R.bid = B.bid AND B.color = 'Green');

# Q12
SELECT DISTINCT S.sid
FROM SAILOR S, RESERVE R, BOAT B
WHERE S.sid = R.sid AND R.bid = B.bid AND B.color = 'Red'
AND S.sid NOT IN
(SELECT DISTINCT S.sid
FROM SAILOR S, RESERVE R, BOAT B
WHERE S.sid = R.sid AND R.bid = B.bid AND B.color = 'Green');

# Q13
SELECT DISTINCT S.sid
FROM SAILOR S, RESERVE R
WHERE S.sid = R.sid AND (S.rating = 10 OR R.bid = 104);