--local-sqldb


--1970년 이후에 출생하고 신장이 180인 사람의 아이디와 이름을 조회
select userid,username from usertbl where birthyear >= 1970 and height >= 180;
--1970년 이후에 출생했거나 신장이 180인 사람의 아이디와 이름을 조회
select userid,username from usertbl where birthyear >= 1970 or height >= 180;
--키가 180~183인 사람 조회
select username,height from usertbl where height >=180 and height <= 183;

--between and
select username,height from usertbl where height between 180 and 183;

--지역이 '경남','전남','경북' 인 사람의 이름과 지역 조회 
select username,addr from usertbl where addr='경남' or addr='전남' or addr='경북';

--in( )함수
select username,addr from usertbl where addr in ('경남','전남','경북');

--like 연산자, % 무엇이든허용, _:한글자와 매치
select username,height from usertbl where username like '김%';
select username,height from usertbl where username like '_종신';
--'조용필','조용한 사람','이용해 주셔서 감사합니다'
select username,height from usertbl where username like '_용%';

--subquery:하위쿼리
select username,height from usertbl where height >177;
select username,height from usertbl
    where height > (select height from usertbl where username='김경호');
--지역이 '경남'사람의 키보다 크거나 같은 사람 조회 (170,173)

--any는 서브쿼리의 여러 개의 결과 중 한가지만 만족해도 된다.
select username, height from usertbl  
    where height >= any(select height from usertbl where addr='경남');

--all은 서브쿼리의 여러 개의 결과를 모두 만족해야 된다.    
select username, height from usertbl  
    where height >= all(select height from usertbl where addr='경남');

select username, height from usertbl
    where height in(select height from usertbl where addr='경남');
    
--order by (default:ascending)
select username,mdate from usertbl order by mdate;
select username,mdate from usertbl order by mdate asc; --오름차순(기본값)
select username,mdate from usertbl order by mdate desc; --내림차순
--키가 큰 순서로 정렬하되 만약 키가 같을 경우에 이름 순으로 정렬
select username,height from usertbl order by height desc,username asc; --asc는 기본값이기때문에 안붙여도됨

--중복 제거
select addr from usertbl;
select addr from usertbl order by addr;
select distinct addr from usertbl;

--group by
select userid,amount from buytbl order by userid;
select userid as "사용자 아이디",sum(amount)as "총 구매 개수" from buytbl group by userid;
select userid "사용자 아이디" from buytbl group by userid;  --as문 생략가능 
--각각 아이디별로 구매한 구매액의 총합
select userid as 사용자아이디 , sum(price*amount) as 총구매액
    from buytbl group by userid;

--avg() 함수 평균값 구하기
select avg(amount) as "평균 구매 갯수" from buytbl;
--cast(숫자 as 변환할 형식) 함수 소수점 조절
select cast(avg(amount)as number(5,3)) as "평균 구매 갯수" from buytbl;
--각 사용자 별로(id)한 번 구매 시 물건을 평균적으로 몇개 구매했는지 평균 조회
select userid, cast(avg(amount)as number(1,0)) as "평균 구매 갯수" from buytbl group by userid;

--가장 큰 키와 가장 작은 키의 회원 이름과 키를 조회
select username, max(height),min(height) from usertbl group by username; --그룹화하면 각네임의 최소값 최대값 검색
--group by 사용 없이 해봄,서브쿼리 이용
select username,height from usertbl where height in((select max(height) from usertbl),(select min(height) from usertbl));
select username,height from usertbl where height=(select max(height)from usertbl) or height=(select min(height)from usertbl);

--count()함수:행의 개수를 센다.
select count(*) from usertbl;
--휴대폰이 있는 사용자 수 조회.
select count(mobile1)as "휴대폰이 있는 사용자" from usertbl;

--having
--총 구매액이 1000이상인 사용자.
select userid as "사용자",sum(price*amount)as "총 구매액"
    from buytbl
    --where sum(price*amount)>1000;
    group by userid
    having sum(price*amount)>1000 --having절 위치중요
    order by sum(price*amount); 

--rollup()
select /*idnum,*/groupname,sum(price*amount) as "비용"
    from buytbl
    group by groupname;

select groupname,sum(price*amount) as "비용"
    from buytbl
    group by groupname,idnum;

select sum(idnum),groupname,sum(price*amount) as "비용"
    from buytbl
    group by groupname;
    


