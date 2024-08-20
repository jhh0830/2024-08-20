/*
    < DML >
    DATA MANIPULATION LAGUAGE
    ������ ���� ���
    
    ���̺� ���ο� �����͸� ���� (INSERT) �ϰų�,
    ������ �����͸� ���� (UPDATE) �ϰų�,
    ������ �����͸� ���� (DELETE) �ϴ� ����
    
    => ������ ��ȸ�� ������ SELECT ���� DML��!!!
    
    => SELECT ������ �������̶�� �Ѵٸ�
       SELECT ���� 100��, 1000�� �����ϴ��� ���̺� ������ ��ȭ X
       (�ܼ� ��ȸ���̱� ����)
       INSERT, UPDATE, DELETE ������ 1���� �����ص�
       ���̺� ������ ��ȭ O
      EX) ������ CONSOLE â��  1���� ���� ���� ����... �̷� ������ ��ȭ�� �Ͼ 
*/

/*
    1. INSERT
    ���̺� ���ο� "��" �� �߰��ϴ� ����
    
    [ ǥ���� ]
    1) INSERT INTO ���̺�� VALUES(��1, ��2, ��3, ....);
    => �ش� ���̺��� ��� �÷��� ���ؼ� �߰��ϰ��� �ϴ� ����
       ���� ���� �����ؼ� "�� ��" ���� INSERT �ϰ��� �� �� ���
       �������� : �÷� ������ ���Ѽ� VALUES ��ȣ �ȿ� ���� �����ؾ���!!
                 �ش� ���̺��� �÷� ������ ���缭 ���� �����ؾ���!!
       - �����ϰ� ���� �������� ��� : NOT ENOUGH VALUES ����
       - ���� �� ���� �������� ��� : TOO MANY VALUES ����
       
    
*/

-- EMPLOYEE ���̺� ��������� �߰�
-- �ѿ��� ����� ������ �߰��غ���
INSERT INTO EMPLOYEE VALUES(223
                          , '�ѿ���'
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

-- �鰩����� ���� �߰��ϱ�

INSERT INTO EMPLOYEE VALUES(900
                          , '�鰩��'
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

--> DEFAULT ������ �Ǿ��ִ� �÷��� �⺻���� INSERT �ϰ�ʹٸ�
--INSERT ���� ���ʿ� �ش� �÷��� �ڸ��� DFAULT Ű���带 ����

SELECT * FROM EMPLOYEE
WHERE EMP_ID = 900;

-- ���ǻ��� : �÷� ���� ��Ȯ�ϰ� ���߱�!!
INSERT INTO EMPLOYEE VALUES(901
                          , '��浿');

--> ���� ���� �����ϸ� SQL ����: ORA-00947: not enough values

INSERT INTO EMPLOYEE VALUES(901
                          , '�鰩��'
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
--> ���� �����ؼ� �����ϸ� SQL ����: ORA-00913: too many values

--------------------------------------------------------------

/*
    2) INSERT INTO ���̺��(�÷���1, �÷���2, �÷���3)
                    VALUES(��1,��2,��3);
    => �ش� ���̺� Ư�� �÷��� �����ؼ�
       �� �÷��� �߰��� ���� �����ϰ��� �� �� ���
       �׷��� �� �� ������ �߰��Ǳ� ������
       ������ �ȵ� �÷��� �⺻������ NULL ���� ��!!
       ��, DEFAULT �� �����Ǿ��ִ� ���� �⺻���� ��!!
       �������� : NOT NULL ���������� �ɷ��ִ� �÷���
                 �ݵ�� �����ؼ� ���� ���� �����ؾ���
                ��, �ƹ��� NOT NULL ���������� �ɷ��ִ�
                �÷��̶�� �ص� DEFAULT ������ �Ǿ��ִ� �÷���
                ���� ���ص� ��!!
                
       
*/


-- 901 �踻�� ��� ���� �߰�
INSERT INTO EMPLOYEE(EMP_ID
                   , EMP_NAME
                   , EMP_NO
                   , DEPT_CODE
                   , JOB_CODE
                   , SAL_LEVEL
                   , HIRE_DATE)
                VALUES(901
                     , '�踻��'
                     , '880123-1111111'
                     , 'D1'
                     , 'J2'
                     , 'S1'
                     , SYSDATE);
                     
SELECT * FROM EMPLOYEE;
----------------------------------------------------------
/*
    3) INSERT INTO ���̺�� (��������);
    => VALUES �� ���� ���� �����ϴ°� ��ſ�
       ���������� ��ȸ�� ������� "��°��" INSERT �ϴ� ����
       (�������� �ѹ��� INSERT ��ų �� �ִ�)
       
*/

-- ���ο� ���̺� ���� �����
DROP TABLE EMP_01;
CREATE TABLE EMP_01 (
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(20)

);

SELECT * FROM EMP_01;


-- ��ü ������� ���, �̸�, �μ����� ��ȸ�� �����
-- EMP_01 ���̺� "��°��" �߰�
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
    
    
    �ѹ��� �ΰ� �̻��� ���̺� ���� INSERT �� �� ���
    �� �� ���Ǵ� ���������� ������ ��� ����Ѵ�!!
        
*/

-- ���ο� ���̺� ���� �����ϱ�
-- ù��° ���̺� : �޿��� 300���� �̻��� �������
--               ���, �����, ���޸� ���� ������ ���̺�
CREATE TABLE EMP_JOB (
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    JOB_NAME VARCHAR2(20)
);

-- �ι�° ���̺� : �޿��� 300���� �̻��� �������
--               ���, �����, �μ��� ���� ������ ���̺�
CREATE TABLE EMP_DEPT (
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(20)
);

SELECT * FROM EMP_JOB;
SELECT * FROM EMP_DEPT;

-- �޿��� 300���� �̻��� ������� ���, �̸�, ���޸�, �μ��� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE
 FROM EMPLOYEE E
 JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
 JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE SALARY >= 3000000;

/*
    1) INSERT ALL
       INTO ���̺��1 VALUES(�÷���1, �÷��� 2, ....)
       INTO ���̺��2 VALUES(�÷���1, �÷��� 2, ....)
       INTO ���̺��3 VALUES(�÷���1, �÷��� 2, ....)
       .
       .
       (��������); << ()�� �ʿ������� �ʴµ� ������������ �ٿ���
        
*/
-- �������� ��ȸ ����κ���
-- EMP_JOB ���̺��� �޿��� 300���� �̻��� �������
-- EMP_ID, EMP_NAME, JOB_NAME �� ����
-- EMP_DEPT ���̺��±޿��� 300���� �̻��� �������
-- EMP_ID, EMP_NAME, DEPT_TITLE �� ����
INSERT ALL
INTO EMP_JOB VALUES(EMP_ID, EMP_NAME,JOB_NAME) -- 10��
INTO EMP_DEPT VALUES(EMP_ID,EMP_NAME,DEPT_TITLE) -- 10��
(
    SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE
    FROM EMPLOYEE E
    JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
    JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
    WHERE SALARY >= 3000000
);
--> �������� ���� ��� 10�� ��ȸ
-- ���� EMP_JOB, EMP_DEPT ���̺� ���� 10�྿ INSERT
-- �� 20�� �� ���� INSERT �Ǵ� ��Ȳ!!


SELECT * FROM EMP_JOB;
SELECT * FROM EMP_DEPT;

-- INSERT ALL �� ������ ����ؼ� �� ���̺� �� INSERT ����
-- ���, �����, �Ի���, �޿��� ������ �� �ִ� ���̺� ����
-- ù��° ���̺� : 2010�� ������ �Ի��� ����� ������ ����
-- (EMP_OLD)
CREATE TABLE EMP_OLD
AS (SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
     FROM EMPLOYEE
    WHERE 1 = 0);

-- �ι�° ���̺� : 2010�� ���Ŀ� �Ի��� ����� ������ ����
-- (EMP_NEW)
CREATE TABLE EMP_NEW
AS (SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
     FROM EMPLOYEE
    WHERE 1 = 0);
    
SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;
-- 2010�⵵ ���� �Ի��ڵ� ���� ��ȸ
-- 2010�⵵ ���� �Ի����� ���� ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
FROM EMPLOYEE
--WHERE HIRE_DATE < '2010/01/01'; -- 2010 �� ���� 9�� �Ի��ڵ�
WHERE HIRE_DATE >= '2010/01/01'; -- 2010�� ���� 17�� �Ի��ڵ�
-------------------------------------------------------------
/*
    2) INSERT ALL
    WHEN ���ǽ� 1 THEN
                 INTO ���̺��1 VALUES(�÷���1,�÷���2,....)
    WHEN ���ǽ� 2 THEN
                 INTO ���̺��2 VALUES(�÷���1,�÷���2,....)
    (��������);
*/

INSERT ALL 
WHEN HIRE_DATE < '2010/01/01' THEN -- 9���� INSERT
            INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
WHEN HIRE_DATE >= '2010/01/01' THEN -- 17���� INSERT
            INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
(
    SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
);
--> �� 26�� �� INSERT 

SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;

--> �׻� INSERT ���� ���� ���� ��
-- "N�� �� ��(��) ���ԵǾ����ϴ�." ������ ����!!
-----------------------------------------------------------

/*
    3. UPDATE
    ���̺� �̹� ��ϵ� ������ �����͸� "����" �ϴ� ����
    (���̺��� ������ ��ȭ������ ���� ������ ������ ����)
    
    [ ǥ���� ]
    UPDATE ���̺��
        SET �÷��� = �ٲܰ�
          , �÷��� = �ٲܰ�
          , �÷��� = �ٲܰ�
          ..... => �������� �÷��� ���ú��� ����
                 (=�� ���Կ���, ,�� �����ؾ��� AND �ƴ�)
    WHERE ���ǽ�;        => WHERE ���� ���� ���� (������ �������ϴ°� ����)
                           WHERE ���� ���� ���� ���
                           �ش� ���̺��� ��ü ���� �����Ͱ� �� �����!!

    
    
*/

-- �׽�Ʈ�� ���纻 ���̺� ����
CREATE TABLE DEPT_COPY
AS ( SELECT *
        FROM DEPARTMENT);
SELECT * FROM DEPT_COPY;

-- DEPT_COPY ���̺��� D9 �μ��� �μ���
-- '�ѹ���' --> '������ȹ��' ���� ����
UPDATE DEPT_COPY
SET DEPT_TITLE = '������ȹ��' -- ���Կ�����
WHERE DEPT_ID = 'D9';-- ����񱳿�����

SELECT * FROM DEPT_COPY;

-- ������ ������� �Ƚ�
COMMIT;
-- DEPT_COPY ���̺��� D7 �μ��� �μ�����
-- '�ؿܿ���3��' --> '������'�� ����
UPDATE DEPT_COPY
SET DEPT_TITLE = '������';
SELECT * FROM DEPT_COPY;
--> �Ǽ��� WHERE ���� �����ϰ� �Ǹ�
-- �ش� ���̺��� ��ü �࿡ ���� �ش� �÷�������
-- �ϰ������� ��� �����!! (�����ϰ� ����)

ROLLBACK;

SELECT * FROM DEPT_COPY;

-- ���纻 ���̺�
CREATE TABLE EMP_SALARY
AS (SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS 
        FROM EMPLOYEE);
SELECT * FROM EMP_SALARY;

-- EMP_SALARY ���̺��� �谡�� ����� �޿��� 1000�������� ����
UPDATE EMP_SALARY
SET SALARY = 10000000
WHERE EMP_NAME = '�谡��';
SELECT * FROM EMP_SALARY;
--> ��ħ �谡���̶�� �̸��� ���� ����� �Ѹ��̾
-- 1�� �ุ ������Ʈ  ��
-- ������ ���������� ��� �� �־��ٸ� �׸�ŭ �� ������������!!

-- EMP_SALARY ���̺���
-- ����ȣ ����� �޿��� 700����, ���ʽ��� 0.2�� ����
UPDATE EMP_SALARY
SET SALARY = 7000000 ,BONUS = 0.2
WHERE EMP_NAME ='����ȣ';
SELECT * FROM EMP_SALARY;

-- EMP_SALARY ���̺���
-- ��ü ����� �޿��� ������ �޿��� 20���� �λ��� �޾����� ����
-- �����޿� * 1.2
UPDATE EMP_SALARY
SET SALARY = (SALARY * 1.2) -- SALARY *= 1.2 �ȵ�!!
WHERE 1=1;
SELECT * FROM EMP_SALARY;
-- WHERE ���� �׻� TURE �� ���ǽ��� �����ص�
-- ��� ���� �� ����!!

--> �ַ� UPDATE �� �ѳ� ��Ȯ�ϰ� �ٲٷ���
-- WHERE ���� PRIMARY KEY �� ���� ������ �����ϴ� ���� Ȯ���ϴ�

/*
    * UPDATE �� �ȿ����� ���������� �̿� �����ϴ�.
    
    UPDATE ���̺��
       SET �÷��� = (��������)
    WHERE ���ǽ�;
    
*/


-- EMP_SALARY ���̺�
-- �踻�� ����� �μ��ڵ带 �谡�� ����� �μ��ڵ�� ����
-- 1) ���� �谡�� ����� �μ��ڵ带 �˾Ƴ�����
SELECT DEPT_CODE
FROM EMP_SALARY
WHERE EMP_NAME= '�谡��'; -- 'D9'
-- 2) �踻�� ����� �μ��ڵ带 D9�� ����
UPDATE EMP_SALARY
SET DEPT_CODE = (SELECT DEPT_CODE
FROM EMP_SALARY
WHERE EMP_NAME= '�谡��')
WHERE EMP_NAME = '�踻��';
SELECT * FROM EMP_SALARY;

-- ������ ����� �޿��� ���ʽ���
-- �ǰ��� ����� �޿��� ���ʽ������� ����
--1) ���� �ǰ��� ����� �޿��� ���ʽ��� ���ϱ�
SELECT SALARY, BONUS
FROM EMP_SALARY
WHERE EMP_NAME = '�ǰ���';

UPDATE EMP_SALARY
SET SALARY = (SELECT SALARY
FROM EMP_SALARY
WHERE EMP_NAME = '�ǰ���')
, BONUS =( SELECT BONUS
FROM EMP_SALARY
WHERE EMP_NAME = '�ǰ���')
WHERE EMP_NAME = '������';


--> ������ ���Ͽ� �������� ����
UPDATE EMP_SALARY
SET (SALARY, BONUS )= (SELECT SALARY, BONUS
FROM EMP_SALARY
WHERE EMP_NAME = '�ǰ���')
WHERE EMP_NAME = '������';
SELECT * FROM EMP_SALARY;
--> ������ ���߿� �������� ����

-- UPDATE �� ���ǻ���
--> ������ ���� �־�� �ش� �÷��� ���� �������Ŵ� �����ϸ� �ȵ�

-- �̼��� ����� ����� 200 ���� ����
SELECT * FROM EMPLOYEE;

UPDATE EMPLOYEE
SET EMP_ID = 200
WHERE EMP_NAME = '�̼���';
--> PRIMARY KEY �������ǿ� ����

-- ����� 200���� ����� �̸��� NULL �� ����
UPDATE EMPLOYEE
SET EMP_NAME =NULL
WHERE EMP_ID=200;
--> NOT NULL �������� ����

COMMIT; -- ��� ������׵��� Ȯ��

--------------------------------------------------------------

/*
    4. DELETE
    ���̺� ��ϵ� ������ �����͸� "����" �ϴ� ����
    
    [ ǥ���� ]
    DELETE 
     FROM ���̺��
     WHERE ���ǽ�; => WHERE ���� ���� ����
                     ��, ���� �� �ش� ���̺��� ��� ���� �� ������
                     
*/

DELETE 
    FROM EMPLOYEE;
--> WHERE �� ������ EMPLOYEE ���̺��� ��ü �� ��� ����

ROLLBACK;

SELECT * FROM EMPLOYEE;

-- EMPLOYEE ���̺�κ���
-- �谩���� �踻�� ������ �����͸� �����
DELETE 
 FROM EMPLOYEE
WHERE EMP_NAME IN ('�谩��','�踻��');
DELETE 
 FROM EMPLOYEE
WHERE EMP_NAME = '�鰩��';

SELECT * FROM EMPLOYEE;

COMMIT;

-- DEPARTMENT ���̺�κ��� DEPT_ID �� D1 �� �μ� ����
DELETE
FROM DEPARTMENT
WHERE DEPT_ID = 'D1';
--> ���� �ȵ� (D1 �� ������ ���� �ִ� �ڽĵ����Ͱ� �ֱ� ����)

-- DEPARTMENT ���̺�κ��� DEPT_ID �� D7 �� �μ� ����
DELETE
FROM DEPARTMENT
WHERE DEPT_ID = 'D7';
--> ������ (D7 �� ������ ���� �ִ� �ڽĵ����Ͱ� ���� ������)

--> ���� ���� ���� �� "�ܷ�Ű" ���������� �����غ�����!!

ROLLBACK;

--> �׻� UPDATE ���� ���� ���� ��
-- "N �� ��(��) ������Ʈ�Ǿ����ϴ�." ��� ����

--> �׻� DELETE ���� ���� ���� ��
-- "N�� �� ��(��) �����Ǿ����ϴ�." ��� ����

--> UPDATE, DELETE ������ WHERE ���� ��� �ۼ��ϳĿ� ����
-- ó���Ǵ� ���� ������ �Ź� �ٸ��� ����!!

--> SELECT ���� ���� ��� : RESULT SET
--> INSERT / UPDATE / DELETE ���� ���� ��� :
-- : ���� �߰� / ���� / ������ ���� ������ "����" �� ����

--------------------------------------------------------------

/*
    * TRUNCATE 
    
    
    ���̺��� "��ü ��" �� ������ �� �� �� �ִ� ���� (����, �߶󳻴�)
    WHERE ���� ���� ������ ���ǽ� ���� �Ұ�,
    DELETE ���� ����ӵ��� ����
    ROLLBACK �� �Ұ���!! (DDL �� �з�)
    
    [ ǥ���� ]
    TRUNCATE TABLE ���̺��;   |  DELETE FROM ���̺��;
    ---------------------------------------------------
    ������ ���� ���� �Ұ�        |  ������ ���� ���ð���
    ����ӵ� ����               |  ����ӵ� ����
    ROLLBACK �Ұ�              |   ROLLBACK ����
*/

SELECT * FROM EMP_SALARY;
DELETE FROM EMP_SALARY;
SELECT * FROM EMP_SALARY;
ROLLBACK;
SELECT * FROM EMP_SALARY;

TRUNCATE TABLE EMP_SALARY;
--> ���̺��� �߷ǽ��ϴ�.

SELECT * FROM EMP_SALARY;
ROLLBACK;
SELECT * FROM EMP_SALARY;























