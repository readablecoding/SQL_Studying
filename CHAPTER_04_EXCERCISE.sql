--<CHAPTER 4 ȥ���غ���>--
--1)SUBSTR �Լ��� �̿��Ͽ� ������� �Ի��� �⵵�� �Ի��� �޸� ���
SELECT SUBSTR(HIREDATE,1,2) �⵵, SUBSTR(HIREDATE,4,2) �� FROM EMPLOYEE;

--2)SUBSTR �Լ��� �̿��Ͽ� 4���� �Ի��� ����� ���
SELECT * FROM EMPLOYEE WHERE SUBSTR(HIREDATE,4,2)='04';

--3)MOD �Լ��� �̿��Ͽ� �����ȣ�� ¦���� ����� ���
SELECT * FROM EMPLOYEE WHERE MOD(ENO, 2)= 0;

--4)�Ի����� ������ 2�ڸ�(YY), ���� ����(MON)�� ǥ���ϰ� ������ ���(DY)�� �����Ͽ� ���
SELECT TO_CHAR(HIREDATE,'YY/MON/DY') FROM EMPLOYEE;

--5)���� ��ĥ�� �������� ����Ͻÿ�. ���� ��¥���� ���� 1�� 1���� �� ����� ����ϰ� 
--TO_DATE �Լ��� ����Ͽ� ���������� ��ġ ��Ű�ÿ�
SELECT TRUNC(SYSDATE - TO_DATE('2019/01/01','YYYY/MM/DD')) FROM DUAL;

--6)������� ��� ����� ����ϵ� ����� ���� ����� ���켭�� NULL �� ��� 0���� ���
SELECT ENO, ENAME, NVL2(MANAGER, MANAGER, 0) AS MANAGER FROM EMPLOYEE;

--7)DECODE �Լ��� ���޿� ���� �޿��� �λ��ϵ��� �Ͻÿ�
--������ ANALYST�� ����� 200, SALESMAN�� ����� 180, MANAGER�� ����� 150,
--CLERK�� ����� 100�� �λ��Ͻÿ�
SELECT ENO, ENAME, JOB, SALARY, DECODE(JOB, 'ANALYST', SALARY+200, 
'MANAGER', SALARY+180, 'SALESMAN', SALARY+150, 'CLERK', SALARY+100, SALARY) AS UPADTE_SALARY
FROM EMPLOYEE;
