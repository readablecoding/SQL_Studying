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
    INPUTDATE   DATE DEFAULT SYSDATE,           --작성시간
    HITS        NUMBER DEFAULT 0,               --조회수
    LIKES       NUMBER DEFAULT 0                --추천수
);

--게시판 글 번호에 사용할 시퀀스
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
    ON DELETE CASCADE --BOARDNUM이 BOARD(NUM)을 참조한다. 본문이 삭제될 때 ON DELETE CASCADE를 하면 딸린 애들도 다 삭제된다.
);

--댓글 번호에 사용할 시퀀스
CREATE SEQUENCE REPLY_SEQ;
--저장 예
INSERT INTO REPLY(REPLYNUM, BOARDNUM, ID, TEXT) 
    VALUES (REPLY_SEQ.NEXTVAL, 1, '123', '첫 댓글');
INSERT INTO REPLY(REPLYNUM, BOARDNUM, ID, TEXT) 
    VALUES (REPLY_SEQ.NEXTVAL, 2, '555', '심심한 하루');

    




