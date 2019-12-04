--회원정보
CREATE TABLE MEMBER(
    ID          VARCHAR2(30) PRIMARY KEY,    --ID, 기본키: 중복안되고 필수
    PASSWORD    VARCHAR2(20) NOT NULL,       --비밀번호, 필수
    NAME        VARCHAR2(20) NOT NULL,       --이름, 필수
    GENDER      CHAR(1) DEFAULT 'M',         --성별
    PHONE       VARCHAR2(30),                --전화번호
    ADDRESS     VARCHAR2(100),                --주소 지역
    EMAIL       VARCHAR2(50)                --이메일
);

INSERT INTO MEMBER VALUES('123', 'ABC', '홍길동', 'M', '010-1111-1111', '광주 광산구', 'ABC@ABC.COM');
INSERT INTO MEMBER VALUES('456', 'BBB', '박길동', 'F', '010-2222-2222', '서울 영등포구', 'BBB@MM.COM');
INSERT INTO MEMBER VALUES('666', 'TTT', '다나카', 'F', '010-9999-5555', '경기도 파주', 'RRR@UU.COM');
INSERT INTO MEMBER VALUES('555', 'CCC', '기무라', 'M', '010-6666-8888', '대구 달성구', 'GGG@HH.COM');
INSERT INTO MEMBER VALUES('789', 'UUU', '다니엘', 'F', '010-3434-5656', '미국 뉴욕', 'WWW@SS.COM');


--게시판 글 정보
CREATE TABLE BOARD(
    NUM         NUMBER PRIMARY KEY,             --글번호
    ID           VARCHAR2(20) NOT NULL,         --작성자 ID
    TITLE        VARCHAR2(200) NOT NULL,        --제목
    CONTENTS    VARCHAR2(2000) NOT NULL,        --내용
    INPUTDATE   DATE DEFAULT SYSDATE,           --작성시간 -> 저장되는 순간의 시간
    HITS        NUMBER DEFAULT 0,               --조회수
    LIKES       NUMBER DEFAULT 0                --추천수
);

--게시판 글 번호에 사용할 시퀀스 ->번호만 내놓는다.
CREATE SEQUENCE BOARD_SEQ;
--게시판 글 저장 예       
INSERT INTO BOARD(NUM, ID, TITLE, CONTENTS) VALUES (BOARD_SEQ.NEXTVAL, '123', '제목', '내용');
INSERT INTO BOARD(NUM, ID, TITLE, CONTENTS) VALUES (BOARD_SEQ.NEXTVAL, '123', '안녕', '오랜만이네');
INSERT INTO BOARD(NUM, ID, TITLE, CONTENTS) VALUES (BOARD_SEQ.NEXTVAL, '555', '뭐해', '심심하네');
INSERT INTO BOARD(NUM, ID, TITLE, CONTENTS) VALUES (BOARD_SEQ.NEXTVAL, '789', '게임해', '재미있어');
INSERT INTO BOARD(NUM, ID, TITLE, CONTENTS) VALUES (BOARD_SEQ.NEXTVAL, '666', '좋겠네', '나도 하고 싶네');
---> BOARD_SEQ.NEXTVAL할 때마다 번호가 1씩 늘어난다. 번호를 다시 되돌릴 수 없다.

--SELECT BOARD_SEQ.NEXTVAL FROM DUAL; --번호만 살짝 얻어온다.

--댓글 정보 테이블
CREATE TABLE REPLY(
    REPLYNUM NUMBER PRIMARY KEY, --댓글 테이블의 일련번호
    BOARDNUM NUMBER,              --댓글이 달린 본문 글번호
    ID VARCHAR2(20) NOT NULL, --작성자
    TEXT VARCHAR2(1000) NOT NULL, --댓글 내용
    INPUTDATE DATE DEFAULT SYSDATE, --작성일
    CONSTRAINT REPLY_FK FOREIGN KEY (BOARDNUM) REFERENCES BOARD(NUM)
    ON DELETE CASCADE --BOARDNUM이 BOARD테이블의 NUM 칼럼을 참조한다. 본문이 삭제될 때 ON DELETE CASCADE를 하면 딸린 애들도 다 삭제된다.
);

--댓글 번호에 사용할 시퀀스 
CREATE SEQUENCE REPLY_SEQ;
--저장 예
INSERT INTO REPLY(REPLYNUM, BOARDNUM, ID, TEXT) 
    VALUES (REPLY_SEQ.NEXTVAL, 1, '123', '첫 댓글');
INSERT INTO REPLY(REPLYNUM, BOARDNUM, ID, TEXT) 
    VALUES (REPLY_SEQ.NEXTVAL, 2, '555', '심심한 하루');
INSERT INTO REPLY(REPLYNUM, BOARDNUM, ID, TEXT) 
    VALUES (REPLY_SEQ.NEXTVAL, 2, '789', '재밌는 하루');
INSERT INTO REPLY(REPLYNUM, BOARDNUM, ID, TEXT) 
    VALUES (REPLY_SEQ.NEXTVAL, 2, '666', '즐거운 하루');
INSERT INTO REPLY(REPLYNUM, BOARDNUM, ID, TEXT) 
    VALUES (REPLY_SEQ.NEXTVAL, 2, '123', '바이바이');
    
--19/12/4 수    
--<데이터 수정>
--게시판 1번 글의 제목을 'oracle'로 변경
UPDATE BOARD SET TITLE = 'oracle' WHERE NUM = 1;
--게시판 2번 글의 조회수를 10으로,추천수를 5로 변경
UPDATE BOARD SET HITS = 10, LIKES = 5 WHERE NUM = 2;
--게시판 2번 글의 조회수를 1 증가
UPDATE BOARD SET HITS = HITS + 1 WHERE NUM = 2;
--게시판의 123유저가 쓴 내용을 바꿈
UPDATE BOARD SET CONTENTS = '하루의 시작' WHERE ID = '123';

--<데이터 삭제>
--DELETE FROM BOARD WHERE NUM > 1;

--ROLLBACK; --마지막 커밋 한 시점으로 돌아가는 명령어, DELETE와 COMMIT을 같이 했다면 복구 불가능


--<데이터 검색>
--작성자 ID와 추천수를 "홍길동씨 추천10회" 형식으로 검색
SELECT ((ID) || '씨') ID,('추천' || (LIKES) || '회') LIKES FROM BOARD;  -->조건이 있다면 WHERE 붙이고 조건 붙임
--'aaa'가 쓴 모든 글
SELECT * FROM BOARD WHERE ID = 'aaa'; --일부 일치는 LIKE 사용
--19년 12월 1일 이후의 글
SELECT * FROM BOARD WHERE INPUTDATE > '19/12/01'; -- '19/12/01'보다 크다고 하면 12월 1일 0시 0분 0초보다 크다는 것. =는 쓸 일이 없다.
--조회수가 10~15 사이인 글
SELECT * FROM BOARD WHERE HITS BETWEEN 10 AND 15;
--조회수가 10이상이고 추천수가 5 이상인 글
SELECT * FROM BOARD WHERE HITS >= 10 and LIKES >= 5;
--오늘 쓴 글
SELECT * FROM BOARD WHERE TRUNC(SYSDATE) <= INPUTDATE; --SYSDATE는 지금 시간이 나온다. TRUNC(SYSDATE)는 일 단위는 자른다. 
--올해 쓴 글
SELECT * FROM BOARD WHERE TO_CHAR(SYSDATE,'YYYY') = TO_CHAR(INPUTDATE,'YYYY');
--전체 글의 조회수 평균
SELECT AVG(HITS) AS "조회수 평균" FROM BOARD; 
--이번달에 쓴 글의 개수
SELECT COUNT(*) AS "개수" FROM BOARD WHERE TO_CHAR(SYSDATE,'YYMM') = TO_CHAR(INPUTDATE,'YYMM');
--ID에 'b'가 들어가지 않은 회원의 글들
SELECT * FROM BOARD WHERE ID NOT LIKE '%b%'; --와일드 카드 쓸 때는 꼭 LIKE를 써야 한다.
--SELECT * FROM BOARD WHERE NOT(ID LIKE '%b%'); --NOT 연산자로 결과를 바꿈

--<그룹함수>
SELECT COUNT(*) FROM BOARD WHERE ID = 'aaa'; --board 테이블에서 id가 aaa인 사람이 쓴 글의 개수
SELECT ID, COUNT(*) FROM BOARD GROUP BY ID; --id 칼럼을 기준으로 묶어서 나타냄, GROUP BY는 행 개수가 맞지 않아도 다른 칼럼 사용 가능

--연도별 글 개수
SELECT 
    (TO_CHAR(INPUTDATE,'YYYY') || '년') AS "연도" 
    ,COUNT(*) AS "연도별 글 개수" 
FROM 
    BOARD 
GROUP BY 
    TO_CHAR(INPUTDATE,'YYYY');
    
--올해의 월별 조회수 평균
SELECT 
    (TO_CHAR(INPUTDATE,'MM') || '월') AS "월" 
    ,AVG(HITS) AS "조회수 평균" 
FROM 
    BOARD 
GROUP BY 
    TO_CHAR(INPUTDATE,'MM');
    
--올해 이번달의 조회수 평균이 10이상인 경우
SELECT 
    (TO_CHAR(INPUTDATE,'MM') || '월') AS INPUTDATE --GROUP BY를 한 것을 다시 써 어떤 것인지 알게끔 한다.
    ,AVG(HITS) AS "조회수 평균" 
FROM 
    BOARD 
WHERE 
    INPUTDATE >= TRUNC(SYSDATE,'YYYY') --올해만 놔두고 나머지는 버림.연도까지는 살리고 월, 일을 버리려면 TRUNC(SYSDATE,'YYYY')로 표현
GROUP BY 
    TO_CHAR(INPUTDATE,'MM') --월별로 묶는다. WHERE 조건에 맞는 것 중에서 GROUP BY로 묶음
HAVING
    AVG(HITS)>= 10 --조회수가 10이상인 것만 나타내도록 함
ORDER BY 
    INPUTDATE;
--순서: WHERE -> GROUP BY -> HAVING -> ORDER BY
--HAVING은 단독으로 나올 수 없다. GROUP BY의 결과를 통해 사용하므로
--마지막으로 ORDER BY로 정렬

--<정렬>
SELECT * FROM BOARD ORDER BY NUM; --생략하면 오름차순(ASC), 오름차순이 기본이다.
SELECT * FROM BOARD ORDER BY NUM DESC; --내림차순으로 하려면 ORDER BY 컬럼명 DESC
SELECT * FROM BOARD ORDER BY ID, INPUTDATE DESC; --아이디는 내림차순으로 정렬, 같은 아이디가 있으면 그 중 INPUTDATE로 역순으로다시 정렬


--게시판에 글을 한번이라도 쓴 회원의 ID를 알파벳 순서대로 출력
SELECT DISTINCT ID FROM BOARD ORDER BY ID; --DISTICT로 ID 중복 제거, ID를 오름차순(A~Z)으로 정렬