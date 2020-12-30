create table buytbl(
idnum number(8) not null primary key,--순번(PK)
userid char(8) not null,--아이디(FK)
prodname nchar(6) not null,--물품명
groupname nchar(4),--분류
price number(8) not null,--단가
amount number(3) not null,--수량
foreign key (userid) references usertbl(userid)
);
commit;