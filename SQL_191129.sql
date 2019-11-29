--<지원자 정보 테이블>
CREATE TABLE PERSON(
NUM NUMBER PRIMARY KEY,          --지원자 번호(일련번호), ()가 없으면 최대 크기, PRIMARY KEY는 기본키로 중복안됨
NAME VARCHAR2(20)NOT NULL,       --이름, 필수 입력 항목이므로 NOT NULL
BIRTH DATE,                      --생년월일
PHONE VARCHAR2(20),              --전화번호
ADDRESS VARCHAR(200),            --주소
EXAM NUMBER(3) DEFAULT 0,       --시험점수(100점 만점 점수), 입력 안하면 0점으로 할 때 DEFAULT 0 사용
INTERVIEW NUMBER(3,1) DEFAULT 0, --면접점수(10점 만점 실수), 입력 안하면 0점으로 할 때 DEFAULT 0 사용
PASS CHAR(1)                     --합격여부(합/불 중의 하나로 O, X)
);

--<데이터 저장>
INSERT INTO PERSON VALUES(1, '홍길동', '95-11-2', '010-1111-1111', '광주시 광산구 111', 100, 5.5, '0');
INSERT INTO PERSON (NUM, NAME, BIRTH) VALUES (2, '김철수', '96-1-2');
INSERT INTO PERSON VALUES(3, '심청이', '96-5-20', '010-2222-2222', '서울 용산', 60, 6.1, 'X');
INSERT INTO PERSON (NUM, NAME, PHONE, INTERVIEW) VALUES(4, '도련님','010-3333-3333', 7.8);
INSERT INTO PERSON (NUM, NAME, PASS) VALUES(5, '토끼', 'O');
INSERT INTO PERSON VALUES(6, '심봉사', '85-3-10', '010-8888-8888', '강원도 삼척', 50, 5.6, 'O');
INSERT INTO PERSON VALUES(7, '마이클', '00-8-15', '010-6666-6666', '미국 시애틀', 85, 8.2, 'O');
INSERT INTO PERSON (NUM, NAME, ADDRESS, INTERVIEW) VALUES(8, '트럼프', '미국 뉴욕', '9.0');
INSERT INTO PERSON VALUES(9, '다나카', '80-9-5', '010-0000-5555', '일본 도쿄', 89, 6.8, 'X');
INSERT INTO PERSON VALUES(10, '아베', '60-10-23', '010-5555-8888', '일본 도쿄', 95, 9.5, 'O');
INSERT INTO PERSON VALUES(11, '김길동', '95-11-22', '010-1111-1111', '광주시 광산구 111', 100, 5.5, 'X');
INSERT INTO PERSON VALUES(12, '최길동', '95-11-22', '010-1111-1111', '경기도 광주시 111', 100, 5.5, '0');

--<조건 검색>
SELECT * FROM PERSON; -- *은 칼럼 전부, PERSON의 모든 행
SELECT NUM, NAME, BIRTH FROM PERSON; 
SELECT * FROM PERSON WHERE PASS = '0';
SELECT NUM, NAME FROM PERSON WHERE EXAM = 100;  --where을 붙이면 일부 행만 나온다.
SELECT NUM, NAME, (EXAM*10) SCORE  FROM PERSON; 
--SCORE는 EXAM * 10인데 깔끔하게 보이게 만든 것. 컬럼에 들어있는 숫자 * 10한 값을 가져온다. 테이블에 없는 데이터 만듦
DESC PERSON; --테이블의 구조를 보여줌


--<where 조건 사용>
SELECT * FROM PERSON WHERE NAME LIKE '홍%';          --성이 '홍'씨인 사람, =는 정확히 일치할 때만 쓴다. 
SELECT * FROM PERSON WHERE NAME LIKE '%길동';        --이름이 '길동'인 사람
SELECT * FROM PERSON WHERE EXAM BETWEEN 50 AND 70;   --시험점수가 50 ~ 70점
--SELECT * FROM PERSON WHERE EXAM >= 50 AND EXAM <= 70; -> 같은 방법
SELECT * FROM PERSON WHERE BIRTH = '95-11-2';         --생년월일이 '95/11/2'인 사람 -> -을 사용하면 날짜 타입으로 변환해준다. 
SELECT * FROM PERSON WHERE PASS = '0' AND EXAM <= 60; --합격자 중에서 시험 점수가 60점 이하인 사람 -> 조건이 계속 있다면 AND, OR 사용, 복잡하면 () 사용
SELECT * FROM PERSON WHERE PASS IS NULL;              --합격여부가 NULL인 사람 -> IS NULL을 사용하면 NULL인 것을 찾아냄, 
SELECT * FROM PERSON WHERE NAME LIKE '김%' AND ADDRESS LIKE '광주%';  --'김'씨 중에서 광주 거주
SELECT (NAME || '씨') NAME, (EXAM / 10) EXAM FROM PERSON WHERE PASS = 'O';  
--합격자들의 이름과 점수를 출력 (점수는 10점 만점으로 환산해서 출력), 이름에 '씨'가 붙어 나오려면 || '씨' 라고 붙인다.

---------------함수---------------
SELECT EXAM + INTERVIEW FROM PERSON; --테이블에 있는 행만큼 계산을 반복한다. 행 수가 100이라면 100번 반복
SELECT * FROM PERSON WHERE UPPER(PASS) = UPPER('O'); --PASS라는 칼럼에 영문이 있는데 대문자로 바꾸는 것. 테이블의 내용을 바꾸는 것은 아니다. 비교하기 위해 하나로 통일
SELECT NAME, UPPER(PASS) PASS FROM PERSON; --PASS에 들어있는 문자를 대문자로 바꾸고 컬럼 이름을 PASS로 바꿈
SELECT NAME, LENGTHB(NAME) LEN FROM PERSON; --NAME 칼럼의 문자 바이트 길이를 보여주고 LEN이라고 이름 변경
SELECT NAME, BIRTH, CONCAT(NAME, BIRTH) NEWNAME FROM PERSON; --CONCAT은 문자 이어주는 것
SELECT NAME, SUBSTR(BIRTH, 4, 7) BIRTH FROM PERSON; --SUBSTR은 특정위치 문자를 잘라내 보여줌
SELECT NAME, SUBSTRB(BIRTH, 4, 7) BIRTH FROM PERSON; --SUBSTRB은 특정위치 문자를 잘라내 보여줌, 바이트 형태로 보여줌
SELECT NAME, INSTR (NAME, '길동')FIND길동 FROM PERSON; --INSTR은 위치 값을 반환
SELECT NAME, MOD(EXAM, 3), ROUND(INTERVIEW/3,2) FROM PERSON; 
--MOD(칼럼명, 숫자)는 나머지를 보여주고, ROUND(값, 숫자)는 반올림하는 것
--EXAM을 3으로 나운 나머지, INTERVIEW를 3으로 나눠 소수점 둘째 자리 반올림, 이런 계산 오라클에서 하는 것이 편하다
SELECT 1+1 FROM DUAL; ---1행 1열짜리 안 쓰는 테이블 DUAL 을 대상으로 1+1의 결과를 처리함. 1번 계산하는 용도, 한 칸짜리 표, 다른 쿼리문에 사용
SELECT * FROM DUAL; 
SELECT BIRTH,TO_CHAR(BIRTH,'YY-MM-DD HH:MI:SS') FROM PERSON; --_TO_CHAR(칼럼명 또는 데이터 수식, '형식')
SELECT BIRTH,TO_CHAR(BIRTH,'MM"월" DD"일"') FROM PERSON; --한글은 오류가 나니 " "를 붙인다. 칼럼명의 데이터를 뒤에 쓴 형식으로 지정

INSERT INTO PERSON (NUM, NAME, BIRTH) VALUES(13, '김영희', TO_DATE('990101','YY-MM-DD')); 
--TO_DATE는 TO_CHAR와 다르게 형식이 반대다. 들어온 형태를 뒤의 바꿀 형식으로 바꾼다.

SELECT SYSDATE FROM DUAL; --현재 시간을 DUAL에 가져온다. -> 오늘 날짜를 보여준다. 19/11/29 
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL; --2019-11-29 10:47:00
SELECT SYSDATE -1 FROM DUAL; --19/11/28 -> 어제 날짜, 1은 하루의 의미다.
SELECT ROUND(SYSDATE - TO_DATE('19-10-29', 'YY-MM-DD'),0) DAY_DIFF FROM DUAL; 
--날짜끼리 빼기를 한 것. 31.45041666666666666666666666666666666667
--반나절은 0.5로 12시간이다. ROUND를 써서 반올림하는데 0을 넣으면 일 단위 숫자로 보여줌

SELECT * FROM PERSON WHERE BIRTH ='10-11-22'; --시, 분, 초가 0으로 처리됨, 이러면 원하는 결과가 안 나옴
--숫자로 범위 비교, 크다는 것은 이후 시간이고, 작다는 것은 이전 시간
SELECT * FROM PERSON WHERE BIRTH > TO_DATE('921122', 'YYMMDD'); -- BIRTH를 '921122'은 입력받은 것으로 YYMMDD로 변환한 것과 비교
--크다는 것은 92년 11월 22일 이후라는 것이고 작다는 것은 92년 11월 22일 이전을 말한다. 같은 것은 찾기 힘들다. 시분초 비교가 힘들어서
--최근 3일간 날짜로 되어 있는 것
SELECT * FROM PERSON WHERE BIRTH > SYSDATE - 3; -- 최근 3일간에 해당하는 경우 찾기
--DATE타입 기준으로 찾아야 한다.
--11월생인 사람 -> 날짜 타입으로 하기 곤란한 것도 있다. 문자열로 변환하는 것이 좋다
SELECT * FROM PERSON WHERE TO_CHAR(BIRTH, 'MM')= '11'; --생일이 11월인 사람을 찾기
--오늘이 생일인 사람
SELECT * FROM PERSON WHERE TO_CHAR(BIRTH,'MMDD')= TO_CHAR(SYSDATE, 'MMDD'); 
--생일이 10일 이내로 남은 사람
SELECT * FROM PERSON WHERE TO_DATE(TO_CHAR(BIRTH,'MMDD'),'MMDD') - ROUND(SYSDATE,'DD') < 10 AND 
TO_DATE(TO_CHAR(BIRTH,'MMDD'),'MMDD') - ROUND(SYSDATE,'DD') >= 0;
--생일이 1, 3, 6, 10월인 사람
SELECT * FROM PERSON WHERE TO_CHAR(BIRTH,'MM') IN(1,3,6,10);
--나이가 25세 이상
SELECT * FROM PERSON WHERE TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) - TO_NUMBER(TO_CHAR(BIRTH,'YYYY')) >= 25;