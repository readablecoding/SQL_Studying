--<일반 함수>

--1)NVL로 NULL 값 처리하기
SELECT 
    ENAME, 
    SALARY, 
    COMMISSION,
    NVL(COMMISSION, 0),
    SALARY * 12 + NVL(COMMISSION, 0)
FROM 
    EMPLOYEE
ORDER BY JOB;

--2)NVL2로 NULL값 처리하기
SELECT 
    ENAME, 
    SALARY, 
    COMMISSION,
    NVL2(COMMISSION, SALARY * 12 + COMMISSION, SALARY * 12)
FROM 
    EMPLOYEE
ORDER BY JOB;

--3)DECODE로 부서이름 출력하기
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

--4)CASE로 부서이름 출력하기
SELECT ENAME, DNO,
    CASE WHEN DNO = 10 THEN 'ACCOUNTING'
        WHEN DNO = 20 THEN 'RESEARCH'
        WHEN DNO = 30 THEN 'SALES'
        WHEN DNO = 40 THEN 'OPERATIONS'
        ELSE 'DEFAULT'
        END AS DNAME
        FROM EMPLOYEE
        ORDER BY DNO;

--<혼자 해보기 04>
--6)사원들의 상관 사번을 출력하되 상관이 없는 사원에 대해서는 NULL값 대신 0으로 출력
SELECT 
    ENO, 
    NAME, 
    NVL2(MANAGER,MANAGER, 0) AS MANAGER
FROM 
    EMPLOYEE;
    
--7)DECODE 함수로 직급에 따라 급여를 인상. 직급이 ANAYLIST인 사원은 200, 'SALESMAN'인 사원은 180, 
--'MANAGER'인 사원은 150, 'CLERK'인 사원은 100을 인상
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
    
--<그룹함수>
--1)사원들의 급여 총액, 평균액, 최고액, 최소액 출력
SELECT SUM(SALARY) AS "급여총액"
        ,AVG(SALARY) AS "급여평균"
        ,MAX(SALARY) AS "최대급여"
        ,MIN(SALARY) AS "최소급여"
FROM
    EMPLOYEE;

--2)최근에 입사한 사원과 가장 오래전에 입사한 사원의 입사일 출력하기
SELECT 
    MAX(HIREDATE)
    , MIN(HIREDATE)
FROM
    EMPLOYEE;

--3)사원들의 커미션 총액 출력
SELECT 
    SUM(COMMISSION) AS "커미션 총액"
FROM 
    EMPLOYEE; --2200

--4)전체 사원의 수 구하기
SELECT COUNT(*) AS "사원의 수"
FROM EMPLOYEE; --14

--5)커미션을 받는 사원의 수 구하기
SELECT COUNT(COMMISSION) AS "커미션 받는 수 구하기"
FROM EMPLOYEE; --4

--6)직업 종류의 개수 출력하기
SELECT COUNT(DISTINCT JOB) AS "직업 종류의 개수"
FROM EMPLOYEE; --5

--<혼자 해보기> 05
--1)모든 사원의 급여 최고액, 최저액, 총액 및 평균 급여를 출력
--컬럼의 별칭은 결과 화면과 동일하게 지정하고 평균에 대해서는 정수로 반올림
SELECT MAX(SALARY) AS "MAXIMUM"
        ,MIN(SALARY) AS "MINIMUM"
        ,SUM(SALARY) AS "SUM"
        ,ROUND(AVG(SALARY)) AS "Average"
        FROM EMPLOYEE;

--2)각 담당 업무 유형별로 급여 최고액, 최저액, 총액 및 평균액을 출력.
--칼럼의 별칭은 결과 화면과 동일하게 지정하고 평균에 대해서는 정수로 반올림
SELECT JOB AS "Job"
        ,MAX(SALARY) AS "Maximum"
        ,MIN(SALARY) AS "Minimum"
        ,SUM(SALARY) AS "Sum"
        ,ROUND(AVG(SALARY)) AS "Average"
FROM 
    EMPLOYEE
GROUP 
    BY JOB;
    
--3)COUNT(*)함수를 이용하여 담당 업무가 동일한 사원 수를 출력
SELECT JOB, COUNT(*)
FROM EMPLOYEE
GROUP BY JOB;
--4)관리자 수를 나열. 칼럼의 별칭은 결과 화면과 동일
SELECT COUNT(MANAGER)
FROM EMPLOYEE;
--5)급여 최고액, 급여 최저액의 차액을 출력. 칼럼의 별칭은 결과 화면과 동일
SELECT MAX(SALARY) - MIN(SALARY) AS DIFFERENCE
FROM EMPLOYEE;


--<19.12.3 수업 복습>
--1)전화번호가 NULL이면 '0000으로 나타내기
SELECT NUM, NAME, NVL(PHONE, '0000') FROM PERSON;
--2)합격자 중에서 전화번호가 있으면 맨 앞 3자리만, 없으면 "000"으로
SELECT NAME
        , NVL2(PHONE, SUBSTR(PHONE, 0, 3),'000') PHONE
FROM
    PERSON
WHERE 
    PASS = 'O';
--3)PASS 컬럼에 'O'가 들어있으면 '합격', 'X'가 들어있으면 '불합격',그 외는 '미정'으로 처리
SELECT
    NAME
    ,DECODE(PASS, 'O', '합격'
                , 'X', '불합격'
                ,'미정') AS PASS
FROM
    PERSON;
--4)PASS 컬럼에 'O'가 들어있으면 '합격', 'X'가 들어있으면 '불합격',그 외는 '미정'으로 처리
SELECT 
    NAME
    ,(CASE
        WHEN PASS = 'O' THEN '합격'
        WHEN PASS = 'X' THEN '불합격'
        ELSE '미정'
    END) AS PASS
FROM
    PERSON;
--5)모든 지원자의 개수 합계, 평균, 최대값, 최소값
SELECT 
    COUNT(*)
    , SUM(EXAM)
    , ROUND(AVG(EXAM))
    , MAX(EXAM)
    , MIN(EXAM) 
FROM 
    PERSON;
--6)주소에 광주가 들어가는 사람 수 계산
SELECT 
    COUNT(*) 
FROM
    PERSON 
WHERE 
    ADDRESS LIKE '%광주%';
 
--7)시퀀스 활용 예제

--회원정보
CREATE TABLE MEMBER(
    ID VARCHAR(30) PRIMARY KEY              --ID -> 기본키로 중복 안되고 필수
    ,PASSWORD VARCHAR(20) NOT NULL          --비밀번호 -> 필수이므로 NOT NULL
    ,NAME VARCHAR(20) NOT NULL              --이름 -> 필수이므로 NOT NULL
    ,GENDER CHAR(1) DEFAULT 'M'             --성별: 남자 또는 여자이므로 CHAR, 
    ,PHONE VARCHAR2(30)                     --전화번호
    ,ADDRESS VARCHAR2(100)                  --주소
    ,EMAIL VARCHAR2(50)                     --이메일
);

INSERT INTO MEMBER VALUES('123', 'ABC', '홍길동', 'M', '010-1111-1111', '광주 광산구', 'ABC@ABC.COM');
INSERT INTO MEMBER VALUES('456', 'BBB', '박길동', 'F', '010-2222-2222', '서울 영등포구', 'BBB@MM.COM');
INSERT INTO MEMBER VALUES('666', 'TTT', '다나카', 'F', '010-9999-5555', '경기도 파주', 'RRR@UU.COM');
INSERT INTO MEMBER VALUES('555', 'CCC', '기무라', 'M', '010-6666-8888', '대구 달성구', 'GGG@HH.COM');
INSERT INTO MEMBER VALUES('789', 'UUU', '다니엘', 'F', '010-3434-5656', '미국 뉴욕', 'WWW@SS.COM');

--게시판 글 정보
CREATE TABLE BOARD(
    NUM         NUMBER PRIMARY KEY          --글번호
    ,ID         VARCHAR2(20) NOT NULL       --작성자 ID
    ,TITLE      VARCHAR2(200) NOT NULL      --글 제목
    ,CONTENTS   VARCHAR2(2000) NOT NULL      --내용
    ,INPUTDATE  DATE DEFAULT SYSDATE         --작성시간
    ,HITS       NUMBER DEFAULT 0            --조회수
    ,LIKES      NUMBER DEFAULT 0            --추천수
);

--게시판 글 번호에 사용할 시퀀스
CREATE SEQUENCE BOARD_SEQ;
--게시판 글 저장 예
INSERT INTO BOARD(NUM, ID, TITLE, CONTENTS) VALUES (BOARD_SEQ.NEXTVAL, '123', '제목', '내용');
INSERT INTO BOARD(NUM, ID, TITLE, CONTENTS) VALUES (BOARD_SEQ.NEXTVAL, '123', '안녕', '오랜만이네');
INSERT INTO BOARD(NUM, ID, TITLE, CONTENTS) VALUES (BOARD_SEQ.NEXTVAL, '555', '뭐해', '심심하네');
INSERT INTO BOARD(NUM, ID, TITLE, CONTENTS) VALUES (BOARD_SEQ.NEXTVAL, '789', '게임해', '재미있어');
INSERT INTO BOARD(NUM, ID, TITLE, CONTENTS) VALUES (BOARD_SEQ.NEXTVAL, '666', '좋겠네', '나도 하고 싶네');

--댓글 정보 테이블
CREATE TABLE REPLY(
    REPLYNUM NUMBER PRIMARY KEY,
    BOARDNUM NUMBER,
    ID VARCHAR2(2) NOT NULL,
    TEXT VARCHAR2(1000) NOT NULL,
    INPUTDATE DATE DEFAULT SYSDATE,
    CONSTRAINT REPLY_FK FOREIGN KEY (BOARDNUM) REFERENCES BOARD(NUM)
    ON DELETE CASCADE
);

--댓글 번호에 사용할 시퀀스
CREATE SEQUENCE REPLY_SEQ;
--저장 예
INSERT INTO REPLY(REPLYNUM, BOARDNUM, ID, TEXT) 
    VALUES (REPLY_SEQ.NEXTVAL, 1, '123', '첫 댓글');
INSERT INTO REPLY(REPLYNUM, BOARDNUM, ID, TEXT) 
    VALUES (REPLY_SEQ.NEXTVAL, 2, '555', '심심한 하루');





