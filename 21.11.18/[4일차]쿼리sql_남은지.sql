-- 키가 180 ~ 185 사이의 회원만 검색
SELECT * FROM userTBL;
SELECT * FROM userTBL WHERE height >= 180 AND height <= 185; -- 비교연산시에 실무에서 더 많이 사용.
																				 -- (쿼리 실행시간이 더 빠름)
SELECT * FROM userTBL WHERE height BETWEEN 180 AND 185; -- 숫자로 구성/연속적인 값일 떄 사용.
																		  -- 문자열은 안됨.

-- IN() 적용
-- 키가 166, 172, 182인 회원만 검색
SELECT * FROM userTBL 
WHERE height = 166 OR height = 172 OR height = 182;

SELECT * FROM userTBL
WHERE height IN (166, 172, 182); -- 특정값 연산 시에 실무에서 더 많이 사용

-- 전남, 경남 지역의 회원만 검색
SELECT * FROM userTBL
WHERE addr = '전남' OR addr = '경남';

SELECT * FROM userTBL
WHERE addr IN('전남', '경남');

-- LIKE 연산자 : 문자열 검색, 성능저하의 원인-큰DB에서는 피할 것
-- 회원 중 김씨 성을 가진 회원만 검색
SELECT * FROM userTBL WHERE name LIKE '김%';  -- %에 무엇이 오든 상관않겠다. 는 의미

-- 성을 제외한 이름에 '용'이라는 단어가 들어가는 회원을 검색
SELECT * FROM userTBL WHERE name LIKE '_용%';  -- _는 검색하지 않고 두번째 글자부터 검색.
															  -- 성이 2자일 수도 있기 때문에 3글자임을 가정.

-- 성을 제외한 이름에 '원'으로 끝나는 회원을 검색
SELECT * FROM userTBL WHERE name LIKE '__원';
SELECT * FROM userTBL WHERE name LIKE '%원';

-- 성을 제외한 이름에 '원'으로 끝나는 회원을 검색
SELECT * FROM userTBL WHERE name LIKE '_종신';

-- 김경호 회원보다 키가 큰 회원을 검색 
-- 1) 김경호 회원의 키를 검색
SELECT userID, name, height FROM userTBL WHERE name ='김경호';
-- 2) 177보다 키가 큰 회원을 검색
SELECT * FROM userTBL WHERE height > 177;

-- 3) 서브쿼리로 하나의 쿼리 생성
SELECT * FROM userTBL 
WHERE height > (SELECT height FROM userTBL WHERE name ='김경호');

-- 은지원보다 키가 큰 회원을 검색(174보다 큰 회원 검색됨)
SELECT * FROM userTBL 
WHERE height > (SELECT height FROM userTBL WHERE name ='은지원');

-- 전남에 사는 회원보다 키가 큰 회원을 검색
-- 1) 전남에 사는 회원의 키 검색
SELECT userID, name, height FROM userTBL WHERE addr ='전남';
-- 2) 177보다 큰 사람을 검색
SELECT * FROM userTBL WHERE height > 177;
-- 3) 서브쿼리로 하나의 쿼리 생성
SELECT * FROM userTBL 
WHERE height > (SELECT height FROM userTBL WHERE addr ='전남');


-- 서울에 사는 회원보다 키가 큰 회원을 검색
-- 1) 서울에 사는 회원의 키 검색
SELECT userID, name, addr, height FROM userTBL WHERE addr ='서울';
-- 2) 서울 사는 회원보다 큰 사람을 검색
SELECT * FROM userTBL WHERE height > -- 176, 182, 186??;

-- 3) 서브쿼리로 하나의 쿼리 생성 -> ANY를 사용하면 서브쿼리의 제일 작은 값보다 큰 값
-- 176보다 큰 사람
SELECT * FROM userTBL 
WHERE height > ANY (SELECT height FROM userTBL WHERE addr ='서울');

-- 4) 서울 사람들의 키 조건이 모두 만족할 수 있게 검색
-- ALL : 서브 쿼리에서 가장 큰 값보다 큰 값에 대한 결과가 나옴
-- 186보다 큰 사람
SELECT * FROM userTBL 
WHERE height > ALL (SELECT height FROM userTBL WHERE addr ='서울');

--  서울 회원들의 키와 같은 회원 검색
SELECT * FROM userTBL 
WHERE height = ANY (SELECT height FROM userTBL WHERE addr ='서울');
-- '= ANY' 와 'IN'은 같음
SELECT * FROM userTBL 
WHERE height IN (SELECT height FROM userTBL WHERE addr ='서울');

SELECT * FROM userTBL 
WHERE height IN (176, 182, 186);

-- 경남 회원들보다 어린 회원들 검색 (출생년도 비교)
-- 1) 경남 회원들의 출생년도 검색
SELECT userID, name, birthYear, addr FROM userTBL WHERE addr = '경남';

-- 2) 경남 회원보다 어린 회원 검색
SELECT * FROM userTBL WHERE birthYear > ; -- 1979, 1969 ?

-- 3) 경남 회원들보다 어린 사람 (조건에 하나 이상 포함시켜 비교)
-- 1969년 
SELECT * FROM userTBL 
WHERE birthYear > ANY (SELECT birthYear FROM userTBL WHERE addr = '경남');

-- 경남 사람 중에 가장 어린 사람 기준으로 비교 
-- 1979년
SELECT * FROM userTBL 
WHERE birthYear > ALL (SELECT birthYear FROM userTBL WHERE addr = '경남');

-- 경남 사람들과 같은 나이의 회원 검색
SELECT * FROM userTBL 
WHERE birthYear = ANY (SELECT birthYear FROM userTBL WHERE addr = '경남');

SELECT * FROM userTBL 
WHERE birthYear IN (SELECT birthYear FROM userTBL WHERE addr = '경남');

SELECT * FROM userTBL 
WHERE birthYear = ALL (SELECT birthYear FROM userTBL WHERE addr = '경남'); -- 결과값 없음

-- ORDER BY 컬럼명 ASC(오름차순-생략가능), DESC(내림차순)
SELECT * FROM buyTBL ORDER BY num DESC; 

-- 회원 이름으로 정렬 오름차순
SELECT * FROM userTBL ORDER BY name ASC;

-- 회원 이름으로 정렬 내림차순
SELECT * FROM userTBL ORDER BY name DESC;

-- 지역으로 오름차순
SELECT * FROM userTBL ORDER BY addr;

-- 지역 오름차순 후 이름 오름차순
SELECT * FROM userTBL ORDER BY addr, name;

-- 지역 내림차순 후 이름 오름차순
SELECT * FROM userTBL 
WHERE addr IN ('서울','경남')
ORDER BY addr DESC, name;

-- 지역과 이름 내림차순 
SELECT * FROM userTBL 
WHERE addr IN ('서울','경남')
ORDER BY addr DESC, name ; -- DESC은 각각의 컬럼에 걸어줄 것, 생략시 오름차순!

-- 회원들의 지역을 검색 (중복 제거)
SELECT DISTINCT addr FROM userTBL;

-- employees 데이터베이스에서 employees의 성별을 중복 제거 /category별로 확인할 때 좋음
SELECT DISTINCT gender FROM employees.employees;

-- employees 데이터베이스에서 titles 테이블의 직급이 어떻게 구성되었나
SELECT DISTINCT title FROM employees.titles;

-- employees 데이터베이스에서 입사일이 가장 오래된 직원 5명
SELECT emp_no, first_name, hire_date FROM employees.employees
ORDER BY hire_date ASC
LIMIT 0, 5;

-- buyTBL 테이블과 톡같은 구조, 데이터를 가진 테이블 생성 (백업)
CREATE TABLE buyTBL3
(
SELECT * FROM buyTBL
);

SELECT * FROM buyTBL3;
SELECT * FROM buyTBL;

-- buyTBL에서 userID, prodName, price로만 된 테이블 생성 (데이터 포함)
-- amount  주문 수가 2개 이상인 상품
CREATE TABLE buyTBL2
(
SELECT userID, prodName, price FROM buyTBL
WHERE amount >= 2
);

SELECT * FROM buyTBL2;


-- buyTBL의 구조만 복사해서 buyTBL4 테이블 생성
SELECT * FROM buyTBL WHERE 1 = 0;

CREATE TABLE buyTBL4
(
SELECT * FROM buyTBL WHERE 1 = 0
);

SELECT * FROM buyTBL4;

-- GROUP BY -> 그룹을 지을 수 있는 칼럼을 이해하는 것이 중요!
-- 회원 중에 구매한 물건의 수를 집계
-- userID가 중복되지 않도록 그룹
SELECT * FROM buyTBL  
GROUP BY userID;

-- userID별 구매 개수의 합
SELECT userID, SUM(amount) FROM buyTBL 
GROUP BY userID;

-- 별칭을 부여하여 정리 
SELECT userID AS '사용자 아이디', SUM(amount) AS '총 구매 개수' FROM buyTBL
GROUP BY userID; 

-- 회원의 총 구매액 집계
SELECT userID AS '사용자 아이디', SUM(amount*price) AS '총 구매액' FROM buyTBL
GROUP BY userID
ORDER BY 2 DESC; -- ORDER BY 이용시 별칭으로 정렬할 수 없으므로 숫자로 명시

-- 전체 회원의 구매액 -> 매출 집계
SELECT SUM(amount*price) AS '총 구매액' FROM buyTBL;
SELECT SUM(amount) AS '총 구매 개수' FROM buyTBL;
--  전체 회원의 평균 구매액
SELECT AVG(amount*price) AS '평균 구매액' FROM buyTBL;
SELECT AVG(amount) AS '평균 구매 개수' FROM buyTBL;

-- 회원별 평균 구매액
SELECT userID, AVG(amount*price) AS '평균 구매액' FROM buyTBL
GROUP BY userID;

-- 회원별 평균 구매 갯수 
SELECT userID, AVG(amount) AS '평균 구매수' FROM buyTBL
GROUP BY userID;

-- 가장 키 큰 사람과 가장 키 작은 사람, 평균 키 
SELECT MAX(height), MIN(height), AVG(height) FROM userTBL;

-- 키 가장 큰 사람은 누구?
-- 1) 가장 큰 키를 찾는다
SELECT MAX(height) FROM userTBL;
-- 2) 서브쿼리의 조건으로 연결
SELECT * FROM userTBL 
WHERE height = (SELECT MAX(height) FROM userTBL);

-- 키가 가장 작은 사람 
SELECT * FROM userTBL 
WHERE height = (SELECT MIN(height) FROM userTBL);

-- 키가 평균 이상인 사람
SELECT * FROM userTBL 
WHERE height >= (SELECT AVG(height) FROM userTBL);

-- 키가 가장 큰 사람과 작은 사람을 한번에 검색
SELECT * FROM userTBL 
WHERE height = (SELECT MAX(height) FROM userTBL)
OR height = (SELECT MIN(height) FROM userTBL);

SELECT * FROM userTBL 
WHERE height IN(SELECT MAX(height), MIN(height) FROM userTBL); 
-- IN에서 결과값이 2개가 나와서 비교가 안되어서 오류남 


-- 제일 사용 많이 하는 집계 함수는 COUNT()
SELECT COUNT(*) FROM userTBL;  -- user가 몇 명인지
SELECT COUNT(*) FROM buyTBL;  -- 구매 갯수

-- 고객의 구매 갯수 
SELECT userID, COUNT(userID) FROM buyTBL
GROUP BY userID;

-- COUNT() 할 때, NULL은 제외하고 수를 셈
SELECT COUNT(mobile1) FROM userTBL;

SELECT COUNT(*) FROM userTBL
WHERE mobile1 IS NOT NULL;

-- NULL을 수를 셀 때 
SELECT COUNT(*) - COUNT(mobile1) AS '핸드폰 미등록자 수' FROM userTBL;

SELECT COUNT(*) FROM userTBL
WHERE mobile1 IS NULL;


-- 검색 조건에 집계함수를 사용하고 싶다 
-- 총 구매액에 1000 이상인 사용자에게 사은품 증정
-- 총 구매액이 1000 이상인 사용자 검색
SELECT * FROM buyTBL 
WHERE SUM(amount*price) > 1000; -- WHERE절에는 집계 함수를 사용할 수 없으므로 오류남

-- WHERE절에는 집계 함수를 쓰려면, 서브쿼리로만 됨, 자체로는 안됨
-- GROUP BY HAVING 으로 사용 가능
SELECT userID, SUM(amount*price)
FROM buyTBL
GROUP BY userID
HAVING SUM(amount*price) > 1000;

-- 1) 사용자 그룹 정의 
SELECT userID
FROM buyTBL
GROUP BY userID;

SELECT userID, 
		AVG(amount*price), COUNT(*), SUM(amount*price), MAX(amount*price), MIN(amount*price)
FROM buyTBL
WHERE userID != 'BBK' -- 조건 검색(비교연산자) 가능함, 집계 함수는 사용 불가
GROUP BY userID
HAVING AVG(amount*price) > 400;

-- 회원 중에 구매액이 평균 이상 구매한 사람만 검색
SELECT userID, 
		AVG(amount*price), COUNT(*), SUM(amount*price), MAX(amount*price), MIN(amount*price)
FROM buyTBL
GROUP BY userID
HAVING AVG(amount*price) > (SELECT AVG(amount*price) FROM buyTBL);

-- 회원 중에 구매 수가 평균 이하인 사람만 검색 
-- 회원 별로 구분
-- SELECT userID, amount FROM buyTBL
SELECT userID, 
		AVG(amount), COUNT(*), SUM(amount), MAX(amount), MIN(amount)
FROM buyTBL
GROUP BY userID
HAVING SUM(amount) <= (SELECT AVG(amount) FROM buyTBL);

-- 평균 구매 수량보다 많이 구매한 회원 검색
SELECT userID, 
		SUM(amount), AVG(amount), COUNT(*), MAX(amount), MIN(amount)
FROM buyTBL
GROUP BY userID
HAVING SUM(amount) >= (SELECT AVG(amount) FROM buyTBL)
ORDER BY 2 DESC;

-- 중간 합계, 총합까지 집계 -> ROLLUP
SELECT * FROM buyTBL;

-- groupName별로 합계 및 그 총합을 집계
SELECT num, userID, SUM(amount)
FROM buyTBL
GROUP BY userID, num -- PK를 넣어주면 중간합계를 볼 수 있음 
WITH ROLLUP;

SELECT groupName, SUM(amount)
FROM buyTBL
GROUP BY groupName
WITH ROLLUP;


-- 과제 
SELECT * FROM buyTBL;
-- 1) 사용자 기준으로, 구매액을 중간 합계를 포함해서 총 합계를 집계 
SELECT num AS 'No', userID AS '사용자아이디', SUM(amount*price) AS '구매액'
FROM buyTBL
GROUP BY userID, num
WITH ROLLUP;

-- 2) 분류 기준으로, 구매액을 중간 합계를 포함해서 총 합계를 집계 
SELECT num AS 'No', groupName AS '분류', SUM(amount*price) AS '구매액'
FROM buyTBL
GROUP BY groupName, num
WITH ROLLUP;

-- 3) 상품명 기준으로, 구매액을 중간 합계를 포함해서 총 합계를 집계 
SELECT num AS 'No', prodName AS '상품명', SUM(amount*price) AS '구매액'
FROM buyTBL
GROUP BY prodName, num
WITH ROLLUP;

-- 4) 분류 기준으로, 구매액을 중간 합계를 포함해서 총 합계를 집계 
-- (분류 NULL 제외)
SELECT num AS 'No', groupName AS '분류', SUM(amount*price) AS '구매액'
FROM buyTBL
WHERE groupName IS NOT NULL
GROUP BY groupName, num 
WITH ROLLUP;