-- TODO: memberTBL 테이블에서 회원이 삭제되면 다른 백업 테이블로 회원 정보 이전

-- 1) 백업 테이블 만들기 deletedmemberTBL -> mamberTBL 테이블의 구조 반영
CREATE TABLE deletedmemberTBL (
	memberID char(8),
	memberName char(5),
	memberaddress char(20),
	deleteDate date
);

-- 2) 트리거 생성 trg_deletedmemberTBL
DELIMITER //
CREATE TRIGGER trg_deletedmemberTBL -- 트리거 이름
	AFTER DELETE -- 삭제 후에 작동하도록 지정
	ON memberTBL -- 트리거를 부착할 테이블
	FOR EACH ROW -- 각 행마다 적용
BEGIN
	-- OLD 테이블의 내용을 백업 테이블에 삽입 ( 실제 실행 쿼리)
	INSERT INTO deletedmemberTBL
		VALUES (OLD.memberID, OLD.memberName, OLD.memberaddress, CURDATE() );
END //
DELIMITER ;

-- 3) 백업 테이블 확인 deletedmemberTBL
SELECT * FROM deletedmemberTBL;

-- 4) memberTBL 확인
SELECT * FROM memberTBL;

-- 5) memberTBL에 memberName이 당탕이 인 회원 삭제 
SELECT * FROM memberTBL WHERE memberName = '당탕이';
-- SELECT 후에 DELETE
DELETE FROM memberTBL WHERE memberName = '당탕이';
