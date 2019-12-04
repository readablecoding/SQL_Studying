--19.12.4 수 
--<데이터 수정>
--UPDATE 테이블명 SET 원하는 것 WHERE 조건
--게시판 1번 글의 제목을 'oracle'로 변경
UPDATE BOARD SET TILTE = 'oracle' WHERE NUM = 1;
--게시판 2번 글의 조회수를 10으로, 추천수를 5로 변경
UPDATE BOARD SET HITS = 10, LIKES = 5 WHERE NUM = 2;
--게시판 2번 글의 조회수를 증가
UPDATE BOARD SET HITS = HITS + 1 WHERE NUM = 2;
--게시판의 123유저가 슨 내용을 바꿈
UPDATE BOARD SET CONTENTS = '힘들었던 하루' WHERE ID = '123';

--<데이터 검색>
--작성자 ID와 추천수를 "홍길동씨 추천10회" 형식으로 검색
SELECT (ID || '씨') ID, ('추천' || LIKES || '회') LIKES FROM BOARD;
--'aaa'가 쓴 모든 글
SELECT * FROM BOARD WHERE ID = 'aaa';
----19년 12월 1일 이후의 글
SELECT * FROM BOARD WHERE INPUTDATE > '19/12/01';
--조회수가 10~15 사이인 글
SELECT * FROM BOARD WHERE HITS BETWEEN 10 AND 15;
--조회수가 10이상이고 추천수가 5 이상인 글
SELECT* FROM BOARD WHERE HITS >= 10 AND LIKES >= 5;
--오늘 쓴 글
SELECT * FROM BOARD WHERE TRUNC(SYSDATE) <= INPUTDATE;
--올해 쓴 글
SELECT * FROM BOARD WHERE TO_CHAR(SYSDATE,'YYYY') = TO_CHAR(INPUTDATE,'YYYY');
--전체 글의 조회수 평균
SELECT AVG(HITS) AS HITS FROM BOARD;
--이번달에 쓴 글의 개수
SELECT COUNT(*) FROM BOARD WHERE TO_CHAR(SYSDATE,'YYMM') = TO_CHAR(INPUTDATE,'YYMM');
--ID에 'b'가 들어가지 않은 회원의 글들
SELECT * FROM BOARD WHERE ID NOT LIKE '%B%';
SELECT * FROM BOARD WHERE NOT (ID LIKE '%B%');

--<그룹함수>
SELECT COUNT(*) FROM BOARD WHERE ID ='aaa';
SELECT ID, COUNT(*) FROM BOARD GROUP BY ID;

--연도별 글 개수
SELECT 
    TO_CHAR(INPUTDATEE,'YYYY') || '년' AS "연도"
    , COUNT(*) AS "글 개수" 
FROM 
    BOARD 
GROUP BY 
    TO_CHAR(INPUTDATEE,'YYYY');

--올해의 월별 조회수 평균
SELECT 
    TO_CHAR(INPUTDATE, 'MM') || '월' AS "월"
    , AVG(HITS) AS "조회수 평균" 
FROM 
    BOARD 
GROUP BY 
    TO_CHAR(INPUTDATE,'MM');
    
--올해 이번달의 조회수 평균이 10이상인 경우    
--순서: WHERE -> GROUY BY -> HAVING -> ORDER BY
SELECT 
    TO_CHAR(INPUTDATE, 'MM') || '월' AS INPUTDATE   --날짜 나타내기
    ,AVG(HITS) AS "조회수 평균"                      --조회수 평균 나타내기
 FROM 
    BOARD
WHERE 
    INPUTDATE >= TRUNCE(SYSDATE, 'YYYY') --순서1) 올해를 나타냄
GROUP BY 
    TO_CHAR(INPUTDATE, 'MM') --순서2)월을 기준으로 나타냄
HAVING 
    AVG(HITS) >= 10 --순서3)조회수가 10이상인 경우
ORDER BY 
    INPUTDATE; --순서4)INPUTDATE를 오름차순으로 정렬

--<정렬>
SELECT * FROM BOARD ORDER BY NUM;                   --NUM을 기준으로 오름차순 정렬
SELECT * FROM BOARD ORDER BY NUM DESC;              --NUM을 기준으로 내림차순 정렬
SELECT * FROM BOARD ORDER BY ID, INPUTDATE DESC;    --일단 ID를 기준으로 오름차순 정렬, 2차적으로 INPUTDATE를 기준으로 내림차순 정렬

--게시판에 글을 한번이라도 쓴 회원의 ID를 알파벳 순서대로 출력
SELECT DISTINCT ID FROM BOARD ORDER BY ID; --DISTINCT로 ID의 중복을 업앰, ID를 오름차순으로 정렬

