/*
    < DDL >
    DATA DEFINTION LANGUAGE
    ������ ���� ���
    
    ��ü���� ������ ���� (CREATE), ���� (ALTER), ����(DROP)
    �ϴ� ������
    
    => UPDATE : ������ "����" �� ����
       DELETE : ������ "����" �� ����
    => ALTER : ���̺� "����" �� ����
       DROP : ���̺� "����" �� ����
       
*/


/*
    1. ALTER
    ��ü ������ �����ϴ� ����
    
    < ���̺� ���� >
    ALTER TABLE ���̺�� �����ҳ���;
    
    - �����ҳ���
    1) �÷� �߰� / ���� / ���� 
    2) �������� �߰� / ����  => ������ �Ұ�
                             �����ϰ��� �Ѵٸ� ���� �� ������ �߰�
    3) ���̺�� / �÷��� / �������Ǹ� ����
    
*/

-- 1) �÷� �߰� / ���� / ����
-- 1_1) �÷� �߰� (ADD) 
-- ADD �߰����÷��� ������ Ÿ�� DEFAULT �⺻��
-- => DEFAULT �⺻���� ���� ����

SELECT * FROM DEPT_COPY;

-- CNAME �÷� �߰�
ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20);
SELECT * FROM DEPT_COPY;
--> ���ο� �÷��� ��������� �⺻������ NULL ������ ä����

-- LANME �÷� �߰� DEFAULT �����ؼ�
ALTER TABLE DEPT_COPY ADD LNAME VARCHAR2(20) DEFAULT '�ѱ�';

SELECT * FROM DEPT_COPY;
--> ���ο� �÷��� ��������� NULL �� �ƴ� DEFUALT ������ ä����

-- 1_2) �÷� ���� (MODIFY)
-- ������Ÿ�� ���� : MODIFY �������÷��� �ٲܵ�����Ÿ��
-- DEFAULT �� ���� : MODIFY �������÷��� DEFAULT �ٲٰ����ϴ±⺻��

-- DEPT_COPY ���̺���
-- DEPT_ID �÷��� ������Ÿ���� CHAR(3) �� ����
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);

-- �ڷ��� ���� �� ���ǻ���
-- ���� �����ϰ��� �ϴ� �÷��� �̹� ����ִ� ����
-- ���� �ٸ� Ÿ�����δ� ���� �Ұ��ϴ�!!
-- ��) ���� -> ���� (X) / ���ڿ��� ������ ��� (X)
--   ���ڿ� ������ Ȯ�� (O)

-- ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER;
-- ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(10);

-- DEPT_TITLE �÷��� ������Ÿ���� VARCHAR2(40) ����
-- LOCATION_ID �÷��� ������Ÿ���� VARCHAR2(2) �� ����
ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(40)
                      MODIFY LOCATION_ID VARCHAR2(2);
                      
--> �� ���̺��� ���� ������ ���������
-- ���� ���� ������ ���̾ ��� ������!!

-- LNAME �÷��� �⺻���� '�̱�' ���� ����
ALTER TABLE DEPT_COPY MODIFY LNAME DEFAULT '�̱�';

SELECT * FROM DEPT_COPY;
--> DEFAULT �������� �����Ǿ�����
-- ���� ����ִ� ������ ������ ��������� ����!!

-- 1_3) �÷� ���� (DROP COLUMN)
-- DROP COLUMN �������÷���
CREATE TABLE DEPT_COPY2
AS (SELECT * 
    FROM DEPT_COPY);

SELECT * FROM DEPT_COPY2;

-- DEPT_COPY2 ���̺��� DEPT_ID �÷� �����
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;

SELECT * FROM DEPT_COPY2;
ROLLBACK;
SELECT * FROM DEPT_COPY2;
--> DDL ������ ���� �Ұ���

-- ��� �÷��� ���ֺ���
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;
ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID;

SELECT * FROM  DEPT_COPY2;

ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME;
--> ������ �÷� ������ ����
-- ���̺� �ּ� �Ѱ��� �÷��� ��� �����ؾ���!!

-- 2) �������� �߰� / ����

/*
    2_1) �������� �߰� (ADD)
    
    - PRIMARY KEY :
        ADD PRIMARY KEY(�÷���)
    - FOREIGN KEY :
        ADD FOREIGN KEY(�÷���) REFERENCES ���������̺��(�������÷���)
    - UNIQUE :
        ADD UNIQUE(�÷���)
    - CHECK :
        ADD CHECK(�÷����������ǽ�)
    - NOT NULL : 
        MODIFY �÷��� NOT NULL;
        
    => ������ �������Ǹ��� �ο��ϰ��� �Ѵٸ�
       �������� �տ� CONSTRAINT �������Ǹ��� ����ϸ� ��!!
    => ���� ���� ���� �ִ� ������ �������Ǹ����� ����ؾ���!!
    => �̹� �ش� �÷��� ����ִ� ���� ���ؼ� �˸´� ������������
       �߰��ؾ� ��!!
*/


-- DEPT_COPY ���̺�
-- DEPT_ID �÷��� PRIMARY KEY �������� �߰�
-- DEPT_TITLE �÷��� UNIQUE �������� �߰�
-- LNAME �÷��� NOT NULL �������� �߰�
ALTER TABLE DEPT_COPY ADD CONSTRAINT DCOPY_PK PRIMARY KEY(DEPT_ID)
                      ADD CONSTRAINT DCOPY_UQ UNIQUE(DEPT_TITLE)
                      MODIFY LNAME CONSTRAINT DCOPY_NN  NOT NULL;

-- ���ǻ���
-- �������Ǹ��� �� ���� ������ �ߺ� �Ұ�!!
ALTER TABLE DEPARTMENT ADD CONSTRAINT DCOPY_UQ UNIQUE(DEPT_TITLE);
--> �ƹ��� �ٸ� ���̺��̴��� �ȵ�!!

-- �̹� �ش� �÷��� ����ִ� �� �������� ���������� �߰��ؾ���
ALTER TABLE DEPT_COPY
MODIFY CNAME NOT NULL;
--> �̹� CNAME �÷��� NULL ���� ����ֱ� ������
-- NOT NULL �������� �߰� �Ұ�!!

/*
    2_2) �������� ���� (DROP CONSTRAINT)
    
    PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK :
    DROP CONSTRAINT �������Ǹ�
    
    - NOT NULL :
    MODIFY �÷��� NULL 
*/


-- DCOPY_PK �������� ����
ALTER TABLE DEPT_COPY DROP CONSTRAINT DCOPY_PK;

-- DEPT_COPY ���̺�� ����
-- DCOPY_UQ �������� ����
-- DCOPY_NN �������� ���� (LNAME)
ALTER TABLE DEPT_COPY DROP CONSTRAINT DCOPY_UQ
                      MODIFY LNAME NULL;
-- NOT NULL ���������� ���
-- �������Ǹ��� ���� ��쿡�� DROP CONSTRAINT ����
ALTER TABLE DEPT_COPY DROP CONSTRAINT SYS_C007169;


--- 3) �÷��� / �������Ǹ� / ���̺�� ���� (RENAME)
-- 3_1) �÷��� ����
-- RENAME COLUMN �����÷��� TO �ٲ��÷���
ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

-- ���ǻ���
ALTER TABLE DEPT_COPY
RENAME COLUMN LNAME TO CNAME;
--> �� ���̺� �������� �ߺ��� �÷������� ���� �Ұ�!!

-- 3_2) �������Ǹ� ����
-- RENAME CONSTRAINT �����������Ǹ� TO �ٲ��������Ǹ�
ALTER TABLE DEPT_COPY
RENAME CONSTRAINT SYS_C007168 TO DCOPY_DID_NN;
-- �� ������ �̹� �����ϴ� �������Ǹ����δ� ���� �Ұ�!!

-- 3_3) ���̺�� ����
-- RENAME TO �ٲ����̺��
-- (�̹� �տ� ALTER TABLE ���̺���� ����Ǿ��� ����)
ALTER TABLE DEPT_COPY RENAME TO DEPT_TEST;
--> �� ������ �̹� �����ϴ� ���̺������ ���� �Ұ�!!

SELECT * FROM DEPT_COPY;
SELECT * FROM DEPT_TEST;

----------------------------------------------------------------------

/*
    2. DROP 
    
    ��ü�� �����ϴ� ����
    
    - ���̺��� �����ϰ� �ʹٸ�?
    DROP TABLE ���̺��;
    
    - ������ �����ϰ� �ʹٸ�?
    DROP USER ������;
    
    ...
    
*/

-- DEPT_TEST ���̺� ����
DROP TABLE DEPT_TEST;


SELECT * FROM DEPT_TEST;

-- DELETE FROM ���̺��; ���� ������
--> ���̺� ������ ���� �ΰ� ���� �����͸� ���������ڴ�.
-- SELECT ������ ��ȸ ���� (��, ���������� ����)
--> ���̺� ���� ��ü�� ���������ڴ�.
-- SELECT ������ ��ȸ �Ұ� (TABLE OR VIEW DOES NOT EXIST)

-- DROP TABLE �� ���ǻ���
-- ��򰡿��� �����ǰ��ִ� "�θ����̺�"�� �������� �ʴ´�.
-- ���࿡ �����ϰ� �ʹٸ�
-- 1. �ڽ����̺��� ���� ������ �� �θ����̺��� �����ϴ� ���
-- DROP TABLE �ڽ����̺��;
-- DROP TABLE �θ����̺��;

--> ����)
-- �׻� CREATE �ÿ��� �θ����̺��� ���� �����ؾ���!!

-- 2. �θ����̺� �����ϵ�, �¹����ִ� ���������� ���� �����ϴ� ���
-- (�ڽ����̺� �� �����ʹ� ���������)
-- DROP TABLE �θ����̺�� CASCADE CONSTRAINT;


-------------------------------------------------------------------------------




