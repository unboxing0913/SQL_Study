--local-scott

--desc emp;
--������ ����(data dictionary):�����ͺ��̽��� �����ϰ� ��ϴµ� 
--  �ʿ��� ��� ������ �����ϴ� Ư���� ���̺� �����ͺ��̽��� �����Ǵ�
--  ������ �ڵ����� ����� ����.
select*from dict;
select table_name
    from user_tables;
select owner,table_name
    from all_tables;
    
--�ε�����?(index)
--�����ͺ��̽����� ������ �˻� ������ ����� ���� ���̺� ���� ����ϴ� ��ü

select * from user_indexes;
select * from user_ind_columns;

create index idx_emp_sal on emp(salary);
select * from user_ind_columns;

drop index idx_emp_sal;


--�� ��?(view)
--���� ���̺��̶�� �θ���. �ϳ� �̻��� ���̺��� ��ȸ�ϴ� select����
--�����Ѱ�ü�� ���Ѵ�.
--select * from (select empno,ename,job,deptno from emp where deptno=20); 
create view vw_emp20 as (select empno,ename,job,deptno from emp where deptno=20);
select * from user_views;
select * from vw_emp20;
--��� ���� �����Ͱ� �ƴ� select���� �����ϹǷ� �並 �����ص� ���̺��̳� �����Ͱ� ���������ʴ´�.
drop view vw_emp20;



--���� ����
--���̺��� Ư�� ���� ���� 
--�α��ο� ����� ���̵� �̸��� �ּҸ� �ߺ����� �ʵ��� ����
--ȸ�� ���� �� �� �̸� ������� ���� �����ʹ� �� �� �Է� �׸����� �ξ�
--��(null)�� ������� �ʵ��� ����
--not null : ������ ���� null�� ��� ����,null�� ������ �������� �ߺ��� ���
--unique : ������ ���� ������ ���� ������ �Ѵ�.  ��, null�� ���� �ߺ����� ����
--primary key : ������ ���� ������ ���̸� null�� ������� �ʴ´�.
--                primary key�� ���̺��� �ϳ��� ���� ����
--foreign key : �ٸ� ���̺��� ���� �����Ͽ� �����ϴ� ���� �Է� �� �� �ִ�.
--check : ������ ���ǽ��� �����ϴ� �����͸� �Է� ����

--������ ���Ἲ
--�����ͺ��̽��� ����Ǵ� �������� ��Ȯ���� �ϰ����� �����Ѵٴ� �ǹ�
--��ü ���Ἲ(entity integrity) : ���̺� �����͸� �����ϰ� �ĺ� �� �� �ִ�
--      �⺻Ű�� �ݵ�� ���� ������ �־�� �ϸ� NULL�� �� �� ���� �ߺ� �� ���� ����.
--���� ���Ἲ: ���� ���̺��� �ܷ� Ű���� ���� ���̺��� �⺻ Ű�μ� �����ؾ� �ϸ� null�� ����


create table table_notnull(
    login_id varchar2(20) not null,
    login_pwd varchar2(20) not null,
    tel varchar2(20)
    );
    
  desc table_notnull;  
--  insert into table_notnull(login_id,login_pwd,tel)
--  values('test_id_01',null,'010-1234-5678'); null�� �Է��ؼ� ����
  
  insert into table_notnull(login_id,login_pwd)
  values('test_id_01','1234');
  
  select * from table_notnull;
  
--  update table_notnull  
--    set login_pwd=null -- update �� null��� �Ұ�
--    where login_id='test_id_01';


--user_constraints ������ ���� (dictionary)
--owner : ���� ���� ���� ����
--constraint_name : ���� ���� �̸�(���� �������� ���� ��� ����Ŭ�� �ڵ����� ����)
--constraint_type: C:check,not null
--                 U:unique
--                 P:primary key
--                 R:foreign key
--table_name : ���� ������ ������ ���̺� �̸�
select owner,constraint_name,constraint_type,table_name from user_constraints;

--���̺��� ����鼭 �������� �߰�
create table table_notnull2(
    login_id varchar2(20) constraint tblnn2_lgnid_nn not null,
    login_pw varchar2(20) constraint tblnn2_lgnpw_nn not null,
    tel varchar2(20)
    );
    
select owner,constraint_name,constraint_type,table_name
from user_constraints;

select*from table_notnull;

--���̺� �������� �������� �߰�
update table_notnull
    set tel='010-1234-5678'
    where login_id='test_id_01';
    
alter table table_notnull
modify(tel not null);--����    
    
select * from table_notnull;

select owner,constraint_name,constraint_type,table_name from user_constraints;

--������ ���̺� ���� ���� �̸� ���� �����ؼ� �߰�
select * from table_notnull2;

alter table table_notnull2
modify(tel constraint tblnn_tel not null);

desc table_notnull2;

--�������� �̸� ����
alter table table_notnull2
rename constraint tblnn_tel to tblnn2_tel_nn;

--�������� ����
alter table table_notnull2
drop constraint tblnn2_tel_nn;

--unique
create table table_unique(
    login_id varchar(20) unique,
    login_pwd varchar(20) not null,
    tel varchar2(20)
    );

desc table_unique;

select owner,constraint_name,constraint_type,table_name
    from user_constraints
    where table_name='TABLE_UNIQUE';    
    
insert into table_unique(login_id,login_pwd,tel)
values('test_id_01','pwd01','010-1234-5678');

select * from table_unique;

insert into table_unique(login_id,login_pwd,tel)
values('test_id_02','pwd01','010-1234-5678');

--unique ���� ������ �� ���� �ߺ��� �ȵ����� null ������ ����
insert into table_unique(login_id,login_pwd,tel)
values(null,'pwd01','010-2345-6789');

select*from table_unique;
--�ߺ� ���̵� �߰�(error)
update table_unique
    set login_id='test_id_01'
    where login_id is null;
    
select*from table_unique;

create table table_unique2(
    login_id varchar(20) constraint tblunq2_lgnid_ung unique,
    login_pwd varchar(20) constraint tblunq2_nn not null,
    tel varchar(20)
    );
--������ unique ���� ���� Ȯ���ϱ� (user_constraints ���)    
select owner,constraint_name,constraint_type,table_name
    from user_constraints
    where TABLE_NAME like 'TABLE_UNIQUE%';
  --where table_name like 'table_unique%'; �ڵ����� �빮�ڷ� ���ϱ⶧���� 
  
select*from table_unique;

alter table table_unique
modify(tel unique);

update table_unique
    set tel=null;
    
select * from table_unique;

alter table table_unique2
modify(tel constraint tblnuq_tel_unq unique);

select owner,constraint_name,constraint_type,table_name
    from user_constraints
    where TABLE_NAME like 'TABLE_UNIQUE%';

alter table table_unique2
    rename constraint tblnuq_tel_unq to tblunq2_tel_unq;

alter table table_unique2
drop constraint tblunq2_tel_unq;

select owner,constraint_name,constraint_type,table_name
    from user_constraints
    where TABLE_NAME like 'TABLE_UNIQUE%';
    
    
--primary key(unique+not null)
create table table_pk(
    login_id varchar(20) primary key,
    login_pwd varchar2(20) not null,
    tel varchar2(20)
    );
    
desc table_pk;

select owner,constraint_name,constraint_type,table_name
    from user_constraints
    where table_name like 'TABLE_PK%';
    
select index_name,table_owner,table_name
    from user_indexes   --�ڵ� ������ index
where table_name like 'TABLE_PK%';

create table table_pk2(
    login_id varchar(20)constraint tblpk_lgnid_pk primary key,
    login_pwd varchar2(20)constraint tblpk2_lgnpw_nn not null,
    tel varchar2(20)
    );
   
select owner,constraint_name,constraint_type,table_name
    from user_constraints
    where table_name like 'TABLE_PK%';    
    
insert into table_pk(login_id,login_pwd,tel)
    values('test_id_01','pwd01','010-1234-5678');
    
select * from table_pk;

insert into table_pk(login_id,login_pwd,tel)
    values('test_id_01','pwd02','010-2345-6789');
    
insert into table_pk(login_id,login_pwd,tel)
    values(null,'pwd02','010-2345-6789');    
    
insert into table_pk(login_id,login_pwd,tel)
    values('pwd02','010-2345-6789');  
    
--create table table_name(
--    col1 varchar2(20) constraint constraint_name primary key,
--    col2 varchar2(20) not null,
--    col3 varchar2(20)
-- );

--create table table_name(
--    col1 varchar2(20) 
--    col2 varchar2(20) 
--    col3 varchar2(20)
--    primary key(col1),
--    constraint constraint_name unique(col2)
-- );



--foreign key(�ܷ�Ű)
select owner,constraint_name,constraint_type,table_name,r_owner,r_constraint_name
    from user_constraints
    where table_name in ('EMP','DEPT');
    
insert into emp(empno,ename,job,mgr,hiredate,sal,comm,deptno)
values(9999,'ȫ�浿','clerk','7788',to_date('2020/12/01','YYY/MM/DD'),1200,null,50);
--���� ��� ���̺��� �θ�,�����ϴ� ���̺��� �ڽ����κ����

create table dept_fk(   
    deptno number(2) constraint deptfk_deptno_pk primary key,
    dname varchar2(14),
    loc varchar2(13)
    );

desc dept_fk;


    
create table emp_fk(
 empno number(4) constraint emp_fk_emp_no_pk primary key,
 ename varchar(10),
 job varchar(9),
 mgr number(4),
 hiredate date,
 sal number(7,2),
 comm number(7,2),
 deptno number(2) constraint emp_fk_empno_fk references dept_fk(deptno)
 );
 
    
desc emp_fk;

--deptno �����Ͱ� ���� dept_fk���̺� ���� �� 
 insert into emp_fk
 values(9999,'test_name','test_job',null,to_date('2020/12/01','YYYY/MM/DD'),3000,null,10);

insert into dept_fk
values(10,'test_dname','test_loc');

select * from dept_fk;

select * from emp_fk;

delete from dept_fk
where deptno=10;

--���� �����Ϸ��� �� ���� �����ϴ� �����͸� ���� �����Ѵ�.
delete from emp_fk
where deptno=10;

drop table emp_fk;

create table emp_fk(
 empno number(4) constraint emp_fk_emp_no_pk primary key,
 ename varchar(10),
 job varchar(9),
 mgr number(4),
 hiredate date,
 sal number(7,2),
 comm number(7,2),
 deptno number(2) constraint emp_fk_empno_fk references dept_fk(deptno) on delete cascade
 );
 
 delete from dept_fk
 where deptno=10;
 
 
 --check : ���� ����
create table table_check(
    login_id varchar2(20) constraint tblck_loginid_pk primary key,
    login_pwd varchar2(20) constraint tblck_loginpw_ck check(length(login_pwd)>3),
    tel varchar2(20)
    );

desc table_check;

--insert into table_check
--values('test_id','123','010-1234-5678');
--3���� �̻�
insert into table_check
values('test_id','1234','010-1234-5678');

select * from table_check;

--check ���� ���� Ȯ��
select owner,constraint_name,constraint_type,table_name
    from user_constraints
where table_name like 'TABLE_CHECK';
--not null,check ���������� C �� ���

--default ���� �������� �ʾ��� ���
create table table_default(
    login_id varchar2(20) constraint tblck2_loginid_pk primary key,
    login_pw varchar2(20) default '1234',
    tel varchar2(20)
    );

desc table_default;

insert into table_default values('test_id',null,'010-1234-5678');
insert into table_default (login_id,tel) values ('test_id2','010-1234-5678');

select * from table_default;

--------------------------------------------------------------------------
--dept_const ���̺�� emp_const ���̺��� ������ ���� Ư�� �� ���� ������ �����Ͽ� �ۼ��ϼ���.
--1)dept_const ���̺� 
--���̸�    �ڷ���         ����    ��������         �������� �̸�
--deptno   ������ ����     2      primary key    deptconst_deptno_pk
--dname    ������ ���ڿ�   14      unique        deptconst_dname_unq
--loc      ������ ���ڿ�   13      not null      deptconst_log_nn

create table dept_const(
    deptno number(2) constraint deptconst_deptno_pk primary key,
    dname  varchar2(14) constraint deptconst_dname_unq unique,
    loc varchar2(13) constraint deptconst_log_nn not null
);

select owner,constraint_name,constraint_type,table_name
    from user_constraints
    where table_name like 'DEPT_CONST%';
    
alter table dept_const
rename constraint deptconst_log_nn to deptconst_loc_nn;

--2)emp_const ���̺� 
--���̸�    �ڷ���            ����    ��������         �������� �̸�
--empno    ������ ����        4      primary key    empconst_empno_pk
--ename    ������ ���ڿ�      10      not null      empconst_ename_nn
--job      ������ ���ڿ�      9      
--tel      ������ ���ڿ�      20      unique        empconst_tel_unq
--hiredate ��¥
--sal      �Ҽ�����°�ڸ�����   7    check:�޿��� 1000~9999�� �Է°��� empconst_sal_chk
--comm     �Ҽ�����°�ڸ�����   7    
--deptno   ������ ����        2     foreign key empconst_depno_fk

create table emp_const(
    empno number(4) constraint empconst_empno_pk primary key,
    ename varchar2(10) constraint empconst_enam_nn not null,
    job varchar2(9),
    tel varchar2(20) constraint empconst_tel_unq unique,
    hiredate date,
    sal number(7,2) constraint empconst_sal_chk check(sal between 1000 and 9999), 
    comm number(7,2),
    deptno number(2) constraint empconst_depno_fk references dept_const(deptno)
);

select table_name,constraint_name,constraint_type
    from user_constraints
    where table_name in ('EMP_CONST','DEPT_CONST')
    order by constraint_name;
    
--join �� �� �̻��� ���̺��� �����Ͽ� �ϳ��� ���̺�ó�� ����ϴ� ���
select * from emp
order by empno;

select * from emp,dept
order by empno;


select * from dept;

select * 
    from emp,dept
where emp.deptno=dept.deptno
order by empno;
    
select *
    from emp e, dept d --���̺� ��Ī ����
    where e.deptno=d.deptno
    order by empno;
    
select e.empno,e.ename,d.deptno,d.dname,d.loc
    from emp e,dept d
    where e.deptno=d.deptno; --�����̺� �μ� ��ȣ�� �Ȱ��� �� �̸����� ����
    
select e.empno,e.ename,d.deptno,d.dname,d.loc,e.sal
    from emp e,dept d
    where e.deptno=d.deptno and sal>=3000;
    
--�޿��� 2500�����̰� ��� ��ȣ�� 9999������ ����� ������ ���    

select e.empno,e.ename,d.deptno,d.dname,d.loc,e.sal
    from emp e,dept d
    where e.deptno=d.deptno and (e.sal<=2500 and e.empno<=9999)
    order by empno;
    
select * 
    from emp e,salgrade s
    where e.sal between s.losal and s.hisal;

--�������̺��� ����
--1    
create view mgrco as select * from emp; --�������̺�
select e.empno,e.ename,m.empno,m.ename from emp e , mgrco m where e.empno = m.mgr; 
  
--2
create table copy_emp
    as select*from emp; --���̺�ī��   
select * from emp e , copy_emp c where e.empno = c.mgr;

--3
select a.empno,a.ename,b.mgr,b.ename
    from emp a join emp b on a.empno=b.mgr; --����

--4
select e1.empno,e1.ename,e1.mgr,
       e2.empno as mgr_empno ,
       e2.ename as mgr_ename 
    from emp e1,emp e2 --����
    where e1.mgr=e2.empno;
--�ܺ� ���� : �� ���̺� �� ���� ���࿡�� ���� ���� ���� ��� ������
--          null�̾ ������ ����ϴ� ���

--���� �ܺ� ���� : where table1.col1=table2.col2(+)
--������ �ܺ����� : where table1.col1(+)=table2.col2

select e1.empno,e1.ename,e1.mgr,
       e2.empno as mgr_empno,
       e2.ename as mgr_ename
   from emp e1,emp e2   
   where e1.mgr=e2.empno(+)
   order by e1.empno;
   
select e1.empno,e1.ename,e1.mgr,
       e2.empno as mgr_empno,
       e2.ename as mgr_ename
   from emp e1,emp e2   
   where e1.mgr(+)=e2.empno
   order by e1.empno;   
   
 ----------------------------------------------------
 --SQL-99(ǥ�� ����)  Join
 select e.empno,e.ename,e.job,e.hiredate,e.sal,e.comm, --natural join ���
    deptno,d.dname,d.loc --deptno �ָ�
    from emp e natural join dept d --�̸��� �ڷ����� ���� ���� ã�� �� �� ���� �������� ����
    order by deptno,e.empno;
   
   
select e.empno,e.ename,e.job,e.hiredate,e.sal,e.comm, --join using ���
    deptno,d.dname,d.loc --deptno �ָ�
    from emp e join dept d using(deptno) --(���ο� ����� ���� ��)
    where sal>=3000
    order by deptno,e.empno;
   
select e.empno,e.ename,e.job,e.hiredate,e.sal,e.comm, --join on ���
    e.deptno, --�������̺�� ������� (����)
    d.dname,
    d.loc --deptno �ָ�
    from emp e join dept d on(e.deptno=d.deptno)--������ from���� ��
    where sal<=3000
    order by e.deptno,empno;   
   
      
select e1.empno,e1.ename,e1.mgr, --���� �ܺ�����
       e2.empno as mgr_empno,
       e2.empno as mgr_ename
       from emp e1 left outer join emp e2 on(e1.mgr=e2.empno)
       order by e1.empno;

select e1.empno,e1.ename,e1.mgr, --������ �ܺ�����
       e2.empno as mgr_empno,
       e2.empno as mgr_ename
       from emp e1 right outer join emp e2 on(e1.mgr=e2.empno)
       order by e1.empno;       
       
select e1.empno,e1.ename,e1.mgr, --���� �ܺ�����
       e2.empno as mgr_empno,
       e2.empno as mgr_ename
       from emp e1 full outer join emp e2 on(e1.mgr=e2.empno)
       order by e1.empno;              
   
--�޿�(sal)�� 2000�ʰ��� ������� �μ�����,��������� ��ȸ �ϼ���
--�� SQL-99���� ��İ� SQL-99����� ���� ���

--SQL-99����
select d.dname,e.empno,e.ename,e.sal,d.deptno
       from emp e,dept d
       where e.deptno=d.deptno and sal>2000   
       order by e.sal;     
       
       
--SQL-99
select d.dname,e.empno,e.ename,e.sal,deptno
       from emp e natural join dept d
       where sal>2000 
       order by e.sal;     



--�� �μ��� ��� �޿�,�ִ� �޿�, �ּ� �޿�,��� ���� ��ȸ�ϼ���
--�� SQL-99���� ��İ� SQL-99����� ���� ����Ͽ� �ۼ��ϼ���
--join using

--SQL-99
select d.deptno,d.dname,
    trunc(avg(e.sal))as avg_sal,
    max(e.sal) as max_sal,
    min(e.sal) as min_sal,
    count(*) as cnt
    from emp e , dept d 
    where e.deptno = d.deptno
    group by d.deptno,d.dname;
    
      
--SQL-99 �������  
select deptno,d.dname,
    trunc(avg(e.sal))as avg_sal,
    max(e.sal) as max_sal,
    min(e.sal) as min_sal,
    count(*) as cnt
    from emp e join dept d using(deptno)
    group by deptno,d.dname;    

    
    
    
--��� �μ� ������ ��������� �μ���ȣ, ����̸� ������ ���� �ϼ���
--�� SQL-99���� ��İ� SQL-99����� ���� ����Ͽ� �ۼ��ϼ���
--right outer join
--deptno,dname,empno,ename,job,sal

--SQL-99
select d.deptno,d.dname,e.empno,e.ename,e.job,e.sal    
    from emp e right outer join dept d on(e.deptno=d.deptno)
    order by d.deptno,e.ename;
--SQL-99 �������
select d.deptno,d.dname,e.empno,e.ename,e.job,e.sal
    from emp e , dept d
    where e.deptno(+)=d.deptno
    order by d.deptno,e.ename;
    
    
    
--��� �μ�����,��� ����,�޿� ��� ����,�� ����� ���� ����� ������ �μ� ��ȣ 
--��� ��ȣ ������ �����Ͽ� ��ȸ�ϼ���
--�� SQL-99���� ��İ� SQL-99����� ���� ����Ͽ� �ۼ��ϼ���
--right outer join,left outer join
--deptno,dname,empno,ename,mgr,sal,deptno,losal,hisal,grade
--mgr_empno,mgr_ename
--�� �� �̻��� ���̺��� ������ ��
--from table1,table2,table3
--where table1.col=table2.col
--and table2.col=table3.col

--from table1 join table 2 on(���ǽ�)
--join table3 on(���ǽ�)

--SQL-99        
select d.deptno,d.dname,
    e.empno,e.ename,e.mgr,e.sal,e.deptno,
    s.losal,s.hisal,s.grade,
    e2.empno as mgr_emp, e2.ename as mgr_ename
    from emp e right outer join dept d on(e.deptno=d.deptno)
    left outer join salgrade s on(e.sal between s.losal and s.hisal)
    left outer join emp e2 on(e.mgr=e2.empno)
    order by d.deptno,e.empno;

--SQL-99 �������
select d.deptno,d.dname,
    e.empno,e.ename,e.mgr,e.sal,e.deptno,
    s.losal,s.hisal,s.grade,
    e2.empno as mgr_emp, e2.ename as mgr_ename
    from emp e, dept d,salgrade s,emp e2
    where e.deptno(+)=d.deptno
        and e.sal between s.losal(+) and s.hisal(+)
        and e.mgr=e2.empno(+)
        order by d.deptno,e.empno;

commit;