-- MariaDB의 내장함수 
-- IF(수식(연산, 비교), TRUE출력, FALSE출력)
SELECT IF (100 > 200, '참', '거짓');
SELECT IF (100 > 200, 100 / 200, 100 * 200);

-- IFNULL(컬럼, 널이면 실행)
SELECT IFNULL(NULL, '널이네요');
SELECT userID, prodName, IFNULL(groupName, '아직 미정') AS '분류' FROM buyTBL;

-- NULLIF(수식1, 수식2) 비교 한 다음에 같으면 NULL하고 다르면 수식1을 반환
SELECT IFNULL(NULLIF(100, 100), '널'), NULLIF(200, 100);

-- CASE WHEN ELSE END
SELECT CASE amount
		 WHEN 1  THEN '노력하세요'
		 WHEN 5  THEN '오'
		 WHEN 10 THEN '감사합니다'
		 ELSE '모름'
	END
FROM buyTBL;


-- 문자열 내장함수 
-- 1) LENGTH(문자열) 문자열의 길이를 변환 
SELECT LENGTH('가나다'), LENGTH('ABC'), CHAR_LENGTH('가나다'), CHAR_LENGTH('ABC');

-- 2) CONCAT() 문자열 연결시켜주는 함수 
SELECT '가나다' + '마바사'; -- 문자열 합이 안됨.
SELECT CONCAT('가나다', '마바사'); -- 문자열 더할 떄 
SELECT CONCAT(userID, '님 반갑습니다.')
FROM userTBL;
 
SELECT CONCAT_WS(',', userID, name) -- 문자열 더할 떄 중간에 , 넣기 
FROM userTBL;

SELECT FORMAT(price * amount, 5) FROM buyTBL;

-- 3) INSERT(문자열, 위치, 길이, 바꿀 문자) 문자열에 문자를 삽입해주는 함수 -> 데이터 마킹
-- 은지원 -> 은*원 마킹
SELECT userID, name, INSERT(name, 2, 1, '*')
FROM userTBL; 

-- 회원의 아이디, 핸드폰 번호(한번에 출력) 가운데 4자리 ****로 마킹해서 출력 
-- bbk, 010****0000 출력 
SELECT * FROM userTBL;
-- 마킹 후 mobile1 + mobile2
SELECT userID, 
CONCAT(mobile1, INSERT(mobile2, 1, 4, '****')) AS '연락처'
FROM userTBL;
-- mobile1 + mobile2 후 마킹
SELECT userID, 
INSERT(CONCAT(mobile1,mobile2), 4, 4, '****') AS '연락처'
FROM userTBL;


-- 4) INSTR(문자열, 찾을 문자)특정 문자의 위치를 찾는 함수
SELECT INSTR('042)9000-0000',')'); 

-- 5) UPPER() 대문자로 변경, LOWER() 소문자로 변경
-- 아이디 중복 확인 할 때 사용 
-- userN 가입하려고 하는데 usern -> UPPER('usern') = UPPER('userN')
SELECT UPPER('usern'), UPPER('userN') , LOWER('usern'), LOWER('userN');

-- 6) TRIM(컬럼명) 앞뒤 공백제거 
SELECT TRIM('       안녕...   ');

-- 7)REPLACE(문자열, 검색 단어, 변경할 단어)
SELECT REPLACE('이것이 MariaDB 이다.', '이것이', 'This is');

SELECT * FROM userTBL;
-- 경기 지역만 경기도로 변경해서 출력 
SELECT REPLACE(addr, '경기', '경기도')
FROM userTBL;

-- 8) SUBSRTING(문자열, 시작위치, 길이) 문자열을 잘라주는 함수 
-- 대한민국만세 -> 민국만 추출
SELECT SUBSTRING('대한민국만세', 3, 2);
-- 대한민국만세 -> 만세만 추출
SELECT SUBSTRING('대한민국만세', -2, 2);
-- '042)000-0000' 지역번호만 추출
SELECT SUBSTRING('042)000-0000', 1, INSTR('042)000-0000', ')')-1);


-- 수학함수
-- 1) 올림 : CEILING(숫자), 내림 : FLOOR(숫자), 반올림 : ROUND(숫자)
-- 소수점 표현하고 싶은 경우 ROUND() 반올림의 소수점 기준을 줄 수 있음 
SELECT CEILING(4.7), FLOOR(4.7), ROUND(4.7);
SELECT ROUND(4.75), ROUND(4.75, 1), ROUND(4.75, 5);
-- 지정된 소수점 이하 버림
SELECT TRUNCATE(4.759, 2);

-- MOD(숫자1, 숫자2) 숫자1과 숫자2를 나는 나머지 값을 리턴 
-- 나머지가 0과 1을 비교해서 홀수, 짝수 
SELECT MOD(10, 2); 


-- 날짜함수 
-- 1) ADDDATE(날짜, 차이) 날짜 더해주는 함수 
--    SUBDATE(날짜, 차이) 날짜 빼주는 함수 
-- 날짜 기준으로 차이를 배거나 더하기 
SELECT ADDDATE('2021-11-19', INTERVAL 5 MONTH), 
		 SUBDATE('2021-11-19', INTERVAL 5 MONTH);

-- 2) 현재 날짜와 시간을 제공해 주는 함수 
-- CURDATE() : 현재 날짜, CURTIME() : 현재 시간, 
-- NOW() : 현재 날짜 + 시간, SYSDATE() : 현재 날짜+ 시간 
SELECT CURDATE(), CURTIME(), NOW(), SYSDATE();
SELECT DATE(SYSDATE()),TIME(SYSDATE());

-- 3) 남은 일수 계산하는 함수 
-- DATEDIFF(날짜1, 날짜2) : 날짜1 - 날짜2
-- 지금으로부터 2021-12-31까지 얼마나 남았는지 
SELECT DATEDIFF(NOW(), '2021-12-31');

-- 2022-04-30까지 얼마나 남았나 
SELECT DATEDIFF(NOW(), '2022-04-30');

-- 4) LAST_DAY() 마지막 날을 반환해 주는 함수 
SELECT LAST_DAY('2030-02-01');
SELECT LAST_DAY('2028-02-01');


