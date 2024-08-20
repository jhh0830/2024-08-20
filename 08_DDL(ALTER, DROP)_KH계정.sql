/*
    < DDL >
    DATA DEFINTION LANGUAGE
    데이터 정의 언어
    
    객체들은 새로이 생성 (CREATE), 수정 (ALTER), 삭제(DROP)
    하는 구문들
    
    => UPDATE : 데이터 "내용" 을 수정
       DELETE : 데이터 "내용" 을 삭제
    => ALTER : 테이블 "구조" 를 수정
       DROP : 테이블 "구조" 를 삭제
       
*/


/*
    1. ALTER
    객체 구조를 수정하는 구문
    
    < 테이블 수정 >
    ALTER TABLE 테이블명 수정할내용;
    
    - 수정할내용
    1) 컬럼 추가 / 수정 / 삭제 
    2) 제약조건 추가 / 삭제  => 수정은 불가
                             수정하고자 한다면 삭제 후 새로이 추가
    3) 테이블명 / 컬럼명 / 제약조건명 변경
    
*/

-- 1) 컬럼 추가 / 수정 / 삭제
-- 1_1) 컬럼 추가 (ADD) 
-- ADD 추가할컬럼명 데이터 타입 DEFAULT 기본값
-- => DEFAULT 기본값은 생략 가능

SELECT * FROM DEPT_COPY;

-- CNAME 컬럼 추가
ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20);
SELECT * FROM DEPT_COPY;
--> 새로운 컬럼이 만들어지고 기본적으로 NULL 값으로 채워짐

-- LANME 컬럼 추가 DEFAULT 지정해서
ALTER TABLE DEPT_COPY ADD LNAME VARCHAR2(20) DEFAULT '한국';

SELECT * FROM DEPT_COPY;
--> 새로운 컬럼이 만들어지고 NULL 이 아닌 DEFUALT 값으로 채워짐

-- 1_2) 컬럼 수정 (MODIFY)
-- 데이터타입 수정 : MODIFY 수정할컬럼명 바꿀데이터타입
-- DEFAULT 값 수정 : MODIFY 수정할컬럼명 DEFAULT 바꾸고자하는기본값

-- DEPT_COPY 테이블의
-- DEPT_ID 컬럼의 데이터타입을 CHAR(3) 로 변경
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);

-- 자료형 변경 시 주의사항
-- 현재 변경하고자 하는 컬럼에 이미 담겨있는 값과
-- 완전 다른 타입으로는 변경 불가하다!!
-- 예) 문자 -> 숫자 (X) / 문자열의 사이즈 축소 (X)
--   문자열 사이즈 확대 (O)

-- ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER;
-- ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(10);

-- DEPT_TITLE 컬럼의 데이터타입을 VARCHAR2(40) 으로
-- LOCATION_ID 컬럼의 데이터타입을 VARCHAR2(2) 로 변경
ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(40)
                      MODIFY LOCATION_ID VARCHAR2(2);
                      
--> 한 테이블의 변경 내용이 여러개라면
-- 위와 같이 줄줄이 연이어서 기술 가능함!!

-- LNAME 컬럼의 기본값을 '미국' 으로 변경
ALTER TABLE DEPT_COPY MODIFY LNAME DEFAULT '미국';

SELECT * FROM DEPT_COPY;
--> DEFAULT 설정값이 수정되었더라도
-- 실제 들어있던 데이터 값까지 변경되지는 않음!!

-- 1_3) 컬럼 삭제 (DROP COLUMN)
-- DROP COLUMN 삭제할컬럼명
CREATE TABLE DEPT_COPY2
AS (SELECT * 
    FROM DEPT_COPY);

SELECT * FROM DEPT_COPY2;

-- DEPT_COPY2 테이블의 DEPT_ID 컬럼 지우기
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;

SELECT * FROM DEPT_COPY2;
ROLLBACK;
SELECT * FROM DEPT_COPY2;
--> DDL 구문은 복구 불가능

-- 모든 컬럼을 없애보자
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;
ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID;

SELECT * FROM  DEPT_COPY2;

ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME;
--> 마지막 컬럼 삭제만 오류
-- 테이블에 최소 한개의 컬럼은 적어도 존재해야함!!

-- 2) 제약조건 추가 / 삭제

/*
    2_1) 제약조건 추가 (ADD)
    
    - PRIMARY KEY :
        ADD PRIMARY KEY(컬럼명)
    - FOREIGN KEY :
        ADD FOREIGN KEY(컬럼명) REFERENCES 참조할테이블명(참조할컬럼명)
    - UNIQUE :
        ADD UNIQUE(컬럼명)
    - CHECK :
        ADD CHECK(컬럼에대한조건식)
    - NOT NULL : 
        MODIFY 컬럼명 NOT NULL;
        
    => 나만의 제약조건명을 부여하고자 한다면
       제약조건 앞에 CONSTRAINT 제약조건명을 기술하면 됨!!
    => 현재 계정 내에 있는 고유한 제약조건명으로 기술해야함!!
    => 이미 해당 컬럼에 들어있는 값에 대해서 알맞는 제약조건으로
       추가해야 함!!
*/


-- DEPT_COPY 테이블에
-- DEPT_ID 컬럼에 PRIMARY KEY 제약조건 추가
-- DEPT_TITLE 컬럼에 UNIQUE 제약조건 추가
-- LNAME 컬럼에 NOT NULL 제약조건 추가
ALTER TABLE DEPT_COPY ADD CONSTRAINT DCOPY_PK PRIMARY KEY(DEPT_ID)
                      ADD CONSTRAINT DCOPY_UQ UNIQUE(DEPT_TITLE)
                      MODIFY LNAME CONSTRAINT DCOPY_NN  NOT NULL;

-- 주의사항
-- 제약조건명은 한 계정 내에서 중복 불가!!
ALTER TABLE DEPARTMENT ADD CONSTRAINT DCOPY_UQ UNIQUE(DEPT_TITLE);
--> 아무리 다른 테이블이더라도 안됨!!

-- 이미 해당 컬럼에 들어있는 값 기준으로 제약조건을 추가해야함
ALTER TABLE DEPT_COPY
MODIFY CNAME NOT NULL;
--> 이미 CNAME 컬럼에 NULL 값이 들어있기 때문에
-- NOT NULL 제약조건 추가 불가!!

/*
    2_2) 제약조건 삭제 (DROP CONSTRAINT)
    
    PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK :
    DROP CONSTRAINT 제약조건명
    
    - NOT NULL :
    MODIFY 컬럼명 NULL 
*/


-- DCOPY_PK 제약조건 삭제
ALTER TABLE DEPT_COPY DROP CONSTRAINT DCOPY_PK;

-- DEPT_COPY 테이블로 부터
-- DCOPY_UQ 제약조건 삭제
-- DCOPY_NN 제약조건 삭제 (LNAME)
ALTER TABLE DEPT_COPY DROP CONSTRAINT DCOPY_UQ
                      MODIFY LNAME NULL;
-- NOT NULL 제약조건의 경우
-- 제약조건명이 있을 경우에는 DROP CONSTRAINT 가능
ALTER TABLE DEPT_COPY DROP CONSTRAINT SYS_C007169;


--- 3) 컬럼명 / 제약조건명 / 테이블명 변경 (RENAME)
-- 3_1) 컬럼명 변경
-- RENAME COLUMN 기존컬럼명 TO 바꿀컬럼명
ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

-- 주의사항
ALTER TABLE DEPT_COPY
RENAME COLUMN LNAME TO CNAME;
--> 한 테이블 내에서는 중복된 컬럼명으로 수정 불가!!

-- 3_2) 제약조건명 변경
-- RENAME CONSTRAINT 기존제약조건명 TO 바꿀제약조건명
ALTER TABLE DEPT_COPY
RENAME CONSTRAINT SYS_C007168 TO DCOPY_DID_NN;
-- 이 계정에 이미 존재하는 제약조건명으로는 수정 불가!!

-- 3_3) 테이블명 변경
-- RENAME TO 바꿀테이블명
-- (이미 앞에 ALTER TABLE 테이블명이 기술되었기 때문)
ALTER TABLE DEPT_COPY RENAME TO DEPT_TEST;
--> 이 계정에 이미 존재하는 테이블명으로 변경 불가!!

SELECT * FROM DEPT_COPY;
SELECT * FROM DEPT_TEST;

----------------------------------------------------------------------

/*
    2. DROP 
    
    객체를 삭제하는 구문
    
    - 테이블을 삭제하고 싶다면?
    DROP TABLE 테이블명;
    
    - 계정을 삭제하고 싶다면?
    DROP USER 계정명;
    
    ...
    
*/

-- DEPT_TEST 테이블 삭제
DROP TABLE DEPT_TEST;


SELECT * FROM DEPT_TEST;

-- DELETE FROM 테이블명; 과의 차이점
--> 테이블 구조는 내비 두고 안의 데이터만 날려버리겠다.
-- SELECT 문으로 조회 가능 (단, 공집합으로 나옴)
--> 테이블 구조 자체를 날려버리겠다.
-- SELECT 문으로 조회 불가 (TABLE OR VIEW DOES NOT EXIST)

-- DROP TABLE 시 주의사항
-- 어딘가에서 참조되고있는 "부모테이블"은 삭제되지 않는다.
-- 만약에 삭제하고 싶다면
-- 1. 자식테이블을 먼저 삭제한 후 부모테이블을 삭제하는 방법
-- DROP TABLE 자식테이블명;
-- DROP TABLE 부모테이블명;

--> 참고)
-- 항상 CREATE 시에는 부모테이블을 먼저 생성해야함!!

-- 2. 부모테이블만 삭제하되, 맞물려있는 제약조건을 같이 삭제하는 방법
-- (자식테이블 및 데이터는 살아있을것)
-- DROP TABLE 부모테이블명 CASCADE CONSTRAINT;


-------------------------------------------------------------------------------




