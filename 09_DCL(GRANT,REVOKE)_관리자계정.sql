/*
    < DCL >
    
    DATA CONTROL LANGUAGE
    ������ ���� ���
    
    
    �������� �ý��� ���� �Ǵ� ��ü ���ٱ�����
    �ο� (GRANT) �ϰų� ȸ�� (REVOKE) �ϴ� ���
    
    
    => ������ ���� ������ �Ƚ����ִ� COMMIT,
       ������ ���� ������ �������ִ� ROLLBACK ���� DCL �� �з���
       ������ TCL (TRANSACTION CONTROL LANGUAGE)
       �� ���� �з��ϱ⵵ ��!!
       
    * ���� �ο� (GRANT)
    - �ý��۱��� : Ư�� DB�� �����ϴ� ����, ��ü���� ������ �� �ִ� ����
    - ��ü���ٱ��� : Ư�� ��ü�鿡 �����ؼ� '����' �� �� �ִ� ����
    
    * �ý��۱���
    Ư�� DB�� �����ϴ� ����, ��ü���� ������ �� �ִ� ����
    
    [ ǥ���� ]
    GRANT ���Ѹ�1, ���Ѹ�2, ... TO ������;
    
    - �ý��۱����� ����
    CREATE SESSTION : ������ ������ �� �ִ� ����
    CREATE TABLE : ���̺��� ������ �� �ִ� ����
    CREATE VIEW : �並 ������ �� �ִ� ����
    CREATE SEQUENCE : �������� ������ ���ִ� ����
    CREATE USER : ������ ������ �� �ִ� ����
    ...
    
    
*/

-- 1. SAMPLE �Ϲ� ���� ����
CREATE USER SAMPLE IDENTIFIED BY SAMPLE;

--> ������ �� �ִ� ���� CREATE SESSION ������ �ο����� �ʾҴ���
-- ���� �� logon denied ���� �߻�

-- 2. SAMPLE ������ �����ϱ� ���� CREATE SESSION ���� �ο�
GRANT CREATE SESSION TO SAMPLE;

--3_1. SAMPLE ������ ���̺��� ������ �� �ִ�
-- CREATE TABLE ���� �ο�
GRANT CREATE TABLE TO SAMPLE;


--3_2. SAMPLE ������ ���̺� �����̽� ���� �Ҵ����ֱ�
-- (ALTER ������ ���� SAMPLE ���� ����)
ALTER USER SAMPLE QUOTA 2M ON SYSTEM;
--> QUDTA : �Ҵ��ϴ� (�����ִ�)
--> 2M : 2 MEGA BYTE

-- 4. SAMPLE ������ �並 ������ �� �ִ�
-- CREATE VIEW ���� �ο�
GRANT CREATE VIEW TO SAMPLE;

--------------------------------------------------------
/*
    * ��ü���ٱ��� (��ü����)
    
    Ư�� ��ü���� ������ �� �ִ� ����
    (��, DML �������� ������ �� �ִ� ����)
    SELECT, INSERT, UPDATE, DELETE �� ��������
    
    [ ǥ���� ]
    GRANT �������� ON Ư����ü TO ������;
    
    ��������     |   Ư����ü
    -----------------------------------
    SELECT      | TABLE, VIEW, SEQUENCE
    INSERT      | TABLE, VIEW
    UPDATE      | TABLE, VIEW
    DELETE      | TABLE, VIEW
    
    ��) Ư�� XXX ���̺� SELECT �� �� �ִ� ���Ѹ� �ο�
    GRANT SELECT ON ���̺�� TO ������;
    
*/

-- 5. SAMPLE ������
-- KH.EMPLOYEE ���̺��� ��ȸ�� �� �ִ� ���� �ο�
GRANT SELECT ON KH.EMPLOYEE TO SAMPLE;

-- 6. SAMPLE ������
-- KH.DEPARTMENT ���̺� ���� ������ �� �ִ�
-- ���� �ο�
GRANT INSERT ON KH.DEPARTMENT TO SAMPLE;

-------------------------------------------------------

-- �츮�� �׵��� �ּ��� ������ �ο��ϰ��� �� ��
-- CONNET, RESOURCE �� �ο��߾���!!
-- GRANT CONNECT , RESOURCE TO ������;

/*
    < �� ROLE >
    
    "Ư�� ���ѵ�" �� �ϳ��� "����" ���� ������� ��
    
    CONNECT : CREATE SESSION 
                (�����ͺ��̽��� ������ �� �ִ� ����)
    RESOURCE : CREATE TABLE, CREATE SEQUENCE, ..
                (Ư�� ��ü���� ���� �� ������ �� �ִ� ����)
*/

-- ������ ��ųʸ� (ROLE_SYS_PRIVS) �� ����
-- � ���� �ְ�, 
-- � �ѿ� � ���ѵ��� �����ִ��� Ȯ�� ����
SELECT *
FROM ROLE_SYS_PRIVS
WHERE ROLE IN ('CONNECT','RESOURCE');

-----------------------------------------------------------

/*
    * ���� ȸ�� (REVOKE)
    
    ������ ȸ���� �� (���� ��) ����ϴ� ��ɾ�
    
    [ ǥ���� ]
    
    REVOKE ���Ѹ�1, ���Ѹ�2, ... FROM ������;
    
    
    
    
*/

-- 7. SAMPLE �������� ���̺��� ������ �� ������ ���� ȸ��
REVOKE CREATE TABLE FROM SAMPLE;







