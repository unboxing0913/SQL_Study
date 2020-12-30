--local-sqldb


--1970�� ���Ŀ� ����ϰ� ������ 180�� ����� ���̵�� �̸��� ��ȸ
select userid,username from usertbl where birthyear >= 1970 and height >= 180;
--1970�� ���Ŀ� ����߰ų� ������ 180�� ����� ���̵�� �̸��� ��ȸ
select userid,username from usertbl where birthyear >= 1970 or height >= 180;
--Ű�� 180~183�� ��� ��ȸ
select username,height from usertbl where height >=180 and height <= 183;

--between and
select username,height from usertbl where height between 180 and 183;

--������ '�泲','����','���' �� ����� �̸��� ���� ��ȸ 
select username,addr from usertbl where addr='�泲' or addr='����' or addr='���';

--in( )�Լ�
select username,addr from usertbl where addr in ('�泲','����','���');

--like ������, % �����̵����, _:�ѱ��ڿ� ��ġ
select username,height from usertbl where username like '��%';
select username,height from usertbl where username like '_����';
--'������','������ ���','�̿��� �ּż� �����մϴ�'
select username,height from usertbl where username like '_��%';

--subquery:��������
select username,height from usertbl where height >177;
select username,height from usertbl
    where height > (select height from usertbl where username='���ȣ');
--������ '�泲'����� Ű���� ũ�ų� ���� ��� ��ȸ (170,173)

--any�� ���������� ���� ���� ��� �� �Ѱ����� �����ص� �ȴ�.
select username, height from usertbl  
    where height >= any(select height from usertbl where addr='�泲');

--all�� ���������� ���� ���� ����� ��� �����ؾ� �ȴ�.    
select username, height from usertbl  
    where height >= all(select height from usertbl where addr='�泲');

select username, height from usertbl
    where height in(select height from usertbl where addr='�泲');
    
--order by (default:ascending)
select username,mdate from usertbl order by mdate;
select username,mdate from usertbl order by mdate asc; --��������(�⺻��)
select username,mdate from usertbl order by mdate desc; --��������
--Ű�� ū ������ �����ϵ� ���� Ű�� ���� ��쿡 �̸� ������ ����
select username,height from usertbl order by height desc,username asc; --asc�� �⺻���̱⶧���� �Ⱥٿ�����

--�ߺ� ����
select addr from usertbl;
select addr from usertbl order by addr;
select distinct addr from usertbl;

--group by
select userid,amount from buytbl order by userid;
select userid as "����� ���̵�",sum(amount)as "�� ���� ����" from buytbl group by userid;
select userid "����� ���̵�" from buytbl group by userid;  --as�� �������� 
--���� ���̵𺰷� ������ ���ž��� ����
select userid as ����ھ��̵� , sum(price*amount) as �ѱ��ž�
    from buytbl group by userid;

--avg() �Լ� ��հ� ���ϱ�
select avg(amount) as "��� ���� ����" from buytbl;
--cast(���� as ��ȯ�� ����) �Լ� �Ҽ��� ����
select cast(avg(amount)as number(5,3)) as "��� ���� ����" from buytbl;
--�� ����� ����(id)�� �� ���� �� ������ ��������� � �����ߴ��� ��� ��ȸ
select userid, cast(avg(amount)as number(1,0)) as "��� ���� ����" from buytbl group by userid;

--���� ū Ű�� ���� ���� Ű�� ȸ�� �̸��� Ű�� ��ȸ
select username, max(height),min(height) from usertbl group by username; --�׷�ȭ�ϸ� �������� �ּҰ� �ִ밪 �˻�
--group by ��� ���� �غ�,�������� �̿�
select username,height from usertbl where height in((select max(height) from usertbl),(select min(height) from usertbl));
select username,height from usertbl where height=(select max(height)from usertbl) or height=(select min(height)from usertbl);

--count()�Լ�:���� ������ ����.
select count(*) from usertbl;
--�޴����� �ִ� ����� �� ��ȸ.
select count(mobile1)as "�޴����� �ִ� �����" from usertbl;

--having
--�� ���ž��� 1000�̻��� �����.
select userid as "�����",sum(price*amount)as "�� ���ž�"
    from buytbl
    --where sum(price*amount)>1000;
    group by userid
    having sum(price*amount)>1000 --having�� ��ġ�߿�
    order by sum(price*amount); 

--rollup()
select /*idnum,*/groupname,sum(price*amount) as "���"
    from buytbl
    group by groupname;

select groupname,sum(price*amount) as "���"
    from buytbl
    group by groupname,idnum;

select sum(idnum),groupname,sum(price*amount) as "���"
    from buytbl
    group by groupname;
    


