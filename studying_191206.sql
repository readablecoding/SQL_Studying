--19/12/06 금

--<JOIN>
SELECT * FROM MEMBER M, BOARD B WHERE M.ID = B.ID;

--INNER JOIN
SELECT NUM, M.ID, M.NAME, B.TITLE FROM MEMBER M, BOARD B WHERE M.ID = B.ID;
SELECT NUM, M.ID, M.NAME, B.TITLE FROM MEMBER M INNER JOIN BOARD B ON M.ID = B.ID;

--RIGHT OUTER JOIN
SELECT NUM, M.ID, M.NAME, B.TITLE FROM MEMBER M, BOARD B WHERE M.ID(+) = B.ID;
SELECT NUM, M.ID, M.NAME, B.TITLE FROM MEMBER M RIGHT OUTER JOIN BOARD B ON M.ID = B.ID;

--LEFT OUTER JOIN
SELECT NUM, M.ID, M.NAME, B.TITLE FROM MEMBER M, BOARD B WHERE M.ID = B.ID(+);
SELECT NUM, M.ID, M.NAME, B.TITLE FROM MEMBER M LEFT OUTER JOIN BOARD B ON M.ID = B.ID;

--FULL OUTER JOIN
--SELECT NUM, M.ID, M.NAME, B.TITLE FROM MEMBER M, BOARD B WHERE M.ID(+) = B.ID(+); --이렇게는 쓰지 않는다
SELECT NUM, M.ID, M.NAME, B.TITLE FROM MEMBER M FULL OUTER JOIN BOARD B ON M.ID = B.ID;

--본문 글 번호/본문작성자 ID/본문 제목/리플 작성자 ID/리플내용 -> 없으면 NVL로 표현
SELECT B.NUM, B.ID, B.TITLE, NVL(R.ID, '없음') ID, NVL(R.TEXT,'없음') TEXT FROM BOARD B, REPLY R WHERE B.NUM = R.BOARDNUM(+);
--리플 작성자 ID/리플 작성자 이름/리플내용
SELECT M.ID, M.NAME, R.TEXT FROM MEMBER M, REPLY R WHERE M.ID = R.ID;
--ID별 리플 개수
SELECT 
    M.ID
    ,COUNT(*) "리플 수"
FROM 
    MEMBER M
    ,REPLY R
WHERE 
    M.ID = R.ID
GROUP BY 
    M.ID
    ,M.NAME
;

--HR 계정

--EMPLOYEES 테이블 전체
SELECT 
    *
FROM
    EMPLOYEES
;
--이름과 성을 포함해서 대소문자 구별없이 'DA'가 포함된 사람
SELECT 
    *
FROM 
    EMPLOYEES
WHERE 
    UPPER(FIRST_NAME || LAST_NAME) LIKE '%DA'
;
--급여가 5000~10000인 사람
SELECT
    *
FROM
    EMPLOYEES
WHERE
    SALARY BETWEEN 5000 AND 10000
;
--입사년도가 2005년인 사람
SELECT
    *
FROM
    EMPLOYEES
WHERE
    TO_CHAR(HIRE_DATE,'YYYY') = '2005'
;
--커미션 비율이 NULL인 사람
SELECT 
    *
FROM
    EMPLOYEES
WHERE
     COMMISSION_PCT IS NULL
;
--전화번호 앞 3자리만 출력
SELECT
    EMPLOYEE_ID
    ,FIRST_NAME
    ,LAST_NAME
    ,SUBSTR(PHONE_NUMBER,0,3)
FROM
    EMPLOYEES
;
--이름과 총 급여 출력
SELECT
    EMPLOYEE_ID
    ,(FIRST_NAME || ' ' || LAST_NAME) "이름"
    ,(SALARY + (SALARY * NVL(COMMISSION_PCT, 0))) "총 급여"
FROM
    EMPLOYEES
;

--<JOIN>
--사원이름과 부서번호,부서명,부서번호순으로 출력
SELECT
    E.FIRST_NAME
    ,E.LAST_NAME
    ,D.DEPARTMENT_NAME
    ,D.DEPARTMENT_ID
FROM
    EMPLOYEES E
    , DEPARTMENTS D
WHERE 
    E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY
    E.DEPARTMENT_ID
;

--사원이름/부서번호/부서명/도시명/국가명
SELECT
    (E.FIRST_NAME || ' ' || E.LAST_NAME) "사원이름"
    ,D.DEPARTMENT_ID
    ,D.DEPARTMENT_NAME
    ,L.CITY
    ,C.COUNTRY_NAME
FROM
    EMPLOYEES E
    ,DEPARTMENTS D
    ,LOCATIONS L
    ,COUNTRIES C
WHERE 
    E.DEPARTMENT_ID = D.DEPARTMENT_ID
    AND D.LOCATION_ID = L.LOCATION_ID
    AND L.COUNTRY_ID = C.COUNTRY_ID
;

--SALES 부서의 사원 수
SELECT
    COUNT(*) "SALES 부서의 사원 수"
FROM
    EMPLOYEES E
    ,DEPARTMENTS D
WHERE
    E.DEPARTMENT_ID = D.DEPARTMENT_ID
    AND D.DEPARTMENT_NAME LIKE 'Sales'
;
--90번 부서의 급여 평균
SELECT
    ROUND(AVG(SALARY))
FROM
    EMPLOYEES
WHERE
    DEPARTMENT_ID = 90;
--부서명/사원수/평균급여
SELECT
    D.DEPARTMENT_NAME "부서명"
    ,COUNT(*) "사원수"
    ,ROUND(AVG(SALARY)) "평균급여"
FROM
    EMPLOYEES E
    ,DEPARTMENTS D
WHERE
    E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY
    D.DEPARTMENT_NAME
ORDER BY
    D.DEPARTMENT_NAME
;
--도시별 사원수
SELECT
    L.CITY
    ,COUNT(*) "도시별 사원 수"
FROM
    EMPLOYEES E
    ,DEPARTMENTS D
    ,LOCATIONS L
WHERE 
    E.DEPARTMENT_ID = D.DEPARTMENT_ID
    AND D.LOCATION_ID = L.LOCATION_ID
GROUP BY
    L.CITY
ORDER BY
    L.CITY
;
--국가별 사원수
SELECT
    C.COUNTRY_NAME
    ,COUNT(*) "국가별 사원수"
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
--사원번호, 이름, 매니저 번호
SELECT
EMPLOYEE_ID "사원번호"
,(FIRST_NAME || ' ' || LAST_NAME) "이름"
,MANAGER_ID "매니저 번호"
FROM
EMPLOYEES
ORDER BY
EMPLOYEE_ID
;
--사원번호, 이름, 매니저번호, 매니저 이름
SELECT
    (E1.EMPLOYEE_ID) "사원번호"
    ,(E1.FIRST_NAME || ' ' || E1.LAST_NAME) "이름"
    ,(E2.MANAGER_ID) "매니저번호"
    ,(E2.FIRST_NAME || ' ' || E2.LAST_NAME) "매니저 이름"
FROM
    EMPLOYEES E1
    ,EMPLOYEES E2
WHERE
    E1.MANAGER_ID = E2.EMPLOYEE_ID
ORDER BY
    E1.EMPLOYEE_ID
;
--매니저 별로 팀원이 몇명인가?
SELECT
    E1.MANAGER_ID "매니저 ID"
    ,(E2.FIRST_NAME || ' ' || E2.LAST_NAME) "매니저 이름"
    ,COUNT(*) "매니저별로 팀원 수"
FROM
    EMPLOYEES E1
    ,EMPLOYEES E2
WHERE
    E1.MANAGER_ID = E2.EMPLOYEE_ID
GROUP BY
    E1.MANAGER_ID, E2.FIRST_NAME, E2.LAST_NAME --GROUP BY에 기술이 되어야 뽑고 싶은 것을 뽑을 수 있다.
ORDER BY
    E1.MANAGER_ID
;