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
DROP TABLE STUDENT;
--DROP TABLE ���̺��







