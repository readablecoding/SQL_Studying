--19/12/6 �ι�° �ð�
--HR ����

--EMPLOYEES ���̺� ��ü
SELECT 
    * 
FROM 
    EMPLOYEES;
--�̸��� ���� �����ؼ� ��ҹ��� �������� 'DA'�� ���Ե� ���
SELECT 
    * 
FROM 
    EMPLOYEES 
WHERE 
    UPPER(FIRST_NAME || LAST_NAME) LIKE '%DA'; --���ڿ� ����� ||�� ���
--�޿��� 5000~10000�� ���
SELECT 
    *
FROM
    EMPLOYEES 
WHERE SALARY BETWEEN 5000 AND 10000
;
--�Ի�⵵�� 2005���� ���
SELECT 
    * 
FROM 
    EMPLOYEES 
WHERE TO_CHAR(HIRE_DATE, 'YYYY') = '2005'
;
--Ŀ�̼� ������ NULL�� ���
SELECT 
    * 
FROM 
    EMPLOYEES 
WHERE 
    COMMISSION_PCT IS NULL;
--��ȭ��ȣ �� 3�ڸ��� ���
SELECT 
    EMPLOYEE_ID
    , FIRST_NAME
    , LAST_NAME
    , SUBSTR(PHONE_NUMBER,0,3) "��ȭ��ȣ �� 3�ڸ�" 
FROM 
    EMPLOYEES
;
--�̸��� �� �޿� ���
SELECT 
    EMPLOYEE_ID
    , (FIRST_NAME || ' ' || LAST_NAME) "�̸�"
    ,(SALARY +(SALARY * NVL(COMMISSION_PCT,0))) "�� �޿�"  
FROM 
    EMPLOYEES
;

--<JOIN>
--����̸��� �μ���ȣ,�μ���,�μ���ȣ������ ���
SELECT 
    E.FIRST_NAME
    , E.LAST_NAME
    , D.DEPARTMENT_NAME
    , D.DEPARTMENT_ID
FROM 
    EMPLOYEES E, DEPARTMENTS D
WHERE 
    E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY 
    E.DEPARTMENT_ID
;

--����̸�/�μ���ȣ/�μ���/���ø�/������  -->4���� ���̺��� ���ϱ� ������ 3���� ����.
SELECT 
    E.FIRST_NAME
    ,E.LAST_NAME 
    ,D.DEPARTMENT_ID
    ,D.DEPARTMENT_NAME
    ,L.CITY
    ,C.COUNTRY_NAME
FROM
    EMPLOYEES E
    , DEPARTMENTS D
    , LOCATIONS L
    , COUNTRIES C
WHERE 
    E.DEPARTMENT_ID = D.DEPARTMENT_ID
    AND D.LOCATION_ID = L.LOCATION_ID
    AND L.COUNTRY_ID = C.COUNTRY_ID
;

--SALES �μ��� ��� ��
SELECT 
    COUNT(*) "SALES �μ��� �����" 
FROM 
    EMPLOYEES E
    , DEPARTMENTS D 
WHERE 
    E.DEPARTMENT_ID = D.DEPARTMENT_ID 
    AND D.DEPARTMENT_NAME LIKE 'Sales'
;
--90�� �μ��� �޿� ���
SELECT 
    AVG(SALARY)
FROM 
    EMPLOYEES 
WHERE 
    DEPARTMENT_ID = 90;

--�μ���/�����/��ձ޿�
SELECT 
    D.DEPARTMENT_NAME "�μ���"
    , COUNT(*) "�����" 
    , ROUND(AVG(E.SALARY)) "��ձ޿�"
FROM 
    EMPLOYEES E
    , DEPARTMENTS D 
WHERE 
    E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY 
    D.DEPARTMENT_NAME
ORDER BY 
    D.DEPARTMENT_NAME
 ;

--���ú� �����
SELECT 
    L.CITY
    ,COUNT(*) "���ú� ��� ��"
FROM
    EMPLOYEES E
    , DEPARTMENTS D
    , LOCATIONS L
WHERE
    E.DEPARTMENT_ID = D.DEPARTMENT_ID
    AND D.LOCATION_ID = L.LOCATION_ID
GROUP BY
    L.CITY
ORDER BY
    L.CITY
;

--������ �����
SELECT 
    C.COUNTRY_NAME
    ,COUNT(*) "������ �����"
    
FROM 
    EMPLOYEES E
    ,DEPARTMENTS D
    ,LOCATIONS L
    ,COUNTRIES C
WHERE
    E.DEPARTMENT_ID = D.DEPARTMENT_ID
    AND D.LOCATION_ID = L.LOCATION_ID
    AND L.COUNTRY_ID = C.COUNTRY_ID
GROUP BY
    C.COUNTRY_NAME
ORDER BY
    C.COUNTRY_NAME
;
    
--�����ȣ, �̸�, �Ŵ��� ��ȣ
SELECT EMPLOYEE_ID, LAST_NAME, MANAGER_ID FROM EMPLOYEES;

--�����ȣ, �̸�, �Ŵ�����ȣ, �Ŵ��� �̸� -> ���� �ٸ� ���̺���ô �ϴ� ��
SELECT 
    E1.EMPLOYEE_ID
    , E1.LAST_NAME
    , E1.MANAGER_ID
    , E2.LAST_NAME
FROM 
    EMPLOYEES E1
    , EMPLOYEES E2 --��Ī�� 2�� ����
WHERE 
    E1.MANAGER_ID = E2.EMPLOYEE_ID
;

--�Ŵ������� ������ ����ΰ�?
SELECT
    E1.MANAGER_ID
    ,COUNT(*) "�Ŵ������� ���� ��"
FROM
    EMPLOYEES E1
    , EMPLOYEES E2
WHERE 
    E1.MANAGER_ID = E2.EMPLOYEE_ID
GROUP BY
    E1.MANAGER_ID
ORDER BY
    E1.MANAGER_ID
;
    

