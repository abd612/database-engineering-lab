#Q1
SELECT sailor.sname,sailor.age FROM sailor ;
#Q2
SELECT sailor.sname FROM sailor WHERE sailor.rating > 7 ;
#Q3
SELECT sailor.sname FROM sailor,reserve WHERE sailor.sid=reserve.sid AND reserve.bid='103' ;
#Q4
SELECT distinct sailor.sid FROM sailor,reserve,boat WHERE sailor.sid=reserve.sid AND reserve.bid=boat.bid AND boat.color='Red' ;
#Q5
SELECT distinct sailor.sname FROM sailor,reserve,boat WHERE sailor.sid=reserve.sid AND reserve.bid=boat.bid AND boat.color='Red' ;
#Q6
SELECT distinct boat.color FROM sailor,reserve,boat WHERE sailor.sid=reserve.sid AND reserve.bid=boat.bid AND sailor.sname='Lubber' ;
#Q6
SELECT distinct sailor.sid,sailor.sname FROM sailor,reserve,boat WHERE sailor.sid=reserve.sid AND boat.bid=reserve.bid ;
#Q7
SELECT distinct s.sid,s.rating + 1 as new_rating
from sailor as s, reserve as r1, reserve as r2
where s.sid = r1.sid and r1.r_day = r2.r_day and r1.bid <> r2.bid and r1.sid = r2.sid; 
#Q8
SELECT sailor.age FROM sailor WHERE sailor.sname LIKE '%B_%b' ;
#Q9
SELECT distinct sailor.sname FROM sailor,reserve,boat WHERE sailor.sid=reserve.sid AND boat.bid=reserve.bid AND (boat.color='Red' OR boat.color='Green') ;
#Q10
SELECT distinct sailor.sname FROM sailor,reserve,boat WHERE sailor.sid=reserve.sid AND boat.bid=reserve.bid AND boat.color='Red' AND sailor.sname 
IN (SELECT distinct sailor.sname FROM sailor,boat,reserve WHERE sailor.sid=reserve.sid AND boat.bid=reserve.bid AND boat.color='Green') ;

#Q11
SELECT distinct sailor.sid FROM sailor,reserve,boat WHERE sailor.sid=reserve.sid AND reserve.bid=boat.bid AND boat.color='Red' AND sailor.sid
NOT IN (SELECT distinct sailor.sid FROM sailor,boat,reserve WHERE sailor.sid=reserve.sid AND reserve.bid=boat.bid AND boat.color='Green');

#Q12
SELECT distinct sailor.sid FROM sailor,reserve WHERE sailor.rating='10' OR (sailor.sid=reserve.sid AND reserve.bid='104') ;

