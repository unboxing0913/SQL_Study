create table usertbl(
userid char(8) not null primary key, --����� ���̵�(PK)
username nvarchar2(10) not null, --�̸�
birthyear number(4) not null,
addr nchar(2) not null,--����(���,����,�泲 ������ 2���ڸ� �Է�)
mobile1 char(3),--�޴����� ����(010,011,016,017,018,019 ��)����
mobile2 char(8),--�޴����� ������ ��ȭ��ȣ(������ ����)
height number(3), --Ű
mdate date --ȸ��������
);
commit;




