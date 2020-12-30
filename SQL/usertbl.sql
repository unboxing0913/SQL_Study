create table usertbl(
userid char(8) not null primary key, --사용자 아이디(PK)
username nvarchar2(10) not null, --이름
birthyear number(4) not null,
addr nchar(2) not null,--지역(경기,서울,경남 식으로 2글자만 입력)
mobile1 char(3),--휴대폰의 국번(010,011,016,017,018,019 등)가정
mobile2 char(8),--휴대폰의 나머지 전화번호(하이픈 제외)
height number(3), --키
mdate date --회원가입일
);
commit;




