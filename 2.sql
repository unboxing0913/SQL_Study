--local-sqldb

----create table  testrtbl(id number(4),username nchar(3),age number(2));
----insert into testrtbl values(1,'홍길동',25);
----insert into testrtbl (id,username)values(2,'설현');
----insert into testrtbl (username,age,id)values('지민',26,3);
----select *from testrtbl;
--
--create table testtbl2(
--id number(4),
--username nchar(3),
--age number(2),
--nation nchar(4) default '대한민국'
--);
--
--create sequence idseq
--    start with 1
--    increment by 1;
--
--insert into testtbl2 values (idseq.nextval,'유나',25,default);
--insert into testtbl2 values (idseq.nextval,'혜정',24,'영국');
--select * from testtbl2;
--
--drop sequence idseq;
--
--insert into testtbl2 values(11,'쯔위',18,'대만');
--alter sequence idseq
--    increment by 10; --증가값 다시 설정 
--                --현재 자동으로 2까지 입력되었으므로 10을 더하면
--                --다음 값12가 될까?
--    insert into testtbl2 values(idseq.nextval,'미나',21,'일본');
--
--alter sequence idseq
--    increment by 1;  --증가값 다시 설정  
--select * from testtbl2;
--
--select idseq.currval from dual;
----select idseq.currval;
--select sysdate from dual;
----select sysdate;
--select 20*20 from dual;


-------------------------------------------------------------------
--create table testtbl4(empid number(6),firstname varchar2(20),
--    lastname varchar2(25),phone varchar2(20));
--
--insert into testtbl4 
--SELECT employee_id, first_name,last_name,phone_number
--from hr.employees;

select*from testtbl4;    
delete from testtbl4;

create table testtbl5 as 
SELECT employee_id, first_name,last_name,phone_number
from hr.employees;

select * from testtbl5;
select * from HR.employees;

commit;

select *from tab;
select * from testtbl4;

update testtbl4
    set phone='없음'
    where fisrname='David';
    
rollback;

---------------------------------------------------------------------
create table membertbl as
    (select userid,username,addr from usertbl);
select * from membertbl;

create table changetbl
(userid char(8),
username nvarchar2(10),
addr nchar(2),
changetype nchar(4) --변경사유
);

insert into changetbl values('tkv','태권브이','한국','신규가입');
insert into changetbl values('lsg',null,'제주','주소변경');
insert into changetbl values('ljb',null,'영국','주소변경');
insert into changetbl values('bbk',null,'탈퇴','회원탈퇴');
insert into changetbl values('ssk',null,'탈퇴','회원탈퇴');

select * from changetbl;
select * from membertbl;

--두개의테이블을 연결
merge into membertbl M  --변경될테이블 약자
--변경할 기준이 되는 테이블
using(select changetype,userid,username,addr from changetbl) C-- 사용할테이블 약자
on(M.userid=C.userid) -- userid를 기준으로 두테이블을 비교한다.   
--target 테이블에 source 테이블의 행이 있으면 주소를 변경한다
when matched then               --일치할때 t
    update set M.addr=C.addr
    --target 테이블에 source 테이블의 행이 있고 사유가 '회원탈퇴'라면 
    --해당 행을 삭제
    delete where C.changetype='회원탈퇴'
    --target 테이블에 source 테이블의 행이 없으면 새로운 행을 추가한다.
when not matched then           --일치하지 않을때 f
    insert(userid,username,addr) values(C.userid,C.username,C.addr);
    
select * from membertbl;
--함수 하나하나 실행시켜보기
select ascii('A'),chr(65),asciistr('한'),unistr('\d55c')from dual;
select length('한글'),length('AB'),length('한글'),length('AB') from dual;
select replace('오늘 저녁은 매우 덥다','덥다','춥다') from dual;
select substr('오늘도 데이터베이스 공부를 했다',5,10) from dual;
select reverse('ORACLE') from dual;
select ltrim('          oracle                ') from dual;
select rtrim('$$$$oracle$$$$','$')from dual;
select trim('           oracle                ')from dual;
select regexp_count('오늘도 오늘도 내일도 모레도 ','도') from dual;


select row_number() over(order by height desc,username)"키큰순위",
    userName,addr,height from usertbl;
    
select addr,row_number() over(partition by addr order by height desc,userName asc)"지역별 키큰순위",
    userName,addr,height from usertbl;
    
select dense_rank() over(order by height desc)"키큰순위",
    userName,addr,height from usertbl;
    
    commit;