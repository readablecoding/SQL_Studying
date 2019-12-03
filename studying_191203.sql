--<�Ϲ� �Լ�>

--1)NVL�� NULL �� ó���ϱ�
SELECT 
    ENAME, 
    SALARY, 
    COMMISSION,
    NVL(COMMISSION, 0),
    SALARY * 12 + NVL(COMMISSION, 0)
FROM 
    EMPLOYEE
ORDER BY JOB;

--2)NVL2�� NULL�� ó���ϱ�
SELECT 
    ENAME, 
    SALARY, 
    COMMISSION,
    NVL2(COMMISSION, SALARY * 12 + COMMISSION, SALARY * 12)
FROM 
    EMPLOYEE
ORDER BY JOB;

--3)DECODE�� �μ��̸� ����ϱ�
SELECT ENAME, DNO,
DECODE(DNO, 10, 'ACCOUNTING',
            20, 'RESEARH',
            30, 'SALES',
            40, 'OPERATIONS',
            'DEFAULT'
        ) AS DNAME
FROM 
    EMPLOYEE
ORDER BY DNO;

--4)CASE�� �μ��̸� ����ϱ�
SELECT ENAME, DNO,
    CASE WHEN DNO = 10 THEN 'ACCOUNTING'
        WHEN DNO = 20 THEN 'RESEARCH'
        WHEN DNO = 30 THEN 'SALES'
        WHEN DNO = 40 THEN 'OPERATIONS'
        ELSE 'DEFAULT'
        END AS DNAME
        FROM EMPLOYEE
        ORDER BY DNO;

--<ȥ�� �غ��� 04>
--6)������� ��� ����� ����ϵ� ����� ���� ����� ���ؼ��� NULL�� ��� 0���� ���
SELECT 
    ENO, 
    NAME, 
    NVL2(MANAGER,MANAGER, 0) AS MANAGER
FROM 
    EMPLOYEE;
    
--7)DECODE �Լ��� ���޿� ���� �޿��� �λ�. ������ ANAYLIST�� ����� 200, 'SALESMAN'�� ����� 180, 
--'MANAGER'�� ����� 150, 'CLERK'�� ����� 100�� �λ�
SELECT 
    ENO, 
    NAME,
    JOB,
    SALARY, 
DECODE(JOB, 'ANALYST', SALARY + 200,
            'SALESMAN', SALARY + 180,
            'MANAGER', SALARY + 150,
            'CLERK', SALARY + 100,
            SALARY) AS UPDATE_SALARY
FROM 
    EMPLOYEE;
    
--<�׷��Լ�>
--1)������� �޿� �Ѿ�, ��վ�, �ְ��, �ּҾ� ���
SELECT SUM(SALARY) AS "�޿��Ѿ�"
        ,AVG(SALARY) AS "�޿����"
        ,MAX(SALARY) AS "�ִ�޿�"
        ,MIN(SALARY) AS "�ּұ޿�"
FROM
    EMPLOYEE;

--2)�ֱٿ� �Ի��� ����� ���� �������� �Ի��� ����� �Ի��� ����ϱ�
SELECT 
    MAX(HIREDATE)
    , MIN(HIREDATE)
FROM
    EMPLOYEE;

--3)������� Ŀ�̼� �Ѿ� ���
SELECT 
    SUM(COMMISSION) AS "Ŀ�̼� �Ѿ�"
FROM 
    EMPLOYEE; --2200

--4)��ü ����� �� ���ϱ�
SELECT COUNT(*) AS "����� ��"
FROM EMPLOYEE; --14

--5)Ŀ�̼��� �޴� ����� �� ���ϱ�
SELECT COUNT(COMMISSION) AS "Ŀ�̼� �޴� �� ���ϱ�"
FROM EMPLOYEE; --4

--6)���� ������ ���� ����ϱ�
SELECT COUNT(DISTINCT JOB) AS "���� ������ ����"
FROM EMPLOYEE; --5

--<ȥ�� �غ���> 05
--1)��� ����� �޿� �ְ��, ������, �Ѿ� �� ��� �޿��� ���
--�÷��� ��Ī�� ��� ȭ��� �����ϰ� �����ϰ� ��տ� ���ؼ��� ������ �ݿø�
SELECT MAX(SALARY) AS "MAXIMUM"
        ,MIN(SALARY) AS "MINIMUM"
        ,SUM(SALARY) AS "SUM"
        ,ROUND(AVG(SALARY)) AS "Average"
        FROM EMPLOYEE;

--2)�� ��� ���� �������� �޿� �ְ��, ������, �Ѿ� �� ��վ��� ���.
--Į���� ��Ī�� ��� ȭ��� �����ϰ� �����ϰ� ��տ� ���ؼ��� ������ �ݿø�
SELECT JOB AS "Job"
        ,MAX(SALARY) AS "Maximum"
        ,MIN(SALARY) AS "Minimum"
        ,SUM(SALARY) AS "Sum"
        ,ROUND(AVG(SALARY)) AS "Average"
FROM 
    EMPLOYEE
GROUP 
    BY JOB;
    
--3)COUNT(*)�Լ��� �̿��Ͽ� ��� ������ ������ ��� ���� ���
SELECT JOB, COUNT(*)
FROM EMPLOYEE
GROUP BY JOB;
--4)������ ���� ����. Į���� ��Ī�� ��� ȭ��� ����
SELECT COUNT(MANAGER)
FROM EMPLOYEE;
--5)�޿� �ְ��, �޿� �������� ������ ���. Į���� ��Ī�� ��� ȭ��� ����
SELECT MAX(SALARY) - MIN(SALARY) AS DIFFERENCE
FROM EMPLOYEE;


--<19.12.3 ���� ����>
--1)��ȭ��ȣ�� NULL�̸� '0000���� ��Ÿ����
SELECT NUM, NAME, NVL(PHONE, '0000') FROM PERSON;
--2)�հ��� �߿��� ��ȭ��ȣ�� ������ �� �� 3�ڸ���, ������ "000"����
SELECT NAME
        , NVL2(PHONE, SUBSTR(PHONE, 0, 3),'000') PHONE
FROM
    PERSON
WHERE 
    PASS = 'O';
--3)PASS �÷��� 'O'�� ��������� '�հ�', 'X'�� ��������� '���հ�',�� �ܴ� '����'���� ó��
SELECT
    NAME
    ,DECODE(PASS, 'O', '�հ�'
                , 'X', '���հ�'
                ,'����') AS PASS
FROM
    PERSON;
--4)PASS �÷��� 'O'�� ��������� '�հ�', 'X'�� ��������� '���հ�',�� �ܴ� '����'���� ó��
SELECT 
    NAME
    ,(CASE
        WHEN PASS = 'O' THEN '�հ�'
        WHEN PASS = 'X' THEN '���հ�'
        ELSE '����'
    END) AS PASS
FROM
    PERSON;
--5)��� �������� ���� �հ�, ���, �ִ밪, �ּҰ�
SELECT 
    COUNT(*)
    , SUM(EXAM)
    , ROUND(AVG(EXAM))
    , MAX(EXAM)
    , MIN(EXAM) 
FROM 
    PERSON;
--6)�ּҿ� ���ְ� ���� ��� �� ���
SELECT 
    COUNT(*) 
FROM
    PERSON 
WHERE 
    ADDRESS LIKE '%����%';
 
--7)������ Ȱ�� ����

--ȸ������
CREATE TABLE MEMBER(
    ID VARCHAR(30) PRIMARY KEY              --ID -> �⺻Ű�� �ߺ� �ȵǰ� �ʼ�
    ,PASSWORD VARCHAR(20) NOT NULL          --��й�ȣ -> �ʼ��̹Ƿ� NOT NULL
    ,NAME VARCHAR(20) NOT NULL              --�̸� -> �ʼ��̹Ƿ� NOT NULL
    ,GENDER CHAR(1) DEFAULT 'M'             --����: ���� �Ǵ� �����̹Ƿ� CHAR, 
    ,PHONE VARCHAR2(30)                     --��ȭ��ȣ
    ,ADDRESS VARCHAR2(100)                  --�ּ�
    ,EMAIL VARCHAR2(50)                     --�̸���
);

INSERT INTO MEMBER VALUES('123', 'ABC', 'ȫ�浿', 'M', '010-1111-1111', '���� ���걸', 'ABC@ABC.COM');
INSERT INTO MEMBER VALUES('456', 'BBB', '�ڱ浿', 'F', '010-2222-2222', '���� ��������', 'BBB@MM.COM');
INSERT INTO MEMBER VALUES('666', 'TTT', '�ٳ�ī', 'F', '010-9999-5555', '��⵵ ����', 'RRR@UU.COM');
INSERT INTO MEMBER VALUES('555', 'CCC', '�⹫��', 'M', '010-6666-8888', '�뱸 �޼���', 'GGG@HH.COM');
INSERT INTO MEMBER VALUES('789', 'UUU', '�ٴϿ�', 'F', '010-3434-5656', '�̱� ����', 'WWW@SS.COM');

--�Խ��� �� ����
CREATE TABLE BOARD(
    NUM         NUMBER PRIMARY KEY          --�۹�ȣ
    ,ID         VARCHAR2(20) NOT NULL       --�ۼ��� ID
    ,TITLE      VARCHAR2(200) NOT NULL      --�� ����
    ,CONTENTS   VARCHAR2(2000) NOT NULL      --����
    ,INPUTDATE  DATE DEFAULT SYSDATE         --�ۼ��ð�
    ,HITS       NUMBER DEFAULT 0            --��ȸ��
    ,LIKES      NUMBER DEFAULT 0            --��õ��
);

--�Խ��� �� ��ȣ�� ����� ������
CREATE SEQUENCE BOARD_SEQ;
--�Խ��� �� ���� ��
INSERT INTO BOARD(NUM, ID, TITLE, CONTENTS) VALUES (BOARD_SEQ.NEXTVAL, '123', '����', '����');
INSERT INTO BOARD(NUM, ID, TITLE, CONTENTS) VALUES (BOARD_SEQ.NEXTVAL, '123', '�ȳ�', '�������̳�');
INSERT INTO BOARD(NUM, ID, TITLE, CONTENTS) VALUES (BOARD_SEQ.NEXTVAL, '555', '����', '�ɽ��ϳ�');
INSERT INTO BOARD(NUM, ID, TITLE, CONTENTS) VALUES (BOARD_SEQ.NEXTVAL, '789', '������', '����־�');
INSERT INTO BOARD(NUM, ID, TITLE, CONTENTS) VALUES (BOARD_SEQ.NEXTVAL, '666', '���ڳ�', '���� �ϰ� �ͳ�');

--��� ���� ���̺�
CREATE TABLE REPLY(
    REPLYNUM NUMBER PRIMARY KEY,
    BOARDNUM NUMBER,
    ID VARCHAR2(2) NOT NULL,
    TEXT VARCHAR2(1000) NOT NULL,
    INPUTDATE DATE DEFAULT SYSDATE,
    CONSTRAINT REPLY_FK FOREIGN KEY (BOARDNUM) REFERENCES BOARD(NUM)
    ON DELETE CASCADE
);

--��� ��ȣ�� ����� ������
CREATE SEQUENCE REPLY_SEQ;
--���� ��
INSERT INTO REPLY(REPLYNUM, BOARDNUM, ID, TEXT) 
    VALUES (REPLY_SEQ.NEXTVAL, 1, '123', 'ù ���');
INSERT INTO REPLY(REPLYNUM, BOARDNUM, ID, TEXT) 
    VALUES (REPLY_SEQ.NEXTVAL, 2, '555', '�ɽ��� �Ϸ�');





