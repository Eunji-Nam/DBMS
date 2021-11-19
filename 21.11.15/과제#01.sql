-- 1) 데이터 베이스 생성 -> 본인의 이니셜로 만든다 ex) osjdb
-- 2) 테이블 생성 P.51 테이블 설계서에 따라서 컬럼명은 사용하되 테이블 명은 memberTB, productTB 변경해서 생성
-- 3) 데이터 insert:  memberTB-> P.58, productTB -> P.56
-- 4) memberTB에서 사용자 아이디와 주소만 출력하는 쿼리
SELECT memberID, memberAddress FROM memberTB;

-- 5) productTB에서 전체 모든 컬럼을 출력하되, 제조사가 LG인 데이터만 검색
SELECT * FROM productTB WHERE company='LG';

-- 6) index 만드는 작업 진행
-- 6-1) idxTBL 테이블을 생성 컬럼: first_name varchar(14), last_name varchar(16), hire_date date
CREATE TABLE indexTBL (first_name varchar(14), last_name varchar(16), hire_date date);

-- 6-2) employees.employees 테이블에서 1500건의 데이터 insert (힌트: LIMIT 1500;)
INSERT INTO indexTBL
			SELECT first_name, last_name, hire_date
			FROM employees.employees
			LIMIT 1500;
SELECT * FROM indexTBL;

-- 6-3) Explain idxTBL의 이름 중에 Mary인 사람 조회 결과 캡쳐
EXPLAIN SELECT * FROM indexTBL WHERE first_name = 'Mary';

-- 6-4) idxTBL 테이블에 first_name index를 생성
CREATE INDEX idx_indexTBL_firstname ON indexTBL(first_name);

-- 6-5) Explain idxTBL의 이름 중에 Mary인 사람 조회 결과 캡쳐
EXPLAIN SELECT * FROM indexTBL WHERE first_name = 'Mary';


-- 7) VIEW 생성
-- 7-1) uv_idxTBL 생성하는데, idxTBL 테이블에서 first_name과 hire_date 컬럼만 보이도록 
SELECT first_name, hire_date FROM indexTBL;

CREATE VIEW uv_memberTBL
AS
	SELECT first_name, hire_date FROM indexTBL;
	
-- VIEW 조회
SELECT * FROM uv_memberTBL;

