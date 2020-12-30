--local-sqldb

select *
from buytbl
inner join usertbl on buytbl.userid=usertbl.userid
where buytbl.userid='jyp';

select buytbl.userid,username,prodname,addr,mobile1||mobile2 as "연락처"
from buytbl,usertbl
where buytbl.userid=usertbl.userid;

select b.userid,u.username,b.prodname,u.addr,u.mobile1||u.mobile2 as "연락처"
from buytbl b
inner join usertbl u
on b.userid=u.userid
where b.userid='jyp';

select b.userid,u.username,b.prodname,u.addr,u.mobile1||u.mobile2 as "연락처"
from usertbl u
inner join buytbl b
on b.userid=u.userid
where b.userid='jyp';

commit;

select b.userid,u.username,b.prodname,u.addr,u.mobile1||u.mobile2 as "연락처"
from usertbl u
inner join buytbl b
on b.userid=u.userid--구매한 기록이 있는 회원들
order by u.userid;

select distinct u.userid,u.username,u.addr --distinct 중복 제거
from usertbl u
inner join buytbl b
on b.userid=u.userid--한번이라도 구매한 기록이 있는 회원들
order by u.userid;

create table stdtbl(
stdname nchar(5) not null primary key,
addr nchar(2) not null
);

create table clubtbl(
clubname nchar(5) not null primary key,
roomno nchar(4) not null
);

create sequence stdclubseq;
drop sequence stdclubseq;


create table stdclubtbl(
idnum number(5) not null primary key,
stdname nchar(5) not null,
clubname nchar(5) not null,
foreign key(stdname) references stdtbl(stdname),
foreign key(clubname) references clubtbl(clubname)
);

insert into stdtbl values('김범수','경남');
insert into stdtbl values('성시경','서울');
insert into stdtbl values('조용필','경기');
insert into stdtbl values('은지원','경북');
insert into stdtbl values('바비킴','서울');

insert into clubtbl values('수영','101호');
insert into clubtbl values('바둑','102호');
insert into clubtbl values('축구','103호');
insert into clubtbl values('봉사','104호');

insert into stdclubtbl values(stdclubseq.nextval,'김범수','바둑');
insert into stdclubtbl values(stdclubseq.nextval,'김범수','축구');
insert into stdclubtbl values(stdclubseq.nextval,'조용필','축구');
insert into stdclubtbl values(stdclubseq.nextval,'은지원','축구');
insert into stdclubtbl values(stdclubseq.nextval,'은지원','봉사');
insert into stdclubtbl values(stdclubseq.nextval,'바비킴','봉사');

commit;

--학생 테이블,동아리 테이블,학생 동아리 테이블을 이용해서 학생을 기준으로
--학생이름/지역/가입한 동아리/동아리 호실을 조회
--inner join on


--select * from stdclubtbl;
--select stdclubseq.currval from dual;

select s.stdname,s.addr,c.clubname,c.roomno
from stdtbl s
inner join stdclubtbl sc
on s.stdname=sc.stdname
inner join clubtbl c
on sc.clubname=c.clubname
order by s.stdname;


--동아리를 기준으로 가입한 학생의 목록 조회

select c.clubname,c.roomno,s.stdname,s.addr
from stdtbl s
inner join stdclubtbl sc
on sc.stdname=s.stdname
inner join clubtbl c
on sc.clubname=c.clubname
order by c.clubname;

--outer join
--usertbl,buytbl에서 구매 기록이 없는 회원의 명단 조회
select u.userid,u.username,b.prodname,u.addr,u.mobile1 || u.mobile2 as "연락처"
    from usertbl u
left join buytbl b
on u.userid=b.userid
where b.prodname is null
order by u.userid;

select s.stdname,s.addr,c.clubname,c.roomno
    from stdtbl s
left outer join stdclubtbl sc --성시경(null)출력
on s.stdname=sc.stdname
left outer join clubtbl c
on sc.clubname=c.clubname
order by s.stdname;



--동아리를 기준으로 가입된 학생을 출력하되, 가입 학생이 하나도 없는 동아리 출력
select c.clubname, c.roomno, s.stdname,s.addr
    from clubtbl c
    left outer join stdclubtbl sc on c.clubname=sc.clubname
    left join stdtbl s on s.stdname=sc.stdname
    order by c.clubname;

--기준이 무엇인가의 차이( 외부조인안의 외부조인은 전 외부조인의 결과의 외부조인)    
select c.clubname, c.roomno, s.stdname,s.addr
    from stdtbl s
    left outer join stdclubtbl sc on sc.stdname=s.stdname
    right outer join clubtbl c on sc.clubname=c.clubname
 union
select s.stdname,s.addr,c.clubname,c.roomno
    from stdtbl s
    left outer join stdclubtbl sc
    on sc.stdname=s.stdname
    right outer join clubtbl c
    on sc.clubname=c.clubname;

   
    
select username,concat(mobile1,mobile2) as "전화번호" from usertbl 
where username not in(select username from usertbl where mobile1 is null);

select username,concat(mobile1,mobile2) as "전화번호" from usertbl 
where username in(select username from usertbl where mobile1 is null);


--- inner 조인 먼저쓰고 나중에쓰고 마지막에 기준이되는 값 
select sc.clubname , /*c.roomno ,*/ s.stdname , s.addr
    from stdtbl s
    inner join stdclubtbl sc on s.stdname = sc.stdname
    right join clubtbl c on c.clubname = sc.clubname
    order by c.clubname;

select c.clubname , sc.stdname
    from clubtbl c
    left join stdclubtbl sc on c.clubname=sc.clubname
    inner join stdtbl s on sc.stdname = s.stdname;

commit;

--PL/SQL
set serverout on;
declare 
    var1 number(5);
begin
    var1:=100;
    if var1=100 then
        dbms_output.put_line('100입니다');
    else
        dbms_output.put_line('100 아닙니다');
    end if;
end;