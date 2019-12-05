--19/12/5/��
--�Խ��ǿ� ���� �ѹ��̶� �� ȸ���� ID�� ���ĺ� ������� ���
SELECT DISTINCT ID FROM BOARD ORDER BY ID;

--[ȸ�� ��������]
--��ü ȸ������� ID ������ ���
SELECT * FROM MEMBER ORDER BY ID;
--ID�� 'aaa'�� ȸ���� ���� ���
SELECT * FROM MEMBER WHERE ID = 'aaa';
--�̸��� �ּҿ� 'naver'�� ���Ե� ȸ��
SELECT * FROM MEMBER WHERE EMAIL LIKE '%naver%';
--�̸��� �ּҰ� 'naver.com'���� ������ ȸ��
SELECT * FROM MEMBER WHERE EMAIL LIKE '%naver.com';
--ȸ�� ID�� ��ȭ��ȣ�� ���ڸ� 3�� ���
SELECT ID, SUBSTR(PHONE, 0, 3) FROM MEMBER;
--ȸ�� ID�� �� ȸ�� ID�� ���� �� ���
SELECT ID, LENGTH(ID) FROM MEMBER;

--[�Խ��� �� ��������]
--�� ��ȣ�� 10~20���� ��
SELECT * FROM BOARD WHERE NUM BETWEEN 10 AND 20;
--�� ���� ��õ��/��ȸ��, �Ҽ��� ��°�ڸ����� �ݿø�
SELECT NUM, ROUND(LIKES / HITS, 1)"��õ����" FROM BOARD; --0�� �ִٸ� ���� �߻�
--0 �Ǵ� NULL�� ���ԵǾ��� �� �� ���� ��õ��/��ȸ��, �Ҽ��� ��°�ڸ����� �ݿø�
SELECT NUM 
        ,CASE 
            WHEN HITS IS NULL THEN 0
            WHEN HITS = 0 THEN 0
            ELSE ROUND(LIKES / HITS, 1)
            END  "��õ����"
FROM BOARD;

SELECT NUM
        ,CASE
            WHEN NVL(LIKES, 0) != 0 THEN ROUND(LIKES / HITS * 100, 1)
        ELSE 0
        END AS "��õ����"
FROM BOARD;

--<��¥�Լ�>
SELECT NUM, INPUTDATE FROM BOARD;
SELECT NUM, TO_CHAR(INPUTDATE, 'YYYY/MM/DD HH24:MI:SS') FROM BOARD;
SELECT NUM, INPUTDATE + 1 FROM BOARD;
SELECT NUM, INPUTDATE - 2 FROM BOARD;
SELECT NUM, ROUND(SYSDATE - INPUTDATE) FROM BOARD;

--�⵵ �Ʒ� ����
SELECT NUM, TRUNC(INPUTDATE, 'YYYY') FROM BOARD;
--�� �Ʒ� ����
SELECT NUM, TRUNC(INPUTDATE, 'MM') FROM BOARD;
--�� �Ʒ� ����
SELECT NUM, TRUNC(INPUTDATE, 'DD') FROM BOARD;
--���� �ۼ��� �� ����� ���� ��
SELECT NUM, TRUNC(MONTHS_BETWEEN(SYSDATE, INPUTDATE))"��� ������" FROM BOARD;
--���� �ۼ��� �� 3������ ���� ��¥
SELECT NUM, ADD_MONTHS(INPUTDATE, 3) FROM BOARD;
--���� �ۼ��� �� �ٰ����� ���� ������
SELECT NUM, NEXT_DAY(INPUTDATE, 2) FROM BOARD;
--���� �ۼ��� �� 1������ ���� ���� �Ͽ���
SELECT NUM, NEXT_DAY(ADD_MONTHS(INPUTDATE, 1),1) FROM BOARD;
--���� �ۼ��� ���� ù��° �����
SELECT NUM, NEXT_DAY(TRUNC(INPUTDATE, 'MONTH'), 7) FROM BOARD;

--<�׷��Լ�>
--��ü �׷� ��ȸ�� ���
SELECT AVG(HITS) FROM BOARD;
--ID�� ��ȸ�� ���
SELECT ID, AVG(HITS) FROM BOARD GROUP BY ID;
--���� ���� ������� ID�� ��ȸ�� ���, ����� 10�̻��� ȸ���� ���(�Ҽ��� 2��° �ڸ����� �ݿø�)
SELECT 
    ID
    , ROUND(AVG(HITS), 1) "ID�� ��ȸ�� ���" FROM BOARD 
WHERE 
    INPUTDATE > TRUNC(SYSDATE, 'YYYY')
GROUP BY
    ID
HAVING 
    ROUND(AVG(HITS), 1) >= 10
ORDER BY
    ID;
    
--<���� ����>
--��� ��ȸ�� �̻��� ��
SELECT 
    NUM
    , ID
    , TITLE
    , HITS
FROM 
    BOARD 
WHERE 
    HITS >= (SELECT AVG(HITS) FROM BOARD);

--�۹�ȣ, ID, �̸�, ���� ���
SELECT 
    NUM
    , ID
    , (SELECT NAME FROM MEMBER WHERE MEMBER.ID = BOARD.ID) NAME
    , TITLE 
FROM
    BOARD;

--��ȸ���� 0�̻��̸鼭 ID�� 'bbb'�� ��
SELECT 
*
FROM (SELECT NUM, ID, TITLE, HITS FROM BOARD WHERE HITS > 0) B
WHERE ID = 'bbb';

--�� �Խñ��� ��ȣ�� ID, ����, ���ü� ���
SELECT NUM, ID, TITLE, (SELECT COUNT(*) FROM REPLY WHERE BOARD.NUM = REPLY.BOARDNUM) REPLYCNT
FROM BOARD;

--��� ��ȸ���� 5�̻��� ȸ�� ���
SELECT 
    ID
    , NAME 
FROM 
    MEMBER
WHERE  (SELECT AVG(HITS) FROM BOARD WHERE MEMBER.ID = BOARD.ID) >= 5;

--ȸ������ ID, �̸�, ���� ��� ��ȸ�� ���
SELECT
    ID
    ,NAME
    ,(SELECT AVG(HITS) FROM BOARD WHERE MEMBER.ID = BOARD.ID) HITS
FROM 
    MEMBER;
--���� �达�� ȸ������ ��
SELECT
    *
FROM
    BOARD
WHERE 
    ID IN(SELECT ID FROM MEMBER WHERE NAME LIKE '��%');


