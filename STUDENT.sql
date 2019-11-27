--테이블의 모든 데이터 보기
SELECT * FROM EMPLOYEES; --select는 검색, *는 전부, From 테이블명, --는 주석

--테이블 생성
CREATE TABLE STUDENT (
NAME VARCHAR2(20),  --학생 이름, 문자열, 20바이트
KOR NUMBER(3),      --국어점수, 숫자, 3자리
ENG NUMBER(3),      --영어점수, 숫자, 3자리
MAT NUMBER(3)       --수학점수, 숫자, 3자리
);                  --오류 보고 중 ORA-00955를 검색해보면 알 수 있다.

--데이터 저장
INSERT INTO STUDENT (NAME, KOR,ENG, MAT) VALUES('홍길동', 100, 90, 80);
INSERT INTO STUDENT VALUES('홍길동', 100, 90, 80); -- 모든 컬럼에 데이터 넣을 때는 생략 가능
INSERT INTO STUDENT (NAME, KOR) VALUES('김길동', 100); -- 영어, 수학점수는 null로 아무것도 없는 상태. null은 0이 아니다.
--INSERT는 테이블 수가 늘어난다. INSERT INTO 테이블명(저장할 컬럼 이름) VALUES(값)
--문자열은 ' '로 표현하고 ()와 ()는 서로 타입에 맞춘다.

--데이터 검색
SELECT * FROM STUDENT; --STUDENT 테이블의 모든 데이터를 찾는다. 
SELECT NAME, KOR FROM STUDENT; --STUDENT 테이블에서 이름, 국어점수를 찾는다
--SELECT 컬럼명 FROM 테이블명 WHERE 조건; 

--데이터 수정
UPDATE STUDENT SET MAT = 85 WHERE NAME = '홍길동'; 
--UPDATE 테이블명 SET 바꾸고 싶은 것 WHERE 조건; 

--데이터 삭제
DELETE FROM STUDENT WHERE NAME = '홍길동';
--DELETE FROM 테이블명 WHERE 조건; 

--테이블 삭제
DROP TABLE STUDENT;
--DROP TABLE 테이블명







