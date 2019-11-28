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
SELECT * FROM PERSON; -- *은 칼럼 전부
SELECT NUM, NAME, BIRTH FROM PERSON;
SELECT * FROM PERSON WHERE PASS = '0';
SELECT NUM, NAME FROM PERSON WHERE EXAM = 100; 
SELECT NUM, NAME, (EXAM*10) SCORE  FROM PERSON; 
--SCORE는 EXAM * 10인데 깔끔하게 보이게 만든 것. 컬럼에 들어있는 숫자 * 10한 값을 가져온다. 테이블에 없는 데이터 만듦
DESC PERSON; --테이블의 구조를 보여줌


--<where 조건 사용>
SELECT * FROM PERSON WHERE NAME LIKE '홍%';          --성이 '홍'씨인 사람
SELECT * FROM PERSON WHERE NAME LIKE '%길동';        --이름이 '길동'인 사람
SELECT * FROM PERSON WHERE EXAM BETWEEN 50 AND 70;   --시험점수가 50 ~ 70점
SELECT * FROM PERSON WHERE BIRTH = '95-11-2';         --생년월일이 '95/11/2'인 사람
SELECT * FROM PERSON WHERE PASS = '0' AND EXAM <= 60; --합격자 중에서 시험 점수가 60점 이하인 사람
SELECT * FROM PERSON WHERE PASS IS NULL;              --합격여부가 NULL인 사람
SELECT * FROM PERSON WHERE NAME LIKE '김%' AND ADDRESS LIKE '%광주%';  --'김'씨 중에서 광주 거주
SELECT NAME, (EXAM / 10) SCORE FROM PERSON WHERE PASS = 'O';  --합격자들의 이름과 점수를 출력 (점수는 10점 만점으로 환산해서 출력)


