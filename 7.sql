--local-sqldb

select userid,sum(price*amount) as "�ѱ��ž�"
from buytbl
group by userid
order by sum(price*amount)desc;

--����� �̸� �߰� inner join
select u.userid,u.username,sum(b.price*b.amount) as "�ѱ��ž�",
case
    when (sum(price*amount)>=1500) then '�ֿ�� ��'
    when (sum(price*amount)>=1000) then '��� ��'
    when (sum(price*amount)>=1) then '�Ϲ� ��'
    else '�� ���� ���� ��'
end as "�� ���"

from buytbl b right outer join usertbl u on b.userid = u.userid
group by u.userid , u.username
order by sum(price*amount)desc nulls last;
--------------------------------------------------------------
set serveroutput on;
declare 
 v_username usertbl.username%type;
 begin
 select username into v_username from usertbl
 where username like ('��%');
 dbms_output.put_line('�达�� �̸���'||v_username||'�Դϴ�');
 exception --����ó��
 when no_data_found then  --�����̸�
 dbms_output.put_line('�达 ���� �����ϴ�.');
 when too_many_rows then --�����̸�
 dbms_output.put_line('�达 ���� �ʹ� ���׿�.');
 end;
