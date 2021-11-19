-- 1} 500건의 데이터가 있는 indexTBL 테이블을 생성
CREATE TABLE indexTBL (first_name varchar(14),  -- 먼저 실행
								last_name varchar(16),
								hire_date date);
-- 1-2) 500건의 데이터 insert
INSERT INTO indexTBL
			SELECT first_name, last_name, hire_date
			FROM employees.employees
			LIMIT 500;
			
			
-- 1-3)
SELECT * FROM indexTBL;			

-- 2) indexTBL의 이름 중에 Mary인 사람 조회
SELECT * FROM indexTBL WHERE first_name = 'Mary';

-- 2-1) 실행계획으로 확인
EXPLAIN SELECT * FROM indexTBL WHERE first_name = 'Mary';

-- 실제 데이터에서 검색 0.094sec.
EXPLAIN SELECT * FROM employees.employees WHERE first_name = 'Mary';

-- 3) index 생성
CREATE INDEX idx_indexTBL_firstname ON indexTBL(first_name);   

-- 실행 후 4)실행

-- 4) 다시 검색 해보기
EXPLAIN SELECT * FROM indexTBL WHERE first_name = 'Mary';