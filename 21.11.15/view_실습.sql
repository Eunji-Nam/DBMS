-- 아르바이트 생에게는 회원 정보 테이블에서 회원 아이디와 주소만 공개하고 싶다
-- 회원 테이블에서 회원 아이디, 주소만 view로 생성해서 제공


-- 1) 회원 테이블에서 아이디, 주소만 추출하는 쿼리 만들기 
SELECT memberID, memberAddress FROM memberTBL;

-- 2) VIEW로 만들기
CREATE VIEW uv_memberTBL
AS
	SELECT memberID, memberAddress FROM memberTBL;
	
-- 3) VIEW 조회
SELECT * FROM uv_memberTBL;

-- 4) 아이디와 이름만 VIEW로 만들기
SELECT memberID, memberName FROM memberTBL;

-- 4-1) VIEW 생성
CREATE VIEW uv2_memberTBL
AS
	SELECT memberID, memberName FROM memberTBL;
	
-- VIEW 실행
SELECT * FROM uv2_memberTBL;
