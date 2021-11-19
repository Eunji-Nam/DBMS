-- 쿼리 2개를 한번에 실행하는 myProc()라는 프로시저를 생성

-- 1) 쿼리 2개 준비
SELECT * FROM memberTBL WHERE memberName = '당탕이'
SELECT * FROM productTBL WHERE productName = '냉장고'

-- 2) ㅡmyProc() 프로시저를 생성
DELIMITER //
CREATE PROCEDURE myProc()
BEGIN
	SELECT * FROM memberTBL WHERE memberName = '당탕이';
	SELECT * FROM productTBL WHERE productName = '냉장고';
END //
DELIMITER ;

-- 3) myProc() 실행
CALL myProc();