--local-scott

--desc emp;
--데이터 사전(data dictionary):데이터베이스를 구성하고 운영하는데 
--  필요한 모든 정보를 저장하는 특수한 테이블 데이터베이스가 생성되는
--  시점에 자동으로 만들어 진다.
select*from dict;
select table_name
    from user_tables;
select owner,table_name
    from all_tables;
    
--인덱스란?(index)
--데이터베이스에서 데이터 검색 성능의 향상을 위해 테이블 열에 사용하는 객체

select * from user_indexes;
select * from user_ind_columns;

create index idx_emp_sal on emp(salary);
select * from user_ind_columns;

drop index idx_emp_sal;


--뷰 란?(view)
--가상 테이블이라고도 부른다. 하나 이상의 테이블을 조회하는 select문을
--저장한객체를 말한다.
--select * from (select empno,ename,job,deptno from emp where deptno=20); 
create view vw_emp20 as (select empno,ename,job,deptno from emp where deptno=20);
select * from user_views;
select * from vw_emp20;
--뷰는 실제 데이터가 아닌 select문만 저장하므로 뷰를 삭제해도 테이블이나 데이터가 삭제되지않는다.
drop view vw_emp20;



--제약 조건
--테이블의 특정 열에 지정 
--로그인에 사용할 아이디나 이메일 주소를 중복되지 않도록 설정
--회원 가입 할 때 이름 생년월일 등의 데이터는 필 수 입력 항목으로 두어
--빈값(null)을 허용하지 않도록 지정
--not null : 지정한 열에 null을 허용 안함,null을 제외한 데이터의 중복은 허용
--unique : 지정한 열이 유일한 값을 가져야 한다.  단, null은 값의 중복에서 제외
--primary key : 지정한 열이 유일한 값이며 null을 허용하지 않는다.
--                primary key는 테이블에서 하나만 지정 가능
--foreign key : 다른 테이블의 열을 참조하여 존재하는 값만 입력 할 수 있다.
--check : 설정한 조건식을 만족하는 데이터만 입력 가능

--데이터 무결성
--데이터베이스에 저장되는 데이터의 정확성과 일관성을 보장한다는 의미
--개체 무결성(entity integrity) : 테이블 데이터를 유일하게 식별 할 수 있는
--      기본키는 반드시 값을 가지고 있어야 하며 NULL이 될 수 없고 중복 될 수도 없다.
--참조 무결성: 참조 테이블의 외래 키값은 참조 테이블의 기본 키로서 존재해야 하며 null이 가능


create table table_notnull(
    login_id varchar2(20) not null,
    login_pwd varchar2(20) not null,
    tel varchar2(20)
    );
    
  desc table_notnull;  
--  insert into table_notnull(login_id,login_pwd,tel)
--  values('test_id_01',null,'010-1234-5678'); null값 입력해서 오류
  
  insert into table_notnull(login_id,login_pwd)
  values('test_id_01','1234');
  
  select * from table_notnull;
  
--  update table_notnull  
--    set login_pwd=null -- update 시 null사용 불가
--    where login_id='test_id_01';


--user_constraints 데이터 사전 (dictionary)
--owner : 제약 조건 소유 계정
--constraint_name : 제약 조건 이름(직접 지정하지 않을 경우 오라클이 자동으로 지정)
--constraint_type: C:check,not null
--                 U:unique
--                 P:primary key
--                 R:foreign key
--table_name : 제약 조건은 지정한 테이블 이름
select owner,constraint_name,constraint_type,table_name from user_constraints;

--테이블을 만들면서 제약조건 추가
create table table_notnull2(
    login_id varchar2(20) constraint tblnn2_lgnid_nn not null,
    login_pw varchar2(20) constraint tblnn2_lgnpw_nn not null,
    tel varchar2(20)
    );
    
select owner,constraint_name,constraint_type,table_name
from user_constraints;

select*from table_notnull;

--테이블 수정으로 제약조건 추가
update table_notnull
    set tel='010-1234-5678'
    where login_id='test_id_01';
    
alter table table_notnull
modify(tel not null);--수정    
    
select * from table_notnull;

select owner,constraint_name,constraint_type,table_name from user_constraints;

--생성한 테이블에 제약 조건 이름 직접 지정해서 추가
select * from table_notnull2;

alter table table_notnull2
modify(tel constraint tblnn_tel not null);

desc table_notnull2;

--제약조건 이름 수정
alter table table_notnull2
rename constraint tblnn_tel to tblnn2_tel_nn;

--제약조건 삭제
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

--unique 제약 조건은 열 값의 중복은 안되지만 null 저장은 가능
insert into table_unique(login_id,login_pwd,tel)
values(null,'pwd01','010-2345-6789');

select*from table_unique;
--중복 아이디 추가(error)
update table_unique
    set login_id='test_id_01'
    where login_id is null;
    
select*from table_unique;

create table table_unique2(
    login_id varchar(20) constraint tblunq2_lgnid_ung unique,
    login_pwd varchar(20) constraint tblunq2_nn not null,
    tel varchar(20)
    );
--생성한 unique 제약 조건 확인하기 (user_constraints 사용)    
select owner,constraint_name,constraint_type,table_name
    from user_constraints
    where TABLE_NAME like 'TABLE_UNIQUE%';
  --where table_name like 'table_unique%'; 자동으로 대문자로 변하기때문에 
  
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
    from user_indexes   --자동 생성된 index
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



--foreign key(외래키)
select owner,constraint_name,constraint_type,table_name,r_owner,r_constraint_name
    from user_constraints
    where table_name in ('EMP','DEPT');
    
insert into emp(empno,ename,job,mgr,hiredate,sal,comm,deptno)
values(9999,'홍길동','clerk','7788',to_date('2020/12/01','YYY/MM/DD'),1200,null,50);
--참조 대상 테이블을 부모,참조하는 테이블을 자식으로보면됨

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

--deptno 데이터가 아직 dept_fk테이블에 없을 때 
 insert into emp_fk
 values(9999,'test_name','test_job',null,to_date('2020/12/01','YYYY/MM/DD'),3000,null,10);

insert into dept_fk
values(10,'test_dname','test_loc');

select * from dept_fk;

select * from emp_fk;

delete from dept_fk
where deptno=10;

--현재 삭제하려는 열 값을 참조하는 데이터를 먼저 삭제한다.
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
 
 
 --check : 범위 지정
create table table_check(
    login_id varchar2(20) constraint tblck_loginid_pk primary key,
    login_pwd varchar2(20) constraint tblck_loginpw_ck check(length(login_pwd)>3),
    tel varchar2(20)
    );

desc table_check;

--insert into table_check
--values('test_id','123','010-1234-5678');
--3글자 이상
insert into table_check
values('test_id','1234','010-1234-5678');

select * from table_check;

--check 제약 조건 확인
select owner,constraint_name,constraint_type,table_name
    from user_constraints
where table_name like 'TABLE_CHECK';
--not null,check 제약조건은 C 로 출력

--default 값이 지정되지 않았을 경우
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
--dept_const 테이블과 emp_const 테이블을 다음과 같은 특성 및 제약 조건을 지정하여 작성하세요.
--1)dept_const 테이블 
--열이름    자료형         길이    제약조건         제약조건 이름
--deptno   정수형 숫자     2      primary key    deptconst_deptno_pk
--dname    가변형 문자열   14      unique        deptconst_dname_unq
--loc      가변형 문자열   13      not null      deptconst_log_nn

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

--2)emp_const 테이블 
--열이름    자료형            길이    제약조건         제약조건 이름
--empno    정수형 숫자        4      primary key    empconst_empno_pk
--ename    가변형 문자열      10      not null      empconst_ename_nn
--job      가변형 문자열      9      
--tel      가변형 문자열      20      unique        empconst_tel_unq
--hiredate 날짜
--sal      소수점둘째자리숫자   7    check:급여는 1000~9999만 입력가능 empconst_sal_chk
--comm     소수점둘째자리숫자   7    
--deptno   정수형 숫자        2     foreign key empconst_depno_fk

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
    
--join 두 개 이상의 테이블을 연결하여 하나의 테이블처럼 사용하는 방식
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
    from emp e, dept d --테이블 별칭 설정
    where e.deptno=d.deptno
    order by empno;
    
select e.empno,e.ename,d.deptno,d.dname,d.loc
    from emp e,dept d
    where e.deptno=d.deptno; --두테이블에 부서 번호가 똑같은 열 이름으로 포함
    
select e.empno,e.ename,d.deptno,d.dname,d.loc,e.sal
    from emp e,dept d
    where e.deptno=d.deptno and sal>=3000;
    
--급여가 2500이하이고 사원 번호가 9999이하인 사원의 정보를 출력    

select e.empno,e.ename,d.deptno,d.dname,d.loc,e.sal
    from emp e,dept d
    where e.deptno=d.deptno and (e.sal<=2500 and e.empno<=9999)
    order by empno;
    
select * 
    from emp e,salgrade s
    where e.sal between s.losal and s.hisal;

--같은테이블에서 조인
--1    
create view mgrco as select * from emp; --가상테이블
select e.empno,e.ename,m.empno,m.ename from emp e , mgrco m where e.empno = m.mgr; 
  
--2
create table copy_emp
    as select*from emp; --테이블카피   
select * from emp e , copy_emp c where e.empno = c.mgr;

--3
select a.empno,a.ename,b.mgr,b.ename
    from emp a join emp b on a.empno=b.mgr; --조인

--4
select e1.empno,e1.ename,e1.mgr,
       e2.empno as mgr_empno ,
       e2.ename as mgr_ename 
    from emp e1,emp e2 --조인
    where e1.mgr=e2.empno;
--외부 조인 : 두 테이블 간 조인 수행에서 조인 기준 열의 어느 한쪽이
--          null이어도 강제로 출력하는 방식

--왼쪽 외부 조인 : where table1.col1=table2.col2(+)
--오른쪽 외부조인 : where table1.col1(+)=table2.col2

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
 --SQL-99(표준 문법)  Join
 select e.empno,e.ename,e.job,e.hiredate,e.sal,e.comm, --natural join 방식
    deptno,d.dname,d.loc --deptno 주목
    from emp e natural join dept d --이름과 자료형이 같은 열을 찾은 후 그 열을 기준으로 조인
    order by deptno,e.empno;
   
   
select e.empno,e.ename,e.job,e.hiredate,e.sal,e.comm, --join using 방식
    deptno,d.dname,d.loc --deptno 주목
    from emp e join dept d using(deptno) --(조인에 사용할 기준 열)
    where sal>=3000
    order by deptno,e.empno;
   
select e.empno,e.ename,e.job,e.hiredate,e.sal,e.comm, --join on 방식
    e.deptno, --실제테이블명 써줘야함 (주의)
    d.dname,
    d.loc --deptno 주목
    from emp e join dept d on(e.deptno=d.deptno)--조건이 from절에 들어감
    where sal<=3000
    order by e.deptno,empno;   
   
      
select e1.empno,e1.ename,e1.mgr, --왼쪽 외부조인
       e2.empno as mgr_empno,
       e2.empno as mgr_ename
       from emp e1 left outer join emp e2 on(e1.mgr=e2.empno)
       order by e1.empno;

select e1.empno,e1.ename,e1.mgr, --오른쪽 외부조인
       e2.empno as mgr_empno,
       e2.empno as mgr_ename
       from emp e1 right outer join emp e2 on(e1.mgr=e2.empno)
       order by e1.empno;       
       
select e1.empno,e1.ename,e1.mgr, --양쪽 외부조인
       e2.empno as mgr_empno,
       e2.empno as mgr_ename
       from emp e1 full outer join emp e2 on(e1.mgr=e2.empno)
       order by e1.empno;              
   
--급여(sal)가 2000초과인 사원들의 부서정보,사원정보를 조회 하세요
--단 SQL-99이전 방식과 SQL-99방식을 각각 사용

--SQL-99이전
select d.dname,e.empno,e.ename,e.sal,d.deptno
       from emp e,dept d
       where e.deptno=d.deptno and sal>2000   
       order by e.sal;     
       
       
--SQL-99
select d.dname,e.empno,e.ename,e.sal,deptno
       from emp e natural join dept d
       where sal>2000 
       order by e.sal;     



--각 부서별 평균 급여,최대 급여, 최소 급여,사원 수를 조회하세요
--단 SQL-99이전 방식과 SQL-99방식을 각각 사용하여 작성하세요
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
    
      
--SQL-99 이전방식  
select deptno,d.dname,
    trunc(avg(e.sal))as avg_sal,
    max(e.sal) as max_sal,
    min(e.sal) as min_sal,
    count(*) as cnt
    from emp e join dept d using(deptno)
    group by deptno,d.dname;    

    
    
    
--모든 부서 정보와 사원정보를 부서번호, 사원이름 순으로 정렬 하세요
--단 SQL-99이전 방식과 SQL-99방식을 각각 사용하여 작성하세요
--right outer join
--deptno,dname,empno,ename,job,sal

--SQL-99
select d.deptno,d.dname,e.empno,e.ename,e.job,e.sal    
    from emp e right outer join dept d on(e.deptno=d.deptno)
    order by d.deptno,e.ename;
--SQL-99 이전방식
select d.deptno,d.dname,e.empno,e.ename,e.job,e.sal
    from emp e , dept d
    where e.deptno(+)=d.deptno
    order by d.deptno,e.ename;
    
    
    
--모든 부서정보,사원 정보,급여 등급 정보,각 사원의 직속 상관의 정보를 부서 번호 
--사원 번호 순서로 정렬하여 조회하세요
--단 SQL-99이전 방식과 SQL-99방식을 각각 사용하여 작성하세요
--right outer join,left outer join
--deptno,dname,empno,ename,mgr,sal,deptno,losal,hisal,grade
--mgr_empno,mgr_ename
--세 개 이상의 테이블을 조인할 때
--from table1,table2,table3
--where table1.col=table2.col
--and table2.col=table3.col

--from table1 join table 2 on(조건식)
--join table3 on(조건식)

--SQL-99        
select d.deptno,d.dname,
    e.empno,e.ename,e.mgr,e.sal,e.deptno,
    s.losal,s.hisal,s.grade,
    e2.empno as mgr_emp, e2.ename as mgr_ename
    from emp e right outer join dept d on(e.deptno=d.deptno)
    left outer join salgrade s on(e.sal between s.losal and s.hisal)
    left outer join emp e2 on(e.mgr=e2.empno)
    order by d.deptno,e.empno;

--SQL-99 이전방식
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