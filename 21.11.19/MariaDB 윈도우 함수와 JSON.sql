-- MariaDB 윈도우 함수 

-- 회원 중에 키가 큰 순으로 순위를 정하고 싶다 : ROW_NUMBER()
-- 1) 키 큰 순으로 정렬 
SELECT height, name, addr FROM userTBL
ORDER BY height DESC; 
-- 2) ROW_NUMBER()으로 순위를 부여 
SELECT ROW_NUMBER() OVER(ORDER BY height DESC, name ASC) 
		AS '키 큰 순위', name, addr, height 
FROM userTBL;

-- 3) 순위가 동률일 때 공정하게 부여하는 방식 
SELECT DENSE_RANK() OVER(ORDER BY height DESC) 
		AS '키 큰 순위', name, addr, height 
FROM userTBL;

-- 4) 순위를 동률일 때 같은 순위를 주고 다음은 건너뛰고 순위를 부여하는 방식(올림필 방식)
SELECT RANK() OVER(ORDER BY height DESC) 
		AS '키 큰 순위', name, addr, height 
FROM userTBL;

-- 5) 전체 순위말고 지역별로 순위 부여 
SELECT ROW_NUMBER() OVER(PARTITION BY addr ORDER BY height DESC, name ASC) 
		AS '키 큰 순위', name, addr, height 
FROM userTBL;

-- 6) 가장 키 큰 사람의 키와 비교해서 차이 확인 
SELECT addr, name, height, 
		 height - (FIRST_VALUE(height) OVER(ORDER BY height DESC)) AS '키 차이'
FROM userTBL;

-- 7) 지역별로 가장 키 큰 사람의 키와 비교해서 차이 확인 
SELECT addr, name, height, 
		 height - (FIRST_VALUE(height) OVER(PARTITION BY addr ORDER BY height DESC)) AS '키 차이'
FROM userTBL;


-- 공통의 데이터 포멧으로 JSON형태로 쿼리 결과를 변경 
SELECT JSON_OBJECT('addr', addr, 'name', name, 'height', height) AS 'JSON'
FROM userTBL;

SELECT JSON_OBJECT('addr', addr, 'name', name, 'height', height, 
						 'distance', (height - (FIRST_VALUE(height) OVER(ORDER BY height DESC)))) 
						 AS 'JSON VALUE'
FROM userTBL;



