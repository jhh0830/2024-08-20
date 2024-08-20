/*
    < DML >
    DATA MANIPULATION LAGUAGE
    데이터 조작 언어
    
    테이블에 새로운 데이터를 삽입 (INSERT) 하거나,
    기존의 데이터를 수정 (UPDATE) 하거나,
    기존의 데이터를 삭제 (DELETE) 하는 구문
    
    => 데이터 조회용 구문인 SELECT 문도 DML임!!!
    
    => SELECT 문과의 차이점이라고 한다면
       SELECT 문은 100번, 1000번 실행하더라도 테이블 내용의 변화 X
       (단순 조회용이기 때문)
       INSERT, UPDATE, DELETE 구문은 1번만 실행해도
       테이블 내용의 변화 O
      EX) 실행후 CONSOLE 창에  1행이 삭제 수정 삽입... 이런 문구로 변화가 일어남 
*/

/*
    1. INSERT
    테이블에 새로운 "행" 을 추가하는 구문
    
    [ 표현법 ]
    1) INSERT INTO 테이블명 VALUES(값1, 값2, 값3, ....);
    => 해당 테이블의 모든 컬럼에 대해서 추가하고자 하는 값을
       내가 직접 제시해서 "한 행" 으로 INSERT 하고자 할 때 사용
       주의할점 : 컬럼 순번을 지켜서 VALUES 괄호 안에 값을 나열해야함!!
                 해당 테이블의 컬럼 갯수를 맞춰서 값을 나열해야함!!
       - 부족하게 값을 제시했을 경우 : NOT ENOUGH VALUES 오류
       - 값을 더 많이 제시했을 경우 : TOO MANY VALUES 오류
       
    
*/

-- EMPLOYEE 테이블에 사원정보를 추가
-- 한예원 사원의 정보를 추가해보기
INSERT INTO EMPLOYEE VALUES(223
                          , '한예원'
                          , '981008-2111111'
                          , 'user01@kh.or.kr'
                          , '01012345678'
                          , 'D3'
                          , 'J1'
                          , 'S1'
                          , 7000000
                          , 0.1
                          , NULL
                          , SYSDATE
                          , NULL
                          , 'N');

SELECT * FROM EMPLOYEE;

-- 깁갑생사원 정보 추가하기

INSERT INTO EMPLOYEE VALUES(900
                          , '깁갑생'
                          , '901212-1234567'
                          , 'user02@kh.or.kr'
                          , '01044443333'
                          , 'D1'
                          , 'J7'
                          , 'S3'
                          , 4000000
                          , 0.2
                          , 200
                          , SYSDATE
                          , NULL
                          , DEFAULT);

--> DEFAULT 설정이 되어있는 컬럼에 기본값을 INSERT 하고싶다면
--INSERT 구문 안쪽에 해당 컬럼값 자리에 DFAULT 키워드를 쓰자

SELECT * FROM EMPLOYEE
WHERE EMP_ID = 900;

-- 주의사항 : 컬럼 갯수 정확하게 맞추기!!
INSERT INTO EMPLOYEE VALUES(901
                          , '고길동');

--> 값을 적게 제시하면 SQL 오류: ORA-00947: not enough values

INSERT INTO EMPLOYEE VALUES(901
                          , '깁갑생'
                          , '901212-1234567'
                          , 'user02@kh.or.kr'
                          , '01044443333'
                          , 'D1'
                          , 'J7'
                          , 'S3'
                          , 4000000
                          , 0.2
                          , 200
                          , SYSDATE
                          , NULL
                          , DEFAULT
                          , 1);
--> 값을 오버해서 제시하면 SQL 오류: ORA-00913: too many values

--------------------------------------------------------------

/*
    2) INSERT INTO 테이블명(컬럼명1, 컬럼명2, 컬럼명3)
                    VALUES(값1,값2,값3);
    => 해당 테이블에 특정 컬럼만 선택해서
       그 컬럼에 추가할 값만 제시하고자 할 때 사용
       그래도 한 행 단위로 추가되기 때문에
       선택이 안된 컬럼은 기본적으로 NULL 값이 들어감!!
       단, DEFAULT 이 지정되어있는 경우는 기본값이 들어감!!
       주의할점 : NOT NULL 제약조건이 걸려있는 컬럼은
                 반드시 선택해서 직접 값을 제시해야함
                단, 아무리 NOT NULL 제약조건이 걸려있는
                컬럼이라고 해도 DEFAULT 설정이 되어있는 컬럼은
                선택 안해도 됨!!
                
       
*/


-- 901 김말똥 사원 정보 추가
INSERT INTO EMPLOYEE(EMP_ID
                   , EMP_NAME
                   , EMP_NO
                   , DEPT_CODE
                   , JOB_CODE
                   , SAL_LEVEL
                   , HIRE_DATE)
                VALUES(901
                     , '김말똥'
                     , '880123-1111111'
                     , 'D1'
                     , 'J2'
                     , 'S1'
                     , SYSDATE);
                     
SELECT * FROM EMPLOYEE;
----------------------------------------------------------
/*
    3) INSERT INTO 테이블명 (서브쿼리);
    => VALUES 로 값을 직접 기입하는것 대신에
       서브쿼리로 조회한 결과값을 "통째로" INSERT 하는 구문
       (여러행을 한번에 INSERT 시킬 수 있다)
       
*/

-- 새로운 테이블 먼저 만들기
DROP TABLE EMP_01;
CREATE TABLE EMP_01 (
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(20)

);

SELECT * FROM EMP_01;


-- 전체 사원들의 사번, 이름, 부서명을 조회한 결과를
-- EMP_01 테이블에 "통째로" 추가
INSERT INTO EMP_01 
(
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE
        FROM EMPLOYEE, DEPARTMENT
        WHERE DEPT_CODE = DEPT_ID(+)
);

SELECT * FROM EMP_01; 
--------------------------------------------------------------------
/*
    2. INSERT ALL
    
    
    한번에 두개 이상의 테이블에 각각 INSERT 할 때 사용
    그 때 사용되는 서브쿼리가 동일한 경우 사용한다!!
        
*/

-- 새로운 테이블 먼저 생성하기
-- 첫번째 테이블 : 급여가 300만원 이상인 사원들의
--               사번, 사원명, 직급명 대해 보관할 테이블
CREATE TABLE EMP_JOB (
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    JOB_NAME VARCHAR2(20)
);

-- 두번째 테이블 : 급여가 300만원 이상인 사원들의
--               사번, 사원명, 부서명에 대해 보관할 테이블
CREATE TABLE EMP_DEPT (
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(20)
);

SELECT * FROM EMP_JOB;
SELECT * FROM EMP_DEPT;

-- 급여가 300만원 이상인 사원들의 사번, 이름, 직급명, 부서명 조회
SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE
 FROM EMPLOYEE E
 JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
 JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE SALARY >= 3000000;

/*
    1) INSERT ALL
       INTO 테이블명1 VALUES(컬럼명1, 컬럼명 2, ....)
       INTO 테이블명2 VALUES(컬럼명1, 컬럼명 2, ....)
       INTO 테이블명3 VALUES(컬럼명1, 컬럼명 2, ....)
       .
       .
       (서브쿼리); << ()가 필요하지는 않는데 가독성때문에 붙여줌
        
*/
-- 서브쿼리 조회 결과로부터
-- EMP_JOB 테이블에는 급여가 300만원 이상인 사원들의
-- EMP_ID, EMP_NAME, JOB_NAME 을 삽입
-- EMP_DEPT 테이블에는급여가 300만원 이상인 사원들의
-- EMP_ID, EMP_NAME, DEPT_TITLE 을 삽입
INSERT ALL
INTO EMP_JOB VALUES(EMP_ID, EMP_NAME,JOB_NAME) -- 10개
INTO EMP_DEPT VALUES(EMP_ID,EMP_NAME,DEPT_TITLE) -- 10개
(
    SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE
    FROM EMPLOYEE E
    JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
    JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
    WHERE SALARY >= 3000000
);
--> 서브쿼리 실행 결과 10행 조회
-- 각각 EMP_JOB, EMP_DEPT 테이블에 각각 10행씩 INSERT
-- 총 20개 의 행이 INSERT 되는 상황!!


SELECT * FROM EMP_JOB;
SELECT * FROM EMP_DEPT;

-- INSERT ALL 시 조건을 사용해서 각 테이블에 값 INSERT 가능
-- 사번, 사원명, 입사일, 급여를 저장할 수 있는 테이블 생성
-- 첫번째 테이블 : 2010년 이전에 입사한 사원들 정보만 저장
-- (EMP_OLD)
CREATE TABLE EMP_OLD
AS (SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
     FROM EMPLOYEE
    WHERE 1 = 0);

-- 두번째 테이블 : 2010년 이후에 입사한 사원들 정보만 저장
-- (EMP_NEW)
CREATE TABLE EMP_NEW
AS (SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
     FROM EMPLOYEE
    WHERE 1 = 0);
    
SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;
-- 2010년도 이전 입사자들 정보 조회
-- 2010년도 이후 입사자즐 정보 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
FROM EMPLOYEE
--WHERE HIRE_DATE < '2010/01/01'; -- 2010 년 이전 9명 입사자들
WHERE HIRE_DATE >= '2010/01/01'; -- 2010년 이후 17명 입사자들
-------------------------------------------------------------
/*
    2) INSERT ALL
    WHEN 조건식 1 THEN
                 INTO 테이블명1 VALUES(컬럼명1,컬럼명2,....)
    WHEN 조건식 2 THEN
                 INTO 테이블명2 VALUES(컬럼명1,컬럼명2,....)
    (서브쿼리);
*/

INSERT ALL 
WHEN HIRE_DATE < '2010/01/01' THEN -- 9개행 INSERT
            INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
WHEN HIRE_DATE >= '2010/01/01' THEN -- 17개행 INSERT
            INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
(
    SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
);
--> 총 26개 행 INSERT 

SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;

--> 항상 INSERT 구문 실행 성공 시
-- "N개 행 이(가) 삽입되었습니다." 문구가 나옴!!
-----------------------------------------------------------

/*
    3. UPDATE
    테이블에 이미 기록된 기존의 데이터를 "수정" 하는 구문
    (테이블의 내용은 변화하지만 행의 갯수는 변하지 않음)
    
    [ 표현법 ]
    UPDATE 테이블명
        SET 컬럼명 = 바꿀값
          , 컬럼명 = 바꿀값
          , 컬럼명 = 바꿀값
          ..... => 여러개의 컬럼값 동시변경 가능
                 (=은 대입연산, ,로 나열해야함 AND 아님)
    WHERE 조건식;        => WHERE 절은 생략 가능 (가급적 생략안하는게 좋음)
                           WHERE 절을 생략 했을 경우
                           해당 테이블의 전체 행의 데이터가 다 변경됨!!

    
    
*/

-- 테스트용 복사본 테이블 생성
CREATE TABLE DEPT_COPY
AS ( SELECT *
        FROM DEPARTMENT);
SELECT * FROM DEPT_COPY;

-- DEPT_COPY 테이블의 D9 부서의 부서명
-- '총무부' --> '전략기획팀' 으로 변경
UPDATE DEPT_COPY
SET DEPT_TITLE = '전략기획팀' -- 대입연산자
WHERE DEPT_ID = 'D9';-- 동등비교연산자

SELECT * FROM DEPT_COPY;

-- 데이터 변경사항 픽스
COMMIT;
-- DEPT_COPY 테이블의 D7 부서의 부서명을
-- '해외영업3부' --> '교육부'로 변경
UPDATE DEPT_COPY
SET DEPT_TITLE = '교육부';
SELECT * FROM DEPT_COPY;
--> 실수라도 WHERE 절을 생략하게 되면
-- 해당 테이블의 전체 행에 대한 해당 컬럼값들이
-- 일괄적으로 모두 변경됨!! (신중하게 하자)

ROLLBACK;

SELECT * FROM DEPT_COPY;

-- 복사본 테이블
CREATE TABLE EMP_SALARY
AS (SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS 
        FROM EMPLOYEE);
SELECT * FROM EMP_SALARY;

-- EMP_SALARY 테이블의 김가현 사원의 급여를 1000만원으로 수정
UPDATE EMP_SALARY
SET SALARY = 10000000
WHERE EMP_NAME = '김가현';
SELECT * FROM EMP_SALARY;
--> 마침 김가현이라는 이름을 가진 사원은 한명이어서
-- 1개 행만 업데이트  됨
-- 하지만 동명이인이 몇명 더 있었다면 그만큼 더 수정됬을것임!!

-- EMP_SALARY 테이블의
-- 최진호 사원의 급여를 700만원, 보너스를 0.2로 변경
UPDATE EMP_SALARY
SET SALARY = 7000000 ,BONUS = 0.2
WHERE EMP_NAME ='최진호';
SELECT * FROM EMP_SALARY;

-- EMP_SALARY 테이블의
-- 전체 사원의 급여를 기존의 급여에 20프로 인상한 급액으로 변경
-- 기존급여 * 1.2
UPDATE EMP_SALARY
SET SALARY = (SALARY * 1.2) -- SALARY *= 1.2 안됨!!
WHERE 1=1;
SELECT * FROM EMP_SALARY;
-- WHERE 절에 항상 TURE 인 조건식을 제시해도
-- 모든 행이 다 변경!!

--> 주로 UPDATE 시 한놈만 정확하게 바꾸려면
-- WHERE 절에 PRIMARY KEY 에 대한 조건을 제시하는 것이 확실하다

/*
    * UPDATE 문 안에서도 서브쿼리를 이용 가능하다.
    
    UPDATE 테이블명
       SET 컬럼명 = (서브쿼리)
    WHERE 조건식;
    
*/


-- EMP_SALARY 테이블
-- 김말똥 사원의 부서코드를 김가현 사원의 부서코드로 변경
-- 1) 먼저 김가현 사원의 부서코드를 알아내야함
SELECT DEPT_CODE
FROM EMP_SALARY
WHERE EMP_NAME= '김가현'; -- 'D9'
-- 2) 김말똥 사원의 부서코드를 D9로 변경
UPDATE EMP_SALARY
SET DEPT_CODE = (SELECT DEPT_CODE
FROM EMP_SALARY
WHERE EMP_NAME= '김가현')
WHERE EMP_NAME = '김말똥';
SELECT * FROM EMP_SALARY;

-- 이유민 사원의 급여와 보너스를
-- 권가영 사원으 급여와 보너스값으로 변경
--1) 먼저 권가영 사원의 급여와 보너스를 구하기
SELECT SALARY, BONUS
FROM EMP_SALARY
WHERE EMP_NAME = '권가영';

UPDATE EMP_SALARY
SET SALARY = (SELECT SALARY
FROM EMP_SALARY
WHERE EMP_NAME = '권가영')
, BONUS =( SELECT BONUS
FROM EMP_SALARY
WHERE EMP_NAME = '권가영')
WHERE EMP_NAME = '이유민';


--> 단일행 단일열 서브쿼리 버전
UPDATE EMP_SALARY
SET (SALARY, BONUS )= (SELECT SALARY, BONUS
FROM EMP_SALARY
WHERE EMP_NAME = '권가영')
WHERE EMP_NAME = '이유민';
SELECT * FROM EMP_SALARY;
--> 단일행 다중열 서브쿼리 버전

-- UPDATE 시 주의사항
--> 변경할 값에 있어서도 해당 컬럼에 대한 제약조거늘 위배하면 안됨

-- 이수경 사원의 사번을 200 으로 변경
SELECT * FROM EMPLOYEE;

UPDATE EMPLOYEE
SET EMP_ID = 200
WHERE EMP_NAME = '이수경';
--> PRIMARY KEY 제약조건에 위배

-- 사번이 200번인 사원의 이름을 NULL 로 변경
UPDATE EMPLOYEE
SET EMP_NAME =NULL
WHERE EMP_ID=200;
--> NOT NULL 제약조건 위배

COMMIT; -- 모든 변경사항들을 확정

--------------------------------------------------------------

/*
    4. DELETE
    테이블에 기록된 기존의 데이터를 "삭제" 하는 구문
    
    [ 표현법 ]
    DELETE 
     FROM 테이블명
     WHERE 조건식; => WHERE 절은 생략 가능
                     단, 생략 시 해당 테이블의 모든 행이 다 지워짐
                     
*/

DELETE 
    FROM EMPLOYEE;
--> WHERE 절 생략시 EMPLOYEE 테이블의 전체 행 모두 삭제

ROLLBACK;

SELECT * FROM EMPLOYEE;

-- EMPLOYEE 테이블로부터
-- 김갑생과 김말똥 직원의 데이터를 지우기
DELETE 
 FROM EMPLOYEE
WHERE EMP_NAME IN ('김갑생','김말똥');
DELETE 
 FROM EMPLOYEE
WHERE EMP_NAME = '깁갑생';

SELECT * FROM EMPLOYEE;

COMMIT;

-- DEPARTMENT 테이블로부터 DEPT_ID 가 D1 인 부서 삭제
DELETE
FROM DEPARTMENT
WHERE DEPT_ID = 'D1';
--> 삭제 안됨 (D1 을 가져다 쓰고 있는 자식데이터가 있기 때문)

-- DEPARTMENT 테이블로부터 DEPT_ID 가 D7 인 부서 삭제
DELETE
FROM DEPARTMENT
WHERE DEPT_ID = 'D7';
--> 삭제됨 (D7 를 가져다 쓰고 있는 자식데이터가 없기 때문에)

--> 삭제 구문 실행 시 "외래키" 제약조건을 생각해봐야함!!

ROLLBACK;

--> 항상 UPDATE 구문 실행 성공 시
-- "N 행 이(가) 업데이트되었습니다." 결과 나옴

--> 항상 DELETE 구문 실행 성공 시
-- "N개 행 이(가) 삭제되었습니다." 결과 나옴

--> UPDATE, DELETE 구문은 WHERE 절을 어떻게 작성하냐에 따라
-- 처리되는 행의 갯수가 매번 다르게 나옴!!

--> SELECT 문의 실행 결과 : RESULT SET
--> INSERT / UPDATE / DELETE 문의 실행 결과 :
-- : 각각 추가 / 수정 / 삭제된 행의 갯수가 "정수" 로 나옴

--------------------------------------------------------------

/*
    * TRUNCATE 
    
    
    테이블의 "전체 행" 을 삭제할 때 쓸 수 있는 구문 (절삭, 잘라내다)
    WHERE 절을 통해 별도의 조건식 제시 불가,
    DELETE 보다 수행속도도 빠름
    ROLLBACK 이 불가함!! (DDL 로 분류)
    
    [ 표현법 ]
    TRUNCATE TABLE 테이블명;   |  DELETE FROM 테이블명;
    ---------------------------------------------------
    별도의 조건 제시 불가        |  별도의 조건 제시가능
    수행속도 빠름               |  수행속도 느림
    ROLLBACK 불가              |   ROLLBACK 가능
*/

SELECT * FROM EMP_SALARY;
DELETE FROM EMP_SALARY;
SELECT * FROM EMP_SALARY;
ROLLBACK;
SELECT * FROM EMP_SALARY;

TRUNCATE TABLE EMP_SALARY;
--> 테이블이 잘렷습니다.

SELECT * FROM EMP_SALARY;
ROLLBACK;
SELECT * FROM EMP_SALARY;























