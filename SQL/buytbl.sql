create table buytbl(
idnum number(8) not null primary key,--����(PK)
userid char(8) not null,--���̵�(FK)
prodname nchar(6) not null,--��ǰ��
groupname nchar(4),--�з�
price number(8) not null,--�ܰ�
amount number(3) not null,--����
foreign key (userid) references usertbl(userid)
);
commit;