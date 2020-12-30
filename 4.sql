--local-sqldb

select *
from buytbl
inner join usertbl on buytbl.userid=usertbl.userid
where buytbl.userid='jyp';

select buytbl.userid,username,prodname,addr,mobile1||mobile2 as "����ó"
from buytbl,usertbl
where buytbl.userid=usertbl.userid;

select b.userid,u.username,b.prodname,u.addr,u.mobile1||u.mobile2 as "����ó"
from buytbl b
inner join usertbl u
on b.userid=u.userid
where b.userid='jyp';

select b.userid,u.username,b.prodname,u.addr,u.mobile1||u.mobile2 as "����ó"
from usertbl u
inner join buytbl b
on b.userid=u.userid
where b.userid='jyp';

commit;

select b.userid,u.username,b.prodname,u.addr,u.mobile1||u.mobile2 as "����ó"
from usertbl u
inner join buytbl b
on b.userid=u.userid--������ ����� �ִ� ȸ����
order by u.userid;

select distinct u.userid,u.username,u.addr --distinct �ߺ� ����
from usertbl u
inner join buytbl b
on b.userid=u.userid--�ѹ��̶� ������ ����� �ִ� ȸ����
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

insert into stdtbl values('�����','�泲');
insert into stdtbl values('���ð�','����');
insert into stdtbl values('������','���');
insert into stdtbl values('������','���');
insert into stdtbl values('�ٺ�Ŵ','����');

insert into clubtbl values('����','101ȣ');
insert into clubtbl values('�ٵ�','102ȣ');
insert into clubtbl values('�౸','103ȣ');
insert into clubtbl values('����','104ȣ');

insert into stdclubtbl values(stdclubseq.nextval,'�����','�ٵ�');
insert into stdclubtbl values(stdclubseq.nextval,'�����','�౸');
insert into stdclubtbl values(stdclubseq.nextval,'������','�౸');
insert into stdclubtbl values(stdclubseq.nextval,'������','�౸');
insert into stdclubtbl values(stdclubseq.nextval,'������','����');
insert into stdclubtbl values(stdclubseq.nextval,'�ٺ�Ŵ','����');

commit;

--�л� ���̺�,���Ƹ� ���̺�,�л� ���Ƹ� ���̺��� �̿��ؼ� �л��� ��������
--�л��̸�/����/������ ���Ƹ�/���Ƹ� ȣ���� ��ȸ
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


--���Ƹ��� �������� ������ �л��� ��� ��ȸ

select c.clubname,c.roomno,s.stdname,s.addr
from stdtbl s
inner join stdclubtbl sc
on sc.stdname=s.stdname
inner join clubtbl c
on sc.clubname=c.clubname
order by c.clubname;

--outer join
--usertbl,buytbl���� ���� ����� ���� ȸ���� ��� ��ȸ
select u.userid,u.username,b.prodname,u.addr,u.mobile1 || u.mobile2 as "����ó"
    from usertbl u
left join buytbl b
on u.userid=b.userid
where b.prodname is null
order by u.userid;

select s.stdname,s.addr,c.clubname,c.roomno
    from stdtbl s
left outer join stdclubtbl sc --���ð�(null)���
on s.stdname=sc.stdname
left outer join clubtbl c
on sc.clubname=c.clubname
order by s.stdname;



--���Ƹ��� �������� ���Ե� �л��� ����ϵ�, ���� �л��� �ϳ��� ���� ���Ƹ� ���
select c.clubname, c.roomno, s.stdname,s.addr
    from clubtbl c
    left outer join stdclubtbl sc on c.clubname=sc.clubname
    left join stdtbl s on s.stdname=sc.stdname
    order by c.clubname;

--������ �����ΰ��� ����( �ܺ����ξ��� �ܺ������� �� �ܺ������� ����� �ܺ�����)    
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

   
    
select username,concat(mobile1,mobile2) as "��ȭ��ȣ" from usertbl 
where username not in(select username from usertbl where mobile1 is null);

select username,concat(mobile1,mobile2) as "��ȭ��ȣ" from usertbl 
where username in(select username from usertbl where mobile1 is null);


--- inner ���� �������� ���߿����� �������� �����̵Ǵ� �� 
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
        dbms_output.put_line('100�Դϴ�');
    else
        dbms_output.put_line('100 �ƴմϴ�');
    end if;
end;