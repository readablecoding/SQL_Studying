--���̺��� ��� ������ ����
SELECT * FROM EMPLOYEES; --select�� �˻�, *�� ����, From ���̺��, --�� �ּ�

--���̺� ����
CREATE TABLE STUDENT (
NAME VARCHAR2(20),  --�л� �̸�, ���ڿ�, 20����Ʈ
KOR NUMBER(3),      --��������, ����, 3�ڸ�
ENG NUMBER(3),      --��������, ����, 3�ڸ�
MAT NUMBER(3)       --��������, ����, 3�ڸ�
);                  --���� ���� �� ORA-00955�� �˻��غ��� �� �� �ִ�.

--������ ����
INSERT INTO STUDENT (NAME, KOR,ENG, MAT) VALUES('ȫ�浿', 100, 90, 80);
INSERT INTO STUDENT VALUES('ȫ�浿', 100, 90, 80); -- ��� �÷��� ������ ���� ���� ���� ����
INSERT INTO STUDENT (NAME, KOR) VALUES('��浿', 100); -- ����, ���������� null�� �ƹ��͵� ���� ����. null�� 0�� �ƴϴ�.
--INSERT�� ���̺� ���� �þ��. INSERT INTO ���̺��(������ �÷� �̸�) VALUES(��)
--���ڿ��� ' '�� ǥ���ϰ� ()�� ()�� ���� Ÿ�Կ� �����.

--������ �˻�
SELECT * FROM STUDENT; --STUDENT ���̺��� ��� �����͸� ã�´�. 
SELECT NAME, KOR FROM STUDENT; --STUDENT ���̺��� �̸�, ���������� ã�´�
--SELECT �÷��� FROM ���̺�� WHERE ����; 

--������ ����
UPDATE STUDENT SET MAT = 85 WHERE NAME = 'ȫ�浿'; 
--UPDATE ���̺�� SET �ٲٰ� ���� �� WHERE ����; 

--������ ����
DELETE FROM STUDENT WHERE NAME = 'ȫ�浿';
--DELETE FROM ���̺�� WHERE ����; 

--���̺� ����
--DROP TABLE STUDENT;
--DROP TABLE ���̺��

--���̺� ���� ����
DESC STUDENT;
--DESE ���̺��: ���̺��� � ������ �ƴ��� ���δ�.


--<ADDRESS_VO ���̺� �����>

--���̺� �����
CREATE TABLE ADDRESS_VO(
NUM NUMBER(3),
NAME VARCHAR2(20),
PHONE VARCHAR2(100),
ADDRESS VARCHAR2(100)
);

--������ ����
INSERT INTO ADDRESS_VO (NUM, NAME, PHONE, ADDRESS) VALUES (1, '��', '000-0000-0000', '����');
INSERT INTO ADDRESS_VO (NUM, NAME, PHONE, ADDRESS) VALUES (2, '��', '111-1111-1111', '���');
INSERT INTO ADDRESS_VO (NUM, NAME, PHONE, ADDRESS) VALUES (3, '��', '222-2222-2222', '��õ');

--������ �˻�
SELECT * FROM ADDRESS_VO;

--������ ����
UPDATE ADDRESS_VO SET NUM = 4 WHERE NAME = '��';

--������ ����
DELETE FROM ADDRESS_VO WHERE NAME = '��';






