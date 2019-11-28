/*
<설치 순서>
1.JDK
2.오라클 SQL DELVELOPER
3.이클립스

<오라클 SQL DELVELOPER 설치 주의사항>
64비트로 다운
설치경로 확인
비밀번호: oracle

<오라클 작동 확인법>
검색창에 설정
설정창 위의 검색에 서비스라고 입력
로컬 서비스 보기
OracleServiceXE 상태가 실행 중인지 확인
OracleXETNSListener 상태가 실행 중인지 확인

<최초 접속>
sqlplus "as sysdba"하고 엔터
Enter user-name: sys
Enter password: 엔터 누르기

<락 풀기>
alter user hr identified by hr account unlock;

<접속 끊기>
exit

<다시 접속>
sqlplus하고 엔터
Enter user-name: hr 하고 엔터
Enter password: hr  하고 엔터

<현재 계정의 테이블 이름을 보는 명령어>
SELECT TNAME fROM TAB;

<SQL DEVELOPER 접속>
+ 누르기
접속이름: oracle11g
사용자이름: hr
비밀번호: hr
비밀번호 저장 체크
테스트
저장 
접속

<주의사항>
주석은 한 줄은 -- , 여러 줄은 자바와 같이 할 수 있다.
WHERE 조건 부분은 신중해야 한다. 잘못하면 데이터를 다 망치게 된다.
프로그램을 끝낼 때 변경사항 커밋을 하고 종료

<테이블의 모든 테이블 보기>
SELECT * FROM 테이블명;
*은 모든 것을 말한다.

<테이블 생성>
CREATE TABLE 테이블명 (컬럼네임 타입 (형식), 컬럼네임 타입 (형식), ....));
타입 중 문자열은 VARCHAR2이고 숫자는 NUMBER 이다
한글은 2~3바이트이므로 감안해서 ()에 들어갈 바이트 고민, 숫자는 정수, 실수 다 가능하고 형식은 몇 자리인지를 나타내는 것

<데이터 저장>
INSERT INTO 테이블명(컬럼네임, 컬럼네임, ....) VALUES (타입에 맞는 값, 타입에 맞는 값, ....)
()와 ()는 서로 형식이 맞아야 한다.

<데이터 검색>
SELECT 컬럼네임 FROM 테이블명 WHERE 조건; 

<데이터 수정>
UPDATE 테이블명 SET 바꾸고 싶은 부분 WHERE 조건;


<데이터 삭제>
DELETE FROM 테이블명 WHERE 조건;


<테이블 삭제>
DROP TABLE 테이블명;
*/
