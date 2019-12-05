--19/12/5/목
--게시판에 글을 한번이라도 쓴 회원의 ID를 알파벳 순서대로 출력
SELECT DISTINCT ID FROM BOARD ORDER BY ID;

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
SELECT ID, SUBSTR(PHONE, 0, 3) FROM MEMBER;
--회원 ID와 그 회원 ID의 글자 수 출력
SELECT ID, LENGTH(ID) FROM MEMBER;

--[게시판 글 정보에서]
--글 번호가 10~20번인 글
SELECT * FROM BOARD WHERE NUM BETWEEN 10 AND 20;
--각 글의 추천수/조회수, 소수점 둘째자리에서 반올림
SELECT NUM, ROUND(LIKES / HITS, 1)"추천비율" FROM BOARD; --0이 있다면 에러 발생
--0 또는 NULL이 포함되었을 때 각 글의 추천수/조회수, 소수점 둘째자리에서 반올림
SELECT NUM 
        ,CASE 
            WHEN HITS IS NULL THEN 0
            WHEN HITS = 0 THEN 0
            ELSE ROUND(LIKES / HITS, 1)
            END  "추천비율"
FROM BOARD;

SELECT NUM
        ,CASE
            WHEN NVL(LIKES, 0) != 0 THEN ROUND(LIKES / HITS * 100, 1)
        ELSE 0
        END AS "추천비율"
FROM BOARD;

--<날짜함수>
SELECT NUM, INPUTDATE FROM BOARD;
SELECT NUM, TO_CHAR(INPUTDATE, 'YYYY/MM/DD HH24:MI:SS') FROM BOARD;
SELECT NUM, INPUTDATE + 1 FROM BOARD;
SELECT NUM, INPUTDATE - 2 FROM BOARD;
SELECT NUM, ROUND(SYSDATE - INPUTDATE) FROM BOARD;

--년도 아래 버림
SELECT NUM, TRUNC(INPUTDATE, 'YYYY') FROM BOARD;
--월 아래 버림
SELECT NUM, TRUNC(INPUTDATE, 'MM') FROM BOARD;
--일 아래 버림
SELECT NUM, TRUNC(INPUTDATE, 'DD') FROM BOARD;
--글이 작성된 후 경과된 개월 수
SELECT NUM, TRUNC(MONTHS_BETWEEN(SYSDATE, INPUTDATE))"경과 개월수" FROM BOARD;
--글이 작성된 후 3개월이 지난 날짜
SELECT NUM, ADD_MONTHS(INPUTDATE, 3) FROM BOARD;
--글이 작성된 후 다가오는 다음 월요일
SELECT NUM, NEXT_DAY(INPUTDATE, 2) FROM BOARD;
--글이 작성된 후 1개월이 지난 다음 일요일
SELECT NUM, NEXT_DAY(ADD_MONTHS(INPUTDATE, 1),1) FROM BOARD;
--글이 작성된 월의 첫번째 토요일
SELECT NUM, NEXT_DAY(TRUNC(INPUTDATE, 'MONTH'), 7) FROM BOARD;

--<그룹함수>
--전체 그룹 조회수 평균
SELECT AVG(HITS) FROM BOARD;
--ID별 조회수 평균
SELECT ID, AVG(HITS) FROM BOARD GROUP BY ID;
--올해 글을 대상으로 ID별 조회수 평균, 평균이 10이상인 회원만 출력(소수점 2번째 자리에서 반올림)
SELECT 
    ID
    , ROUND(AVG(HITS), 1) "ID별 조회수 평균" FROM BOARD 
WHERE 
    INPUTDATE > TRUNC(SYSDATE, 'YYYY')
GROUP BY
    ID
HAVING 
    ROUND(AVG(HITS), 1) >= 10
ORDER BY
    ID;
    
--<서브 쿼리>
--평균 조회수 이상의 글
SELECT 
    NUM
    , ID
    , TITLE
    , HITS
FROM 
    BOARD 
WHERE 
    HITS >= (SELECT AVG(HITS) FROM BOARD);

--글번호, ID, 이름, 제목 출력
SELECT 
    NUM
    , ID
    , (SELECT NAME FROM MEMBER WHERE MEMBER.ID = BOARD.ID) NAME
    , TITLE 
FROM
    BOARD;

--조회수가 0이상이면서 ID가 'bbb'인 자
SELECT 
*
FROM (SELECT NUM, ID, TITLE, HITS FROM BOARD WHERE HITS > 0) B
WHERE ID = 'bbb';

--각 게시글의 번호와 ID, 제목, 리플수 출력
SELECT NUM, ID, TITLE, (SELECT COUNT(*) FROM REPLY WHERE BOARD.NUM = REPLY.BOARDNUM) REPLYCNT
FROM BOARD;

--평균 조회수가 5이상인 회원 목록
SELECT 
    ID
    , NAME 
FROM 
    MEMBER
WHERE  (SELECT AVG(HITS) FROM BOARD WHERE MEMBER.ID = BOARD.ID) >= 5;

--회원들의 ID, 이름, 각자 평균 조회수 출력
SELECT
    ID
    ,NAME
    ,(SELECT AVG(HITS) FROM BOARD WHERE MEMBER.ID = BOARD.ID) HITS
FROM 
    MEMBER;
--성이 김씨인 회원들의 글
SELECT
    *
FROM
    BOARD
WHERE 
    ID IN(SELECT ID FROM MEMBER WHERE NAME LIKE '김%');


