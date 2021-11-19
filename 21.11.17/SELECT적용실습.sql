-- USE employees (데이터베이스) 했을 경우 데이터베이스명 생략 가능
SELECT *
FROM titles;
SELECT *
FROM employees.titles;

-- 특정 컬럼만 내용 순서에 맞게 가져와서 SELECT 하기(원하는 대로)
SELECT to_date, emp_no, title, to_date
FROM titles;

-- 정보 확인할 때 사용
SHOW DATABASES;
-- 확인 후 접속
USE employees;
-- 접속 DB의 테이블 확인
SHOW TABLES;
SELECT *
FROM departments;

-- 테이블정보 조회
SHOW TABLE STATUS;

-- 테이블의 특정 열 이름 확인 -> 데이터의 구조(스키마)를 알고 싶을 때
DESC departments; DESC employees;

-- 별칭을 줘서 열 이름과 다르게 결과 내보내기 (AS는 ''로 대체 가능)
SELECT first_name AS 이름, gender AS 성별, hire_date '회사입사일'
			FROM employees;

