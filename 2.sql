--local-sqldb

----create table  testrtbl(id number(4),username nchar(3),age number(2));
----insert into testrtbl values(1,'ȫ�浿',25);
----insert into testrtbl (id,username)values(2,'����');
----insert into testrtbl (username,age,id)values('����',26,3);
----select *from testrtbl;
--
--create table testtbl2(
--id number(4),
--username nchar(3),
--age number(2),
--nation nchar(4) default '���ѹα�'
--);
--
--create sequence idseq
--    start with 1
--    increment by 1;
--
--insert into testtbl2 values (idseq.nextval,'����',25,default);
--insert into testtbl2 values (idseq.nextval,'����',24,'����');
--select * from testtbl2;
--
--drop sequence idseq;
--
--insert into testtbl2 values(11,'����',18,'�븸');
--alter sequence idseq
--    increment by 10; --������ �ٽ� ���� 
--                --���� �ڵ����� 2���� �ԷµǾ����Ƿ� 10�� ���ϸ�
--                --���� ��12�� �ɱ�?
--    insert into testtbl2 values(idseq.nextval,'�̳�',21,'�Ϻ�');
--
--alter sequence idseq
--    increment by 1;  --������ �ٽ� ����  
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
    set phone='����'
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
changetype nchar(4) --�������
);

insert into changetbl values('tkv','�±Ǻ���','�ѱ�','�ű԰���');
insert into changetbl values('lsg',null,'����','�ּҺ���');
insert into changetbl values('ljb',null,'����','�ּҺ���');
insert into changetbl values('bbk',null,'Ż��','ȸ��Ż��');
insert into changetbl values('ssk',null,'Ż��','ȸ��Ż��');

select * from changetbl;
select * from membertbl;

--�ΰ������̺��� ����
merge into membertbl M  --��������̺� ����
--������ ������ �Ǵ� ���̺�
using(select changetype,userid,username,addr from changetbl) C-- ��������̺� ����
on(M.userid=C.userid) -- userid�� �������� �����̺��� ���Ѵ�.   
--target ���̺� source ���̺��� ���� ������ �ּҸ� �����Ѵ�
when matched then               --��ġ�Ҷ� t
    update set M.addr=C.addr
    --target ���̺� source ���̺��� ���� �ְ� ������ 'ȸ��Ż��'��� 
    --�ش� ���� ����
    delete where C.changetype='ȸ��Ż��'
    --target ���̺� source ���̺��� ���� ������ ���ο� ���� �߰��Ѵ�.
when not matched then           --��ġ���� ������ f
    insert(userid,username,addr) values(C.userid,C.username,C.addr);
    
select * from membertbl;
--�Լ� �ϳ��ϳ� ������Ѻ���
select ascii('A'),chr(65),asciistr('��'),unistr('\d55c')from dual;
select length('�ѱ�'),length('AB'),length('�ѱ�'),length('AB') from dual;
select replace('���� ������ �ſ� ����','����','���') from dual;
select substr('���õ� �����ͺ��̽� ���θ� �ߴ�',5,10) from dual;
select reverse('ORACLE') from dual;
select ltrim('          oracle                ') from dual;
select rtrim('$$$$oracle$$$$','$')from dual;
select trim('           oracle                ')from dual;
select regexp_count('���õ� ���õ� ���ϵ� �𷹵� ','��') from dual;


select row_number() over(order by height desc,username)"Űū����",
    userName,addr,height from usertbl;
    
select addr,row_number() over(partition by addr order by height desc,userName asc)"������ Űū����",
    userName,addr,height from usertbl;
    
select dense_rank() over(order by height desc)"Űū����",
    userName,addr,height from usertbl;
    
    commit;