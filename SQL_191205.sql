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
    INPUTDATE   DATE DEFAULT SYSDATE,           --작성시간 -> 저장되는 순간의 시간으로 년월일시분초, 입력 안하면 디폴트로 현재시간 들어감
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


--19/12/5 목
--게시판에 글을 한번이라도 쓴 회원의 ID를 알파벳 순서대로 출력
SELECT DISTINCT ID FROM BOARD ORDER BY ID; --DISTICT로 ID 중복 제거, ID를 오름차순(A~Z)으로 정렬

--[회원 정보에서]
--전체 회원목록을 ID 순서로 출력
SELECT * FROM MEMBER ORDER BY ID;
--ID가 'aaa'인 회원의 정보 출력
SELECT * FROM MEMBER WHERE ID = 'aaa';
--이메일 주소에 'naver'가 포함된 회원
SELECT * FROM MEMBER WHERE EMAIL LIKE '%naver%';
--이메일 주소가 'naver.com'으로 끝나는 회원
SELECT * FROM MEMBER WHERE EMAIL LIKE '%naver.com';
--회원 ID와 전화번호의 앞자리 3자 출력
SELECT ID, SUBSTR(PHONE,0,3) FROM MEMBER;
--회원 ID와 그 회원 ID의 글자 수 출력
SELECT ID, LENGTH(ID) FROM MEMBER;

--[게시판 글 정보에서]
--글 번호가 10~20번인 글
SELECT * FROM BOARD WHERE NUM BETWEEN 10 AND 20;

--각 글의 추천수 / 조회수, 소수점 둘째자리에서 반올림
SELECT NUM, ROUND(LIKES / HITS * 100, 1) "추천비율" FROM BOARD WHERE NUM = 7;
--1번째 방법
SELECT 
    NUM,
    CASE
        WHEN HITS  IS NULL THEN 0
        WHEN HITS = 0 THEN 0
        ELSE ROUND(LIKES / HITS * 100, 1)
        END "추천 비율"
FROM BOARD;

--2번째 방법
SELECT
    NUM, 
    CASE WHEN NVL(LIKES, 0) != 0 THEN ROUND(LIKES / HITS * 100, 1) 
    ELSE 0
    END 
    AS "추천비율"  
FROM 
    BOARD; 

--<날짜 함수>
SELECT NUM, INPUTDATE FROM BOARD;
SELECT NUM, TO_CHAR(INPUTDATE, 'YYYY/MM/DD HH24:MI:SS') FROM BOARD;
SELECT NUM, INPUTDATE + 1 FROM BOARD;       --일단위 계산
SELECT NUM, INPUTDATE - 2 FROM BOARD;       --일단위 계산
SELECT NUM, SYSDATE - INPUTDATE FROM BOARD; --일단위 계산

--년도 아래 버림
SELECT NUM, TRUNC(INPUTDATE, 'YYYY') FROM BOARD;   --TRUNC(칼럼, 자를 기준) -> 연도만 남기고 월, 일 버림, 작성된 날짜의 년도
--월 아래 버림
SELECT NUM, TRUNC(INPUTDATE, 'MONTH') FROM BOARD;      --월만 남기고 일을 버림, 작성된 날짜의 첫날
--일 아래 버림
SELECT NUM, TRUNC(INPUTDATE, 'DD') FROM BOARD; 
--글이 작성된 후 경과된 개월 수
SELECT NUM, TRUNC(MONTHS_BETWEEN(SYSDATE, INPUTDATE)) FROM BOARD;
--글이 작성된 후 3개월 지난 날짜
SELECT NUM, ADD_MONTHS(INPUTDATE,3) FROM BOARD;
--글이 작성된 후 다가오는 다음 월요일
SELECT NUM, NEXT_DAY(INPUTDATE, 2) FROM BOARD;
--글이 작성된 후 1개월이 지난 다음 일요일
SELECT NUM, NEXT_DAY(ADD_MONTH(INPUTDATE, 1),1) FROM BOARD;
--글이 작성된 월의 첫번째 토요일
SELECT NUM, NEXT_DAY(TRUNC(INPUTDATE, 'MONTH'),7) FROM BOARD;

--오늘날짜로 연습해보는 곳!
SELECT SYSDATE FROM DUAL; --19/12/05 -> 오늘 날짜
SELECT TRUNC(SYSDATE, 'YYYY') FROM DUAL; --19/01/01 -> 년을 기준으로 잘라낸 것
SELECT TRUNC(SYSDATE, 'MM') FROM DUAL;  --19/12/01 -> 월을 기준으로 잘라낸 것
SELECT TRUNC(SYSDATE, 'DD') FROM DUAL;  --19/12/05 -> 일을 기준으로 잘라낸 것
SELECT ROUND(MONTHS_BETWEEN(SYSDATE, '19-01-01')) FROM DUAL; --11 오늘 날짜와 해당 날짜간 차이
SELECT ADD_MONTHS(SYSDATE,6) FROM DUAL;    --20/06/05 -> 숫자만큼 월이 지난 것
SELECT NEXT_DAY(SYSDATE,1) FROM DUAL; --인자로써 1은 일요일, 2는 월요일 7은 토요일,8은 에러발생
SELECT LAST_DAY(SYSDATE) FROM DUAL;    --그 달의 마지막 날짜를 보여줌
SELECT NEXT_DAY(TRUNC(SYSDATE, 'MONTH'),7) FROM DUAL; --해당 월의 첫번째 토요일

--사용자가 날짜를 입력함. 3월 5일부터 4월 15일까지의 글

--<그룹 함수>
--전체 그룹 조회수 평균
SELECT AVG(HITS) FROM BOARD; --12
--ID별 조회수 평균
SELECT ID, AVG(HITS) FROM BOARD GROUP BY ID; 
--올해 글을 대상으로 ID별 조회수 평균, 평균이 10이상인 회원만 출력(소수점 2번째 자리에서 반올림)
SELECT 
    ID,
    ROUND(AVG(HITS),1) AS "ID별 조회수 평균"
FROM 
    BOARD 
WHERE 
    INPUTDATE > TRUNC(SYSDATE, 'YYYY') --올해 글을 대상
GROUP BY 
    ID                                  --ID별
HAVING 
    ROUND(AVG(HITS),1) >= 10            --조회수 평균이 10이상 (소수점 2번째 자리에서 반올림)
ORDER BY 
    ID;
    
--<서브 쿼리>
--평균 조회수 이상의 글
SELECT 
    NUM
    ,ID
    ,TITLE
    ,HITS 
FROM 
    BOARD 
WHERE 
    HITS >= (SELECT AVG(HITS) FROM BOARD); --SELECT AVG(HITS) FROM BOARD는 12가 나옴

--글번호, ID, 이름, 제목 출력
SELECT 
    NUM 
    ,ID
    ,(SELECT NAME FROM MEMBER WHERE MEMBER.ID = BOARD.ID)NAME
    ,TITLE 
FROM 
    BOARD;

--조회수가 0이상이면서 ID가 'bbb'인 자
SELECT
   *
FROM 
    (SELECT NUM, ID, TITLE, HITS FROM BOARD WHERE HITS > 0) B
WHERE
    ID = 'bbb';

--각 게시글의 번호와 ID, 제목, 리플수 출력
SELECT 
    NUM
    , ID
    , TITLE
    , (SELECT COUNT(*) FROM REPLY WHERE BOARD.NUM = REPLY.BOARDNUM)REPLYCNT 
FROM 
    BOARD;
    
--평균 조회수가 5이상인 회원 목록
SELECT
    ID
    ,NAME
FROM
    MEMBER
WHERE
    (SELECT AVG(HITS) FROM BOARD WHERE MEMBER.ID = BOARD.ID) >= 5;
    
--회원들의 ID, 이름, 각자 평균 조회수 출력
SELECT 
    ID
    , NAME
    , (SELECT AVG(HITS) FROM BOARD WHERE MEMBER.ID = BOARD.ID) HITS
FROM MEMBER;

--성이 김씨인 회원들의 글
SELECT 
    * 
FROM 
    BOARD 
WHERE ID IN(SELECT ID FROM MEMBER WHERE NAME LIKE '김%');