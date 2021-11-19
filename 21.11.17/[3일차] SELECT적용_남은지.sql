-- TODO : 실습용 데이터베이스 생성
-- 1) sqlDB 데이터베이스 생성

DROP DATABASE IF EXISTS sqlDB; -- 기존의 sqlDB가 있으면 삭제
CREATE DATABASE sqlDB;

-- 2) USE sqlDB
USE sqlDB;

-- 3) 회원테이블 생성 : userTBL
CREATE TABLE userTBL
( userID 	CHAR(8) NOT NULL PRIMARY KEY,
  name		VARCHAR(10) NOT NULL,
  birthYear INT NOT NULL,
  addr		CHAR(2) NOT NULL,
  mobile1	CHAR(3),
  mobile2	CHAR(8),
  height		SMALLINT,
  mDate		DATE
  );
  
-- 4) 회원 구매 테이블 생성 : buyTBL
CREATE TABLE buyTBL
( num			INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  userID		CHAR(8) NOT NULL,
  prodName	CHAR(6) NOT NULL,
  groupName CHAR(4),
  price		INT NOT NULL,
  amount		SMALLINT NOT NULL,
  FOREIGN KEY (userID) REFERENCES userTBL(userID) -- 외래 키 지정
  ); 
  
-- 5) 회원 테이블에 데이터 INSERT
INSERT INTO userTBL VALUES('LSG', '이승기', 1987, '서울', '011', '11111111', 182, '2008-8-8');
INSERT INTO userTBL VALUES('KBS', '김범수', 1979, '경남', '011', '22222222', 173, '2012-4-4');
INSERT INTO userTBL VALUES('KKH', '김경호', 1971, '전남', '019', '33333333', 177, '2007-7-7');
INSERT INTO userTBL VALUES('JYP', '조용필', 1950, '경기', '011', '44444444', 166, '2009-4-4');
INSERT INTO userTBL VALUES('SSK', '성시경', 1979, '서울',  NULL,  NULL    , 186, '2013-12-12');
INSERT INTO userTBL VALUES('LJB', '임재범', 1963, '서울', '016', '66666666', 182, '2009-9-9');
INSERT INTO userTBL VALUES('YJS', '윤종신', 1969, '경남',  NULL,  NULL		 , 170, '2005-5-5');
INSERT INTO userTBL VALUES('EJW', '은지원', 1972, '경북', '011', '88888888', 174, '2014-3-3');
INSERT INTO userTBL VALUES('JKW', '조관우', 1965, '경기', '018', '99999999', 172, '2010-10-10');
INSERT INTO userTBL VALUES('BBK', '바비킴', 1973, '서울', '010', '00000000', 176, '2013-5-5');

-- 6) 구매 테이블에 데이터 INSERT
INSERT INTO buyTBL VALUES(NULL, 'KBS', '운동화',  NULL , 30,	2);
INSERT INTO buyTBL VALUES(NULL, 'KBS', '노트북', '전자', 1000, 1);
INSERT INTO buyTBL VALUES(NULL, 'JYP', '모니터', '전자', 200,  1);
INSERT INTO buyTBL VALUES(NULL, 'BBK', '모니터', '전자', 200,  5);
INSERT INTO buyTBL VALUES(NULL, 'KBS', '청바지', '의류', 50,	 3);
INSERT INTO buyTBL VALUES(NULL, 'BBK', '메모리', '전자', 80, 	10);
INSERT INTO buyTBL VALUES(NULL, 'SSK', '책'	 , '서적', 15,	5);
INSERT INTO buyTBL VALUES(NULL, 'EJW', '책'	 , '서적', 15,	2);
INSERT INTO buyTBL VALUES(NULL, 'EJW', '청바지', '의류', 50,	 1);
INSERT INTO buyTBL VALUES(NULL, 'BBK', '운동화',  NULL , 30, 	2);
INSERT INTO buyTBL VALUES(NULL, 'EJW', '책'	 , '서적', 15, 	1);
INSERT INTO buyTBL VALUES(NULL, 'BBK', '운동화',  NULL , 30, 	2);

-- 7) 데이터 확인
SELECT * FROM userTBL;
SELECT * FROM buyTBL;

-- 8) 특정 조건이 보고 싶을 때 검색 WHERE
SELECT * FROM userTBL WHERE name = '김경호';

-- 9) 조건을 2개 이상 같이 사용하고 싶을 때
-- 9-1) 1970년 이후 출생하고, 신장이 182 이상인 사람 
SELECT * FROM userTBL WHERE birthYear >= 1970 AND height >= 182;

-- 9-2) 1970년 이후 출생했거나, 신장이 182 이상인 사람
SELECT * FROM userTBL WHERE birthYear >= 1970 OR height >= 182;

-- 9-3) 신장이 175 이상이면서, 지역이 서울인 사람
SELECT * FROM userTBL WHERE height >= 175 AND addr = '서울';

-- 9-4) 핸드폰 앞자리가 010으로 시작하는 사람
SELECT * FROM userTBL WHERE mobile1 = '010';

-- 9-5) 서울에 살지 않는 사람 모두 찾아주세요 
SELECT * FROM userTBL WHERE addr != '서울';

-- 9-6) 핸드폰 앞자리가 010이 아닌 사람
SELECT * FROM userTBL WHERE mobile1 != '010';

-- 9-7) 핸드폰 앞자리가 011이 아니면서, 키가 175이하인 사람
SELECT * FROM userTBL WHERE mobile1 != '011' AND height <= 175;

-- 9-8) 구매 테이블에서 노트북를 1개 이상 구매한 고객
SELECT * FROM buyTBL WHERE prodName = '노트북' AND amount >= 1;

-- 9-9) 구매 테이블에서 책을 2권 이상 구매한 고객
SELECT * FROM buyTBL WHERE prodName = '책' AND amount >= 2;

-- 9-10) 구매 테이블에서 가격이 50이상이면서 구매 갯수가 2개 이상인 물건 
SELECT * FROM buyTBL WHERE price >= 50 AND amount >= 2;

-- 9-11) 구매 테이블에서 모니터를 구매한 고객을 제외한 구매리스트
SELECT * FROM buyTBL WHERE prodName != '모니터';

-- 9-12) 구매 테이블에서 구매 품목이 정해지지 않은 구매 리스트
SELECT * FROM buyTBL WHERE groupName IS NULL;

-- 9-12) 구매 테이블에서 구매 품목 중 NULL을 제외한 구매 리스트
SELECT * FROM buyTBL WHERE groupName IS NOT NULL;