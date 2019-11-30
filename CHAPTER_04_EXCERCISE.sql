--<CHAPTER 4 혼자해보기>--
--1)SUBSTR 함수를 이용하여 사원들의 입사한 년도와 입사한 달만 출력
SELECT SUBSTR(HIREDATE,1,2) 년도, SUBSTR(HIREDATE,4,2) 달 FROM EMPLOYEE;

--2)SUBSTR 함수를 이용하여 4월에 입사한 사원을 출력
SELECT * FROM EMPLOYEE WHERE SUBSTR(HIREDATE,4,2)='04';

--3)MOD 함수를 이용하여 사원번호가 짝수인 사람만 출력
SELECT * FROM EMPLOYEE WHERE MOD(ENO, 2)= 0;

--4)입사일을 연도는 2자리(YY), 월을 숫자(MON)로 표시하고 요일은 약어(DY)로 지정하여 출력
SELECT TO_CHAR(HIREDATE,'YY/MON/DY') FROM EMPLOYEE;

--5)올해 며칠이 지났는지 출력하시요. 현재 날짜에서 올해 1월 1일을 뺀 결과를 출력하고 
--TO_DATE 함수를 사용하여 데이터형을 일치 시키시오
SELECT TRUNC(SYSDATE - TO_DATE('2019/01/01','YYYY/MM/DD')) FROM DUAL;

--6)사원들의 상관 사번을 출력하되 상관이 없는 사원에 대헤서는 NULL 값 대신 0으로 출력
SELECT ENO, ENAME, NVL2(MANAGER, MANAGER, 0) AS MANAGER FROM EMPLOYEE;

--7)DECODE 함수로 직급에 따라 급여를 인상하도록 하시오
--직급이 ANALYST인 사원은 200, SALESMAN인 사원은 180, MANAGER인 사원은 150,
--CLERK인 사원은 100을 인상하시오
SELECT ENO, ENAME, JOB, SALARY, DECODE(JOB, 'ANALYST', SALARY+200, 
'MANAGER', SALARY+180, 'SALESMAN', SALARY+150, 'CLERK', SALARY+100, SALARY) AS UPADTE_SALARY
FROM EMPLOYEE;
