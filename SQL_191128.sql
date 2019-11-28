--<������ ���� ���̺�>
CREATE TABLE PERSON(
NUM NUMBER PRIMARY KEY,          --������ ��ȣ(�Ϸù�ȣ), ()�� ������ �ִ� ũ��, PRIMARY KEY�� �⺻Ű�� �ߺ��ȵ�
NAME VARCHAR2(20)NOT NULL,       --�̸�, �ʼ� �Է� �׸��̹Ƿ� NOT NULL
BIRTH DATE,                      --�������
PHONE VARCHAR2(20),              --��ȭ��ȣ
ADDRESS VARCHAR(200),            --�ּ�
EXAM NUMBER(3) DEFAULT 0,       --��������(100�� ���� ����), �Է� ���ϸ� 0������ �� �� DEFAULT 0 ���
INTERVIEW NUMBER(3,1) DEFAULT 0, --��������(10�� ���� �Ǽ�), �Է� ���ϸ� 0������ �� �� DEFAULT 0 ���
PASS CHAR(1)                     --�հݿ���(��/�� ���� �ϳ��� O, X)
);

--<������ ����>
INSERT INTO PERSON VALUES(1, 'ȫ�浿', '95-11-2', '010-1111-1111', '���ֽ� ���걸 111', 100, 5.5, '0');
INSERT INTO PERSON (NUM, NAME, BIRTH) VALUES (2, '��ö��', '96-1-2');
INSERT INTO PERSON VALUES(3, '��û��', '96-5-20', '010-2222-2222', '���� ���', 60, 6.1, 'X');
INSERT INTO PERSON (NUM, NAME, PHONE, INTERVIEW) VALUES(4, '���ô�','010-3333-3333', 7.8);
INSERT INTO PERSON (NUM, NAME, PASS) VALUES(5, '�䳢', 'O');
INSERT INTO PERSON VALUES(6, '�ɺ���', '85-3-10', '010-8888-8888', '������ ��ô', 50, 5.6, 'O');
INSERT INTO PERSON VALUES(7, '����Ŭ', '00-8-15', '010-6666-6666', '�̱� �þ�Ʋ', 85, 8.2, 'O');
INSERT INTO PERSON (NUM, NAME, ADDRESS, INTERVIEW) VALUES(8, 'Ʈ����', '�̱� ����', '9.0');
INSERT INTO PERSON VALUES(9, '�ٳ�ī', '80-9-5', '010-0000-5555', '�Ϻ� ����', 89, 6.8, 'X');
INSERT INTO PERSON VALUES(10, '�ƺ�', '60-10-23', '010-5555-8888', '�Ϻ� ����', 95, 9.5, 'O');
INSERT INTO PERSON VALUES(11, '��浿', '95-11-22', '010-1111-1111', '���ֽ� ���걸 111', 100, 5.5, 'X');
INSERT INTO PERSON VALUES(12, '�ֱ浿', '95-11-22', '010-1111-1111', '��⵵ ���ֽ� 111', 100, 5.5, '0');

--<���� �˻�>
SELECT * FROM PERSON; -- *�� Į�� ����
SELECT NUM, NAME, BIRTH FROM PERSON;
SELECT * FROM PERSON WHERE PASS = '0';
SELECT NUM, NAME FROM PERSON WHERE EXAM = 100; 
SELECT NUM, NAME, (EXAM*10) SCORE  FROM PERSON; 
--SCORE�� EXAM * 10�ε� ����ϰ� ���̰� ���� ��. �÷��� ����ִ� ���� * 10�� ���� �����´�. ���̺� ���� ������ ����
DESC PERSON; --���̺��� ������ ������


--<where ���� ���>
SELECT * FROM PERSON WHERE NAME LIKE 'ȫ%';          --���� 'ȫ'���� ���
SELECT * FROM PERSON WHERE NAME LIKE '%�浿';        --�̸��� '�浿'�� ���
SELECT * FROM PERSON WHERE EXAM BETWEEN 50 AND 70;   --���������� 50 ~ 70��
SELECT * FROM PERSON WHERE BIRTH = '95-11-2';         --��������� '95/11/2'�� ���
SELECT * FROM PERSON WHERE PASS = '0' AND EXAM <= 60; --�հ��� �߿��� ���� ������ 60�� ������ ���
SELECT * FROM PERSON WHERE PASS IS NULL;              --�հݿ��ΰ� NULL�� ���
SELECT * FROM PERSON WHERE NAME LIKE '��%' AND ADDRESS LIKE '%����%';  --'��'�� �߿��� ���� ����
SELECT NAME, (EXAM / 10) SCORE FROM PERSON WHERE PASS = 'O';  --�հ��ڵ��� �̸��� ������ ��� (������ 10�� �������� ȯ���ؼ� ���)


