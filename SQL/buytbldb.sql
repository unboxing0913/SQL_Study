create sequence idseq;--������ȣ ����
insert into buytbl values(idseq.nextval,'kbs','�ȭ',null,30,2);
insert into buytbl values(idseq.nextval,'kbs','��Ʈ��','����',1000,1);
insert into buytbl values(idseq.nextval,'jyp','�����','����',200,1);
insert into buytbl values(idseq.nextval,'bbk','�����','����',200,5);
insert into buytbl values(idseq.nextval,'kbs','û����','�Ƿ�',50,3);
insert into buytbl values(idseq.nextval,'bbk','�޸�','����',80,10);
insert into buytbl values(idseq.nextval,'ssk','å','����',15,5);
insert into buytbl values(idseq.nextval,'ejw','å','����',15,2);
insert into buytbl values(idseq.nextval,'ejw','û����','�Ƿ�',50,1);
insert into buytbl values(idseq.nextval,'bbk','�ȭ',null,30,2);
insert into buytbl values(idseq.nextval,'ejw','å','����',15,1);
insert into buytbl values(idseq.nextval,'bbk','�ȭ',null,30,2);
commit;

select * from buytbl;

