
-- 현재 SAMPLE 계정은
-- 접속할 수 있는 CREATE SESSION 권한만
-- 부여받은 상태임

CREATE TABLE TEST(
    TEST_ID NUMBER
);

-- 3_1. SAMPLE 계정에
-- 테이블을 생성할수 있는 권한이 없기 때문에
-- 오류 발생
-- ORA-01031: insufficient privileges

-- CREATE TABLE 권한 부여받은 후
CREATE TABLE TEST(
    TEST_ID NUMBER
);

-- 3_2. TABLE SPACE 가 할당되지 않아서 
-- 오류 발생
-- ORA-01950: no privileges on tablespace 'SYSTEM'
--> TABLE SPACE : 테이블들이 모여있는 (저장되는) 공간
--> SYSTEM : 오라클 기본 제공 TABLE SPACE



-- TABLE SPACE 공간 할당받은 후
CREATE TABLE TEST(
    TEST_ID NUMBER

);

-- 위의 테이블 생성 권한을 부여받게 되면
-- 해당 계정이 소유하고 있는 테이블들을 "조작" 하는것도 가능해짐
-- (DML 구문 또한 사용 가능)

SELECT * FROM TEST;
INSERT INTO TEST VALUES(1);

-- 뷰 만들어 보기
CREATE VIEW V_TEST
AS (SELECT * FROM TEST);

-- 4. 뷰를 생성할 수 있는 CREATE VIEW 권한이 
-- 부여되지 않았기 때문에 오류 발생
-- ORA-01031: insufficient privileges

-- CREATE VIEW 권한 부여받은 후
CREATE VIEW V_TEST
AS (SELECT * FROM TEST);

--> 뷰 생성 완료!
----------------------------------------------------------------------------


-- SAMPLE 계정에서 KH 계정의 테이블에 접근해서 조회해보기

SELECT *
FROM KH.EMPLOYEE;


-- 5. KH 계정의 테이블에 접근해서 조회할 수 있는 권한이
-- 없기 때문에 오류 발생
-- ORA-00942: table or view does not exist

-- SELECT ON 권한 부여 후
SELECT * FROM KH.EMPLOYEE;
--> EMPLOYEE 테이블은 조회 성공
SELECT * FROM KH.DEPARTMENT;
--> KH 계정의 DEPARTMENT 테이블에 접근할 수 있는
-- 권한 이 없기 때문에 오류

-- SAMPLE 계정에서
-- KH 계정의 테이블에 접근해서 행 삽입해보기
INSERT INTO KH.DEPARTMNET VALUES('D0'
                               , '회계부'
                               , 'L2');

-- 6. KH 계정의 테이블에 접근해서 -- 행을 삽입할 수 있는 권한이 없기 때문에 오류 발생
-- SQL 오류 >>  ORA-00942: table or view does not exist

-- INSERT ON 권한 부여 후
INSERT INTO KH.DEPARTMENT VALUES('D0'
                                , '회계부'
                                , 'L2');

--> KH.DEPARTMENT 테이블에 행 INSERT 성공

COMMIT; -- SAMPLE 계정에서 실행 행위를 한 주체 쪽에서 실행해준다.

SELECT * FROM DEPARTMENT; -- KH 계정에서 실행

DELETE
    FROM DEPARTMENT
    WHERE DEPT_ID = 'D0'; -- KH 계정에서 실행
    COMMIT; -- KH 계정에서 실행
-------------------------------------------------------------------------------

-- 테이블 만들어 보기
CREATE TABLE TEST2(
    TSET_ID NUMBER
);

-- 7. SAMPLE 계정에서 테이블을 생성할 수 없도록
-- 권한을 회수했기 때문에 오류 발생
-- ORA-01031: insufficient privileges

