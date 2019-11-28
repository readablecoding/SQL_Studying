--<������ ���� ���̺�>
CREATE TABLE INFORM(
NUM NUMBER PRIMARY KEY, --������ ��ȣ(�Ϸù�ȣ)
NAME VARCHAR2(20)NOT NULL, --�̸�
BIRTH DATE, --�������
PHONE VARCHAR2(20), --��ȭ��ȣ
ADDRESS VARCHAR(200), --�ּ�
EXAM NUMBER(3) DEFAULT 0, --��������(100�� ���� ����), �Է� ���ϸ� 0��
INTERVIEW NUMBER(3,1) DEFAULT 0, --��������(10�� ���� �Ǽ�), �Է� ���ϸ� 0��
PASS CHAR(1) --�հݿ���(��/�� ���� �ϳ��� O, X)
);


--<������ ����>
INSERT INTO INFORM VALUES(1, 'ȫ�浿', '95-12-25', '010-1111-1111','���� ���걸 111', 100, 5.5,'O');
INSERT INTO INFORM VALUES(2, '��浿', '97-5-25', '010-2222-2222','���� ����', 80, 4.5, 'X');
INSERT INTO INFORM VALUES(3, '�ڱ浿', '00-9-8', '010-3333-3333', '�λ� �ؿ��', 45, 3.5, 'X');
INSERT INTO INFORM VALUES(4, '���ٸ�', '95-11-2', '010-4444-4444', '�̱� ������', 65, 9.8, 'O');
INSERT INTO INFORM(NUM, NAME, EXAM, INTERVIEW, PASS) VALUES (5, 'Ʈ����', 99, 10.0, 'O');
INSERT INTO INFORM(NUM, NAME, ADDRESS)VALUES(6, '�ƺ�', '�Ϻ�');
INSERT INTO INFORM(NUM, NAME, ADDRESS)VALUES(7, 'Ǫƾ', '���þ�');


--<���� �˻�>
--���� 'ȫ'���� ���
SELECT * FROM INFORM WHERE NAME = 'ȫ%';
--�̸��� '�浿'�� ���
SELECT * FROM INFORM WHERE NAME = '%�浿';
--���������� 50 ~ 70��
SELECT * FROM INFROM WHERE EXAM BETWEEN 50 AND 70;
--��������� '95/11/2'�� ���
SELECT * FROM INFORM WHERE BIRTH = '95/11/2';
--�հ��� �߿��� ���� ������ 60�� ������ ���
SELECT * FROM INFORM WHERE PASS = 'O' AND EXAM <= 60;
--�հݿ��ΰ� NULL�� ���
SELECT * FROM INFORM WHERE PASS IS NULL;
--'��'�� �߿��� ���� ����
SELECT * FROM INFORM WHERE NAME LIKE '��%' AND ADDRESS LIKE '%����%';
--�հ��ڵ��� �̸��� ������ ��� (������ 10�� �������� ȯ���ؼ� ���)
SELECT NAME, (EXAM / 10)SCORE FROM INFORM WHERE PASS = 'O';
