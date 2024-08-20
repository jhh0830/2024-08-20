
-- ���� SAMPLE ������
-- ������ �� �ִ� CREATE SESSION ���Ѹ�
-- �ο����� ������

CREATE TABLE TEST(
    TEST_ID NUMBER
);

-- 3_1. SAMPLE ������
-- ���̺��� �����Ҽ� �ִ� ������ ���� ������
-- ���� �߻�
-- ORA-01031: insufficient privileges

-- CREATE TABLE ���� �ο����� ��
CREATE TABLE TEST(
    TEST_ID NUMBER
);

-- 3_2. TABLE SPACE �� �Ҵ���� �ʾƼ� 
-- ���� �߻�
-- ORA-01950: no privileges on tablespace 'SYSTEM'
--> TABLE SPACE : ���̺���� ���ִ� (����Ǵ�) ����
--> SYSTEM : ����Ŭ �⺻ ���� TABLE SPACE



-- TABLE SPACE ���� �Ҵ���� ��
CREATE TABLE TEST(
    TEST_ID NUMBER

);

-- ���� ���̺� ���� ������ �ο��ް� �Ǹ�
-- �ش� ������ �����ϰ� �ִ� ���̺���� "����" �ϴ°͵� ��������
-- (DML ���� ���� ��� ����)

SELECT * FROM TEST;
INSERT INTO TEST VALUES(1);

-- �� ����� ����
CREATE VIEW V_TEST
AS (SELECT * FROM TEST);

-- 4. �並 ������ �� �ִ� CREATE VIEW ������ 
-- �ο����� �ʾұ� ������ ���� �߻�
-- ORA-01031: insufficient privileges

-- CREATE VIEW ���� �ο����� ��
CREATE VIEW V_TEST
AS (SELECT * FROM TEST);

--> �� ���� �Ϸ�!
----------------------------------------------------------------------------


-- SAMPLE �������� KH ������ ���̺� �����ؼ� ��ȸ�غ���

SELECT *
FROM KH.EMPLOYEE;


-- 5. KH ������ ���̺� �����ؼ� ��ȸ�� �� �ִ� ������
-- ���� ������ ���� �߻�
-- ORA-00942: table or view does not exist

-- SELECT ON ���� �ο� ��
SELECT * FROM KH.EMPLOYEE;
--> EMPLOYEE ���̺��� ��ȸ ����
SELECT * FROM KH.DEPARTMENT;
--> KH ������ DEPARTMENT ���̺� ������ �� �ִ�
-- ���� �� ���� ������ ����

-- SAMPLE ��������
-- KH ������ ���̺� �����ؼ� �� �����غ���
INSERT INTO KH.DEPARTMNET VALUES('D0'
                               , 'ȸ���'
                               , 'L2');

-- 6. KH ������ ���̺� �����ؼ� -- ���� ������ �� �ִ� ������ ���� ������ ���� �߻�
-- SQL ���� >>  ORA-00942: table or view does not exist

-- INSERT ON ���� �ο� ��
INSERT INTO KH.DEPARTMENT VALUES('D0'
                                , 'ȸ���'
                                , 'L2');

--> KH.DEPARTMENT ���̺� �� INSERT ����

COMMIT; -- SAMPLE �������� ���� ������ �� ��ü �ʿ��� �������ش�.

SELECT * FROM DEPARTMENT; -- KH �������� ����

DELETE
    FROM DEPARTMENT
    WHERE DEPT_ID = 'D0'; -- KH �������� ����
    COMMIT; -- KH �������� ����
-------------------------------------------------------------------------------

-- ���̺� ����� ����
CREATE TABLE TEST2(
    TSET_ID NUMBER
);

-- 7. SAMPLE �������� ���̺��� ������ �� ������
-- ������ ȸ���߱� ������ ���� �߻�
-- ORA-01031: insufficient privileges

