--local-scott

set serverout on;
--declare
begin
    dbms_output.put_line('Hello,PL/SQL');
end;
----------------------------------------------------
declare
v_empno number(4):=7788;
v_ename varchar(10);
begin
v_ename:='scott';
/*
dbms_output.put_line('v_empno:'||v_empno); 
dbms_output.put_line('v_ename:'||v_ename);
���� �ּ�
*/
end;
----------------------------------------------------
declare
v_empno number(4):=7788;
v_ename varchar(10);
begin
v_ename:='scott';
--dbms_output.put_line('v_empno:'||v_empno); -- �� �ּ�
dbms_output.put_line('v_ename:'||v_ename);
end;
----------------------------------------------------
declare
v_tax constant number(1) := 3; -- ���� �� ���ȭ
begin
    dbms_output.put_line('v_tex:' ||v_tax);
end;
----------------------------------------------------
declare
v_deptno number(2) default 10;
begin
--dbms_output.put_line('v_deptno:',v_deptno);
dbms_output.put_line('v_deptno:'||v_deptno);
end;
----------------------------------------------------
declare
v_deptno number(2) not null:= 10; --����������Ѵ� not null
begin
dbms_output.put_line('v_deptno:'||v_deptno);
end;
----------------------------------------------------
declare
v_deptno number(2) not null default 10;  --�����ȢZ���� 10
begin
dbms_output.put_line('v_deptno:'||v_deptno);
end;
----------------------------------------------------
declare
v_deptno dept.deptno%type :=50; --������(reference type)
begin
dbms_output.put_line('v_deptno:'||v_deptno);
end;
----------------------------------------------------
declare
v_dept_row dept%rowtype; --�ϳ��� ����ü
begin
select deptno,dname,loc into v_dept_row
from dept
where deptno=40; -- deptno 40������
dbms_output.put_line('deptno:'||v_dept_row.deptno);
dbms_output.put_line('dname:'||v_dept_row.dname);
dbms_output.put_line('loc:'||v_dept_row.loc);
end;
----------------------------------------------------
declare
v_number number := 14;
begin
if 
    mod(v_number,2)=1 then -- �������� ��ȯ 
    --v_number = 4 then
    dbms_output.put_line('v_number�� Ȧ�� �Դϴ�.');
    else
    dbms_output.put_line('v_number�� ¦�� �Դϴ�.');
end if;
end;
----------------------------------------------------
declare
v_score number := 87;
begin
    if v_score>=90 then
        dbms_output.put_line('A����');
    elsif v_score>=80 then
        dbms_output.put_line('B����');
    elsif v_score>=70 then 
        dbms_output.put_line('C����');
    elsif v_score>=60 then 
        dbms_output.put_line('D����');
    else
        dbms_output.put_line('F����');
    end if;    
end;

declare
v_score number := 87;  -- number�� ũ��������൵ ����
begin
    case trunc(v_score/10)
        when 10 then dbms_output.put_line('A����');
        when 9 then dbms_output.put_line('A����');
        when 8 then dbms_output.put_line('B����');
        when 7 then dbms_output.put_line('C����');
        when 6 then dbms_output.put_line('D����');
        else
        dbms_output.put_line('F����');
    end case;
end;

declare
v_score number := 87;  -- number�� ũ��������൵ ����
begin
    case
        when v_score>=90 then dbms_output.put_line('A����');
        when v_score>=80 then dbms_output.put_line('A����');
        when v_score>=70 then dbms_output.put_line('B����');
        when v_score>=60 then dbms_output.put_line('C����');
        when v_score>=50 then dbms_output.put_line('D����');
        else
        dbms_output.put_line('F����');
    end case;
end;

--�⺻ loop (�ݺ���)
declare
v_num number := 0;
begin
    loop
        dbms_output.put_line('���� v_num:'||v_num);
        v_num:=v_num+1;
--        if v_num>4 then
--        exit;
--        end if;   --if �� ����ؼ� �����ϴ� ���
        exit when v_num>4;
    end loop;
end;

declare
v_num number := 0;
begin
    while v_num<4 loop
        dbms_output.put_line('���� v_num:'||v_num);
        v_num:=v_num+1;
    end loop;
end;

begin
    for i in 0..4 loop
      dbms_output.put_line('���� i�� ��:'||i);
    end loop;
end;

begin
    for i in reverse 0..4 loop --����
      dbms_output.put_line('���� i�� ��:'||i);
    end loop;
end;

begin --0,2,4 ���
    for i in 0..4 loop
      if mod(i,2)=0 then
      dbms_output.put_line('���� i�� ��:'||i);
      end if;
    end loop;
end;


begin --0,2,4 ���
    for i in 0..4 loop
      continue when mod(i,2)=1;  --continuue ����ϴ�
      dbms_output.put_line('���� i�� ��:'||i);
    end loop;
end;

--���ڵ�(row) �����
declare
TYPE rec_dept IS RECORD( --�ڷ����� �ٸ� ���� �����͸� �����ϴ� ���ڵ�
    deptno number(2) not null := 99,
    dname dept.dname%type,
    loc dept.loc%type
);
dept_rec rec_dept; --����Ÿ���� ��������
begin
dept_rec.deptno := 50; --50
dept_rec.dname := 'db'; --db
dept_rec.loc := 'seoul';
/* dbms_output.put_line('deptno'||dept_rec.deptno);
   dbms_output.put_line('dname'||dept_rec.dname);
   dbms_output.put_line('loc'||dept_rec.loc); */

--insert into dept_record values dept_rec;
--create table dept_record
--as select * from dept;
--select*from dept_record;

/*
update dept_record
set deptno=50 , dname='db'
where LOC = 'seoul'
*/


update dept_record
set row = dept_rec
where loc = 'seoul';
end;

select*from dept_record;
