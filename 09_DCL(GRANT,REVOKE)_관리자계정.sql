/*
    < DCL >
    
    DATA CONTROL LANGUAGE
    데이터 제어 언어
    
    
    계정에서 시스템 권한 또는 객체 접근권한을
    부여 (GRANT) 하거나 회수 (REVOKE) 하는 언어
    
    
    => 데이터 변경 내용을 픽스해주는 COMMIT,
       데이터 변경 내용을 복구해주는 ROLLBACK 또한 DCL 로 분류됨
       하지만 TCL (TRANSACTION CONTROL LANGUAGE)
       로 따로 분류하기도 함!!
       
    * 권한 부여 (GRANT)
    - 시스템권한 : 특정 DB에 접근하는 권한, 객체들을 생성할 수 있는 권한
    - 객체접근권한 : 특정 객체들에 접근해서 '조작' 할 수 있는 권한
    
    * 시스템권한
    특정 DB에 접근하는 권한, 객체들을 생성할 수 있는 권한
    
    [ 표현법 ]
    GRANT 권한명1, 권한명2, ... TO 계정명;
    
    - 시스템권한의 종류
    CREATE SESSTION : 계정에 접속할 수 있는 권한
    CREATE TABLE : 테이블을 생성할 수 있는 권한
    CREATE VIEW : 뷰를 생성할 수 있는 권한
    CREATE SEQUENCE : 시퀀스를 생성할 수있는 권한
    CREATE USER : 계정을 생성할 수 있는 권한
    ...
    
    
*/

-- 1. SAMPLE 일반 계정 생성
CREATE USER SAMPLE IDENTIFIED BY SAMPLE;

--> 접속할 수 있는 권한 CREATE SESSION 권한을 부여하지 않았더니
-- 접속 시 logon denied 오류 발생

-- 2. SAMPLE 계정에 접속하기 위한 CREATE SESSION 권한 부여
GRANT CREATE SESSION TO SAMPLE;

--3_1. SAMPLE 계정에 테이블을 생성할 수 있는
-- CREATE TABLE 권한 부여
GRANT CREATE TABLE TO SAMPLE;


--3_2. SAMPLE 계정에 테이블 스페이스 공간 할당해주기
-- (ALTER 구문을 통해 SAMPLE 계정 변경)
ALTER USER SAMPLE QUOTA 2M ON SYSTEM;
--> QUDTA : 할당하다 (나눠주다)
--> 2M : 2 MEGA BYTE

-- 4. SAMPLE 계정에 뷰를 생성할 수 있는
-- CREATE VIEW 권한 부여
GRANT CREATE VIEW TO SAMPLE;

--------------------------------------------------------
/*
    * 객체접근권한 (객체권한)
    
    특정 객체들을 조작할 수 있는 권한
    (즉, DML 구문들을 실행할 수 있는 권한)
    SELECT, INSERT, UPDATE, DELETE 가 가능해짐
    
    [ 표현법 ]
    GRANT 권한종류 ON 특정객체 TO 계정명;
    
    권한종류     |   특정객체
    -----------------------------------
    SELECT      | TABLE, VIEW, SEQUENCE
    INSERT      | TABLE, VIEW
    UPDATE      | TABLE, VIEW
    DELETE      | TABLE, VIEW
    
    예) 특정 XXX 테이블에 SELECT 할 수 있는 권한만 부여
    GRANT SELECT ON 테이블명 TO 계정명;
    
*/

-- 5. SAMPLE 계정에
-- KH.EMPLOYEE 테이블을 조회할 수 있는 권한 부여
GRANT SELECT ON KH.EMPLOYEE TO SAMPLE;

-- 6. SAMPLE 계정에
-- KH.DEPARTMENT 테이블에 행을 삽입할 수 있는
-- 권한 부여
GRANT INSERT ON KH.DEPARTMENT TO SAMPLE;

-------------------------------------------------------

-- 우리는 그동안 최소한 권한을 부여하고자 할 때
-- CONNET, RESOURCE 만 부여했었음!!
-- GRANT CONNECT , RESOURCE TO 계정명;

/*
    < 롤 ROLE >
    
    "특정 권한들" 을 하나의 "집합" 으로 묶어놓은 것
    
    CONNECT : CREATE SESSION 
                (데이터베이스에 접속할 수 있는 권한)
    RESOURCE : CREATE TABLE, CREATE SEQUENCE, ..
                (특정 객체들을 생성 및 관리할 수 있는 권한)
*/

-- 데이터 딕셔너리 (ROLE_SYS_PRIVS) 를 통해
-- 어떤 롤이 있고, 
-- 어떤 롤에 어떤 권한들이 묶여있는지 확인 가능
SELECT *
FROM ROLE_SYS_PRIVS
WHERE ROLE IN ('CONNECT','RESOURCE');

-----------------------------------------------------------

/*
    * 권한 회수 (REVOKE)
    
    권한을 회수할 때 (뺏을 때) 사용하는 명령어
    
    [ 표현법 ]
    
    REVOKE 권한명1, 권한명2, ... FROM 계정명;
    
    
    
    
*/

-- 7. SAMPLE 계정에서 테이블을 생성할 수 없도록 권한 회수
REVOKE CREATE TABLE FROM SAMPLE;







