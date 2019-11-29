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
SELECT * FROM PERSON; -- *�� Į�� ����, PERSON�� ��� ��
SELECT NUM, NAME, BIRTH FROM PERSON; 
SELECT * FROM PERSON WHERE PASS = '0';
SELECT NUM, NAME FROM PERSON WHERE EXAM = 100;  --where�� ���̸� �Ϻ� �ุ ���´�.
SELECT NUM, NAME, (EXAM*10) SCORE  FROM PERSON; 
--SCORE�� EXAM * 10�ε� ����ϰ� ���̰� ���� ��. �÷��� ����ִ� ���� * 10�� ���� �����´�. ���̺� ���� ������ ����
DESC PERSON; --���̺��� ������ ������


--<where ���� ���>
SELECT * FROM PERSON WHERE NAME LIKE 'ȫ%';          --���� 'ȫ'���� ���, =�� ��Ȯ�� ��ġ�� ���� ����. 
SELECT * FROM PERSON WHERE NAME LIKE '%�浿';        --�̸��� '�浿'�� ���
SELECT * FROM PERSON WHERE EXAM BETWEEN 50 AND 70;   --���������� 50 ~ 70��
--SELECT * FROM PERSON WHERE EXAM >= 50 AND EXAM <= 70; -> ���� ���
SELECT * FROM PERSON WHERE BIRTH = '95-11-2';         --��������� '95/11/2'�� ��� -> -�� ����ϸ� ��¥ Ÿ������ ��ȯ���ش�. 
SELECT * FROM PERSON WHERE PASS = '0' AND EXAM <= 60; --�հ��� �߿��� ���� ������ 60�� ������ ��� -> ������ ��� �ִٸ� AND, OR ���, �����ϸ� () ���
SELECT * FROM PERSON WHERE PASS IS NULL;              --�հݿ��ΰ� NULL�� ��� -> IS NULL�� ����ϸ� NULL�� ���� ã�Ƴ�, 
SELECT * FROM PERSON WHERE NAME LIKE '��%' AND ADDRESS LIKE '����%';  --'��'�� �߿��� ���� ����
SELECT (NAME || '��') NAME, (EXAM / 10) EXAM FROM PERSON WHERE PASS = 'O';  
--�հ��ڵ��� �̸��� ������ ��� (������ 10�� �������� ȯ���ؼ� ���), �̸��� '��'�� �پ� �������� || '��' ��� ���δ�.

---------------�Լ�---------------
SELECT EXAM + INTERVIEW FROM PERSON; --���̺� �ִ� �ุŭ ����� �ݺ��Ѵ�. �� ���� 100�̶�� 100�� �ݺ�
SELECT * FROM PERSON WHERE UPPER(PASS) = UPPER('O'); --PASS��� Į���� ������ �ִµ� �빮�ڷ� �ٲٴ� ��. ���̺��� ������ �ٲٴ� ���� �ƴϴ�. ���ϱ� ���� �ϳ��� ����
SELECT NAME, UPPER(PASS) PASS FROM PERSON; --PASS�� ����ִ� ���ڸ� �빮�ڷ� �ٲٰ� �÷� �̸��� PASS�� �ٲ�
SELECT NAME, LENGTHB(NAME) LEN FROM PERSON; --NAME Į���� ���� ����Ʈ ���̸� �����ְ� LEN�̶�� �̸� ����
SELECT NAME, BIRTH, CONCAT(NAME, BIRTH) NEWNAME FROM PERSON; --CONCAT�� ���� �̾��ִ� ��
SELECT NAME, SUBSTR(BIRTH, 4, 7) BIRTH FROM PERSON; --SUBSTR�� Ư����ġ ���ڸ� �߶� ������
SELECT NAME, SUBSTRB(BIRTH, 4, 7) BIRTH FROM PERSON; --SUBSTRB�� Ư����ġ ���ڸ� �߶� ������, ����Ʈ ���·� ������
SELECT NAME, INSTR (NAME, '�浿')FIND�浿 FROM PERSON; --INSTR�� ��ġ ���� ��ȯ
SELECT NAME, MOD(EXAM, 3), ROUND(INTERVIEW/3,2) FROM PERSON; 
--MOD(Į����, ����)�� �������� �����ְ�, ROUND(��, ����)�� �ݿø��ϴ� ��
--EXAM�� 3���� ���� ������, INTERVIEW�� 3���� ���� �Ҽ��� ��° �ڸ� �ݿø�, �̷� ��� ����Ŭ���� �ϴ� ���� ���ϴ�
SELECT 1+1 FROM DUAL; ---1�� 1��¥�� �� ���� ���̺� DUAL �� ������� 1+1�� ����� ó����. 1�� ����ϴ� �뵵, �� ĭ¥�� ǥ, �ٸ� �������� ���
SELECT * FROM DUAL; 
SELECT BIRTH,TO_CHAR(BIRTH,'YY-MM-DD HH:MI:SS') FROM PERSON; --_TO_CHAR(Į���� �Ǵ� ������ ����, '����')
SELECT BIRTH,TO_CHAR(BIRTH,'MM"��" DD"��"') FROM PERSON; --�ѱ��� ������ ���� " "�� ���δ�. Į������ �����͸� �ڿ� �� �������� ����

INSERT INTO PERSON (NUM, NAME, BIRTH) VALUES(13, '�迵��', TO_DATE('990101','YY-MM-DD')); 
--TO_DATE�� TO_CHAR�� �ٸ��� ������ �ݴ��. ���� ���¸� ���� �ٲ� �������� �ٲ۴�.

SELECT SYSDATE FROM DUAL; --���� �ð��� DUAL�� �����´�. -> ���� ��¥�� �����ش�. 19/11/29 
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL; --2019-11-29 10:47:00
SELECT SYSDATE -1 FROM DUAL; --19/11/28 -> ���� ��¥, 1�� �Ϸ��� �ǹ̴�.
SELECT ROUND(SYSDATE - TO_DATE('19-10-29', 'YY-MM-DD'),0) DAY_DIFF FROM DUAL; 
--��¥���� ���⸦ �� ��. 31.45041666666666666666666666666666666667
--�ݳ����� 0.5�� 12�ð��̴�. ROUND�� �Ἥ �ݿø��ϴµ� 0�� ������ �� ���� ���ڷ� ������

SELECT * FROM PERSON WHERE BIRTH ='10-11-22'; --��, ��, �ʰ� 0���� ó����, �̷��� ���ϴ� ����� �� ����
--���ڷ� ���� ��, ũ�ٴ� ���� ���� �ð��̰�, �۴ٴ� ���� ���� �ð�
SELECT * FROM PERSON WHERE BIRTH > TO_DATE('921122', 'YYMMDD'); -- BIRTH�� '921122'�� �Է¹��� ������ YYMMDD�� ��ȯ�� �Ͱ� ��
--ũ�ٴ� ���� 92�� 11�� 22�� ���Ķ�� ���̰� �۴ٴ� ���� 92�� 11�� 22�� ������ ���Ѵ�. ���� ���� ã�� �����. �ú��� �񱳰� ����
--�ֱ� 3�ϰ� ��¥�� �Ǿ� �ִ� ��
SELECT * FROM PERSON WHERE BIRTH > SYSDATE - 3; -- �ֱ� 3�ϰ��� �ش��ϴ� ��� ã��
--DATEŸ�� �������� ã�ƾ� �Ѵ�.
--11������ ��� -> ��¥ Ÿ������ �ϱ� ����� �͵� �ִ�. ���ڿ��� ��ȯ�ϴ� ���� ����
SELECT * FROM PERSON WHERE TO_CHAR(BIRTH, 'MM')= '11'; --������ 11���� ����� ã��
--������ ������ ���
SELECT * FROM PERSON WHERE TO_CHAR(BIRTH,'MMDD')= TO_CHAR(SYSDATE, 'MMDD'); 
--������ 10�� �̳��� ���� ���
SELECT * FROM PERSON WHERE TO_DATE(TO_CHAR(BIRTH,'MMDD'),'MMDD') - ROUND(SYSDATE,'DD') < 10 AND 
TO_DATE(TO_CHAR(BIRTH,'MMDD'),'MMDD') - ROUND(SYSDATE,'DD') >= 0;
--������ 1, 3, 6, 10���� ���
SELECT * FROM PERSON WHERE TO_CHAR(BIRTH,'MM') IN(1,3,6,10);
--���̰� 25�� �̻�
SELECT * FROM PERSON WHERE TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(TO_CHAR(BIRTH,'YYYY')) >= 25;