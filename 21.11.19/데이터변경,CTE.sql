-- testTBL 테이블 생성
CREATE TABLE testTBL1(id int, userName char(3), age int);

-- 구조 확인
DESC testTBL1;

-- INSERT 1, 홍길동, 25세
INSERT INTO testTBL1 VALUES (1, '홍길동', 25);

-- INSERT 2, 설현 (데이터가 부족하게 왔을 경우)
-- 1) 없는 데이터를 NULL로 채운다
INSERT INTO testTBL1 VALUES (2, '설현', NULL);

-- 2) 암묵적으로 NULL처리 
INSERT INTO testTBL1(id, userName) VALUES (2, '설현');

SELECT * FROM testTBL1;

-- INSERT 초아, 26세, 3
INSERT INTO testTBL1(userName, age, id) VALUES ('초아', 26, 3);


-- AUTO_INCREMENT를 적용한 테이블 생성
CREATE TABLE testTBL2
(id int AUTO_INCREMENT PRIMARY KEY, 
 userName char(3), 
 age int);
 
 -- INSERT 지민 25세, 유나 22세, 유경 21세 
INSERT INTO testTBL2 VALUES (NULL, '지민', 25);
INSERT INTO testTBL2 VALUES (NULL, '유나', 22);
INSERT INTO testTBL2 VALUES (NULL, '유경', 21);
 
SELECT * FROM testTBL2;

-- id를 자동으로 100번부터 다시 발급
ALTER TABLE testTBL2 AUTO_INCREMENT = 100;
INSERT INTO testTBL2 VALUES (NULL, '찬미', 23);

-- AUTO_INCREMENT의 초기값은 1000으로 하고 3씩 증가해서 id 발급
CREATE TABLE testTBL3
(id int AUTO_INCREMENT PRIMARY KEY, 
 userName char(3), 
 age int);
ALTER TABLE testTBL3 AUTO_INCREMENT = 1000;
-- 증가값을 지정하는 서버 변수 
SET @@auto_increment_increment = 3;

INSERT INTO testTBL3 VALUES (NULL, '나연', 20);
INSERT INTO testTBL3 VALUES (NULL, '정연', 18);
INSERT INTO testTBL3 VALUES (NULL, '모모', 19);

SELECT * FROM testTBL3;

SELECT LAST_INSERT_ID(); -- 마지막에 INSERT된 값을 확인하는 쿼리문 


-- 테이블을 생성하고 그 후에 INSERT INTO SELECT를 통해 대량의 데이터 삽입
CREATE TABLE testTBL4
(id int AUTO_INCREMENT PRIMARY KEY, 
 Fname varchar(50), 
 Lname varchar(50)
);
ALTER TABLE testTBL4 AUTO_INCREMENT = 1000;
-- SET @@auto_increment_increment = 1; 
-- SET이 서버변수이기 때문에 다시 1씩 증가로 돌리기 원한다면
-- SET을 먼저 다시 실행
-- INSERT INTO SELECT 통해 대량의 데이터 삽입
INSERT INTO testTBL4
	SELECT NULL, first_name, last_name FROM employees.employees;


-- 데이터 확인
SELECT * FROM testTBL4;


-- 정보수정 UPDATE - Fname이 kyoichi인 사람의 Lname 없음으로 변경 
-- 1) kyoichi 정보 검색
SELECT * FROM testTBL4 WHERE Fname = 'kyoichi';

-- 2) 정보 수정 
UPDATE testTBL4 
	SET Lname = '없음'
WHERE Fname = 'kyoichi';

-- buyTBL 상품 가격을 인상 1.5배 (전체반영 - WHERE절 생략)
-- 1) 변경할 데이터 확인
SELECT price, price * 1.5 FROM buyTBL;

-- 정보 수정
UPDATE buyTBL
	SET price = price * 1.5;

SELECT * FROM buyTBL;
	

-- 데이터 삭제 DELETE
-- testTBL4 테이블에서 Fname이 Aamer인 사람 삭제 
-- 1) Aamer 정보 조회 - 228건 삭제 예정
SELECT * FROM testTBL4 WHERE Fname = 'Aamer';

-- 2) 데이터 삭제 
DELETE FROM testTBL4 WHERE Fname = 'Aamer';


-- 회원별로 총 구매액을 집계하고 가장 높은 구매액 순으로 정렬
SELECT userID, SUM(price * amount)
FROM buyTBL
GROUP BY userID
ORDER BY 2 DESC;

-- CTE 형태로 변경 
WITH cte_buyTBL(userID, total)
AS
(
SELECT userID, SUM(price * amount)
FROM buyTBL
GROUP BY userID 
)
SELECT * FROM cte_buyTBL
ORDER BY total DESC;

-- buyTBL 총합
WITH cte_buyTBL(userID, total)
AS
(
SELECT userID, SUM(price * amount)
FROM buyTBL
GROUP BY userID 
)
SELECT COUNT(total) FROM cte_buyTBL
ORDER BY total DESC;


-- 회원 테이블에서 각 지역별로 가장 큰 키를 한명씩 뽑은 후 
-- 그 사람들의 평균키를 집계하라
-- 1) 지역별로 가장 키 큰 사람과 가장 작은 사람 집계
SELECT addr, MAX(height), MIN(height)
FROM userTBL
GROUP BY addr;

-- 2) CTE로 만들어서 결과를 받은 후에 키 큰 사람 기준으로 평균, 
-- 키 작은 사람 기준으로 평균을 낸다. 
WITH cte_userTBL(addr, maxheight, minheight)
AS
(
SELECT addr, MAX(height), MIN(height)
FROM userTBL
GROUP BY addr
)
SELECT AVG(maxheight) AS '키 큰 사람 기준 평균', AVG(minheight) AS '키 작은 사람 기준 평균'
FROM cte_userTBL;


-- 변수를 선언해서 쿼리를 실행 
SET @myval5 = 5;
SET @myval2 = 2;
SET @myval = '서적';
-- 5개 이하 검색 
SELECT * FROM buyTBL 
WHERE amount <= @myval5 ;
-- 2개 이하 검색
SELECT * FROM buyTBL 
WHERE amount <= @myval2 ;
-- 분류에서 서적만 검색 
SELECT * FROM buyTBL 
WHERE groupName = @myval ;


-- 평균 구매개수를 정수로 표현
SELECT AVG(amount) FROM buyTBL;
-- 정수형 -> CAST(컬럼 AS 형식), CONVERT(컬럼, 형식) 형변환 방법
SELECT CAST(AVG(amount) AS SIGNED INTEGER) FROM buyTBL;
SELECT CONVERT(AVG(amount), SIGNED INTEGER) FROM buyTBL;
-- 문자형 -> 날짜형으로 변환
SELECT CAST('2022$12$12' AS DATE);
SELECT CAST('2022@12@12' AS DATE);
SELECT CAST('2022$13$12' AS DATE); -- 형변환 할 수 없는 경우엔 NULL 리턴

-- 암묵적 형변환 
SELECT '100' + '200'; 
-- -> 문자열의 합으로 표현
SELECT CONCAT('100', '200');



