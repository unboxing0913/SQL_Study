--local-sqldb

select userid,sum(price*amount) as "총구매액"
from buytbl
group by userid
order by sum(price*amount)desc;

--사용자 이름 추가 inner join
select u.userid,u.username,sum(b.price*b.amount) as "총구매액",
case
    when (sum(price*amount)>=1500) then '최우수 고객'
    when (sum(price*amount)>=1000) then '우수 고객'
    when (sum(price*amount)>=1) then '일반 고객'
    else '별 볼일 없는 고객'
end as "고객 등급"

from buytbl b right outer join usertbl u on b.userid = u.userid
group by u.userid , u.username
order by sum(price*amount)desc nulls last;
--------------------------------------------------------------
set serveroutput on;
declare 
 v_username usertbl.username%type;
 begin
 select username into v_username from usertbl
 where username like ('김%');
 dbms_output.put_line('김씨고객 이름은'||v_username||'입니다');
 exception --예외처리
 when no_data_found then  --예외이름
 dbms_output.put_line('김씨 고객이 없습니다.');
 when too_many_rows then --예외이름
 dbms_output.put_line('김씨 고객이 너무 많네요.');
 end;
