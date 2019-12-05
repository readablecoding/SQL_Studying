--ȸ������
CREATE TABLE MEMBER(
    ID          VARCHAR2(30) PRIMARY KEY,    --ID, �⺻Ű: �ߺ��ȵǰ� �ʼ�
    PASSWORD    VARCHAR2(20) NOT NULL,       --��й�ȣ, �ʼ�
    NAME        VARCHAR2(20) NOT NULL,       --�̸�, �ʼ�
    GENDER      CHAR(1) DEFAULT 'M',         --����
    PHONE       VARCHAR2(30),                --��ȭ��ȣ
    ADDRESS     VARCHAR2(100),                --�ּ� ����
    EMAIL       VARCHAR2(50)                --�̸���
);

INSERT INTO MEMBER VALUES('123', 'ABC', 'ȫ�浿', 'M', '010-1111-1111', '���� ���걸', 'ABC@ABC.COM');
INSERT INTO MEMBER VALUES('456', 'BBB', '�ڱ浿', 'F', '010-2222-2222', '���� ��������', 'BBB@MM.COM');
INSERT INTO MEMBER VALUES('666', 'TTT', '�ٳ�ī', 'F', '010-9999-5555', '��⵵ ����', 'RRR@UU.COM');
INSERT INTO MEMBER VALUES('555', 'CCC', '�⹫��', 'M', '010-6666-8888', '�뱸 �޼���', 'GGG@HH.COM');
INSERT INTO MEMBER VALUES('789', 'UUU', '�ٴϿ�', 'F', '010-3434-5656', '�̱� ����', 'WWW@SS.COM');


--�Խ��� �� ����
CREATE TABLE BOARD(
    NUM         NUMBER PRIMARY KEY,             --�۹�ȣ
    ID           VARCHAR2(20) NOT NULL,         --�ۼ��� ID
    TITLE        VARCHAR2(200) NOT NULL,        --����
    CONTENTS    VARCHAR2(2000) NOT NULL,        --����
    INPUTDATE   DATE DEFAULT SYSDATE,           --�ۼ��ð� -> ����Ǵ� ������ �ð����� ����Ͻú���, �Է� ���ϸ� ����Ʈ�� ����ð� ��
    HITS        NUMBER DEFAULT 0,               --��ȸ��
    LIKES       NUMBER DEFAULT 0                --��õ��
);

--�Խ��� �� ��ȣ�� ����� ������ ->��ȣ�� �����´�.
CREATE SEQUENCE BOARD_SEQ;
--�Խ��� �� ���� ��       
INSERT INTO BOARD(NUM, ID, TITLE, CONTENTS) VALUES (BOARD_SEQ.NEXTVAL, '123', '����', '����');
INSERT INTO BOARD(NUM, ID, TITLE, CONTENTS) VALUES (BOARD_SEQ.NEXTVAL, '123', '�ȳ�', '�������̳�');
INSERT INTO BOARD(NUM, ID, TITLE, CONTENTS) VALUES (BOARD_SEQ.NEXTVAL, '555', '����', '�ɽ��ϳ�');
INSERT INTO BOARD(NUM, ID, TITLE, CONTENTS) VALUES (BOARD_SEQ.NEXTVAL, '789', '������', '����־�');
INSERT INTO BOARD(NUM, ID, TITLE, CONTENTS) VALUES (BOARD_SEQ.NEXTVAL, '666', '���ڳ�', '���� �ϰ� �ͳ�');
---> BOARD_SEQ.NEXTVAL�� ������ ��ȣ�� 1�� �þ��. ��ȣ�� �ٽ� �ǵ��� �� ����.

--SELECT BOARD_SEQ.NEXTVAL FROM DUAL; --��ȣ�� ��¦ ���´�.

--��� ���� ���̺�
CREATE TABLE REPLY(
    REPLYNUM NUMBER PRIMARY KEY, --��� ���̺��� �Ϸù�ȣ
    BOARDNUM NUMBER,              --����� �޸� ���� �۹�ȣ
    ID VARCHAR2(20) NOT NULL, --�ۼ���
    TEXT VARCHAR2(1000) NOT NULL, --��� ����
    INPUTDATE DATE DEFAULT SYSDATE, --�ۼ���
    CONSTRAINT REPLY_FK FOREIGN KEY (BOARDNUM) REFERENCES BOARD(NUM)
    ON DELETE CASCADE --BOARDNUM�� BOARD���̺��� NUM Į���� �����Ѵ�. ������ ������ �� ON DELETE CASCADE�� �ϸ� ���� �ֵ鵵 �� �����ȴ�.
);

--��� ��ȣ�� ����� ������ 
CREATE SEQUENCE REPLY_SEQ;
--���� ��
INSERT INTO REPLY(REPLYNUM, BOARDNUM, ID, TEXT) 
    VALUES (REPLY_SEQ.NEXTVAL, 1, '123', 'ù ���');
INSERT INTO REPLY(REPLYNUM, BOARDNUM, ID, TEXT) 
    VALUES (REPLY_SEQ.NEXTVAL, 2, '555', '�ɽ��� �Ϸ�');
INSERT INTO REPLY(REPLYNUM, BOARDNUM, ID, TEXT) 
    VALUES (REPLY_SEQ.NEXTVAL, 2, '789', '��մ� �Ϸ�');
INSERT INTO REPLY(REPLYNUM, BOARDNUM, ID, TEXT) 
    VALUES (REPLY_SEQ.NEXTVAL, 2, '666', '��ſ� �Ϸ�');
INSERT INTO REPLY(REPLYNUM, BOARDNUM, ID, TEXT) 
    VALUES (REPLY_SEQ.NEXTVAL, 2, '123', '���̹���');
    
--19/12/4 ��    
--<������ ����>
--�Խ��� 1�� ���� ������ 'oracle'�� ����
UPDATE BOARD SET TITLE = 'oracle' WHERE NUM = 1;
--�Խ��� 2�� ���� ��ȸ���� 10����,��õ���� 5�� ����
UPDATE BOARD SET HITS = 10, LIKES = 5 WHERE NUM = 2;
--�Խ��� 2�� ���� ��ȸ���� 1 ����
UPDATE BOARD SET HITS = HITS + 1 WHERE NUM = 2;
--�Խ����� 123������ �� ������ �ٲ�
UPDATE BOARD SET CONTENTS = '�Ϸ��� ����' WHERE ID = '123';

--<������ ����>
--DELETE FROM BOARD WHERE NUM > 1;

--ROLLBACK; --������ Ŀ�� �� �������� ���ư��� ��ɾ�, DELETE�� COMMIT�� ���� �ߴٸ� ���� �Ұ���


--<������ �˻�>
--�ۼ��� ID�� ��õ���� "ȫ�浿�� ��õ10ȸ" �������� �˻�
SELECT ((ID) || '��') ID,('��õ' || (LIKES) || 'ȸ') LIKES FROM BOARD;  -->������ �ִٸ� WHERE ���̰� ���� ����
--'aaa'�� �� ��� ��
SELECT * FROM BOARD WHERE ID = 'aaa'; --�Ϻ� ��ġ�� LIKE ���
--19�� 12�� 1�� ������ ��
SELECT * FROM BOARD WHERE INPUTDATE > '19/12/01'; -- '19/12/01'���� ũ�ٰ� �ϸ� 12�� 1�� 0�� 0�� 0�ʺ��� ũ�ٴ� ��. =�� �� ���� ����.
--��ȸ���� 10~15 ������ ��
SELECT * FROM BOARD WHERE HITS BETWEEN 10 AND 15;
--��ȸ���� 10�̻��̰� ��õ���� 5 �̻��� ��
SELECT * FROM BOARD WHERE HITS >= 10 and LIKES >= 5;
--���� �� ��
SELECT * FROM BOARD WHERE TRUNC(SYSDATE) <= INPUTDATE; --SYSDATE�� ���� �ð��� ���´�. TRUNC(SYSDATE)�� �� ������ �ڸ���. 
--���� �� ��
SELECT * FROM BOARD WHERE TO_CHAR(SYSDATE,'YYYY') = TO_CHAR(INPUTDATE,'YYYY');
--��ü ���� ��ȸ�� ���
SELECT AVG(HITS) AS "��ȸ�� ���" FROM BOARD; 
--�̹��޿� �� ���� ����
SELECT COUNT(*) AS "����" FROM BOARD WHERE TO_CHAR(SYSDATE,'YYMM') = TO_CHAR(INPUTDATE,'YYMM');
--ID�� 'b'�� ���� ���� ȸ���� �۵�
SELECT * FROM BOARD WHERE ID NOT LIKE '%b%'; --���ϵ� ī�� �� ���� �� LIKE�� ��� �Ѵ�.
--SELECT * FROM BOARD WHERE NOT(ID LIKE '%b%'); --NOT �����ڷ� ����� �ٲ�

--<�׷��Լ�>
SELECT COUNT(*) FROM BOARD WHERE ID = 'aaa'; --board ���̺��� id�� aaa�� ����� �� ���� ����
SELECT ID, COUNT(*) FROM BOARD GROUP BY ID; --id Į���� �������� ��� ��Ÿ��, GROUP BY�� �� ������ ���� �ʾƵ� �ٸ� Į�� ��� ����

--������ �� ����
SELECT 
    (TO_CHAR(INPUTDATE,'YYYY') || '��') AS "����" 
    ,COUNT(*) AS "������ �� ����" 
FROM 
    BOARD 
GROUP BY 
    TO_CHAR(INPUTDATE,'YYYY');
    
--������ ���� ��ȸ�� ���
SELECT 
    (TO_CHAR(INPUTDATE,'MM') || '��') AS "��" 
    ,AVG(HITS) AS "��ȸ�� ���" 
FROM 
    BOARD 
GROUP BY 
    TO_CHAR(INPUTDATE,'MM');
    
--���� �̹����� ��ȸ�� ����� 10�̻��� ���
SELECT 
    (TO_CHAR(INPUTDATE,'MM') || '��') AS INPUTDATE --GROUP BY�� �� ���� �ٽ� �� � ������ �˰Բ� �Ѵ�.
    ,AVG(HITS) AS "��ȸ�� ���" 
FROM 
    BOARD 
WHERE 
    INPUTDATE >= TRUNC(SYSDATE,'YYYY') --���ظ� ���ΰ� �������� ����.���������� �츮�� ��, ���� �������� TRUNC(SYSDATE,'YYYY')�� ǥ��
GROUP BY 
    TO_CHAR(INPUTDATE,'MM') --������ ���´�. WHERE ���ǿ� �´� �� �߿��� GROUP BY�� ����
HAVING
    AVG(HITS)>= 10 --��ȸ���� 10�̻��� �͸� ��Ÿ������ ��
ORDER BY 
    INPUTDATE;
--����: WHERE -> GROUP BY -> HAVING -> ORDER BY
--HAVING�� �ܵ����� ���� �� ����. GROUP BY�� ����� ���� ����ϹǷ�
--���������� ORDER BY�� ����

--<����>
SELECT * FROM BOARD ORDER BY NUM; --�����ϸ� ��������(ASC), ���������� �⺻�̴�.
SELECT * FROM BOARD ORDER BY NUM DESC; --������������ �Ϸ��� ORDER BY �÷��� DESC
SELECT * FROM BOARD ORDER BY ID, INPUTDATE DESC; --���̵�� ������������ ����, ���� ���̵� ������ �� �� INPUTDATE�� �������δٽ� ����


--19/12/5 ��
--�Խ��ǿ� ���� �ѹ��̶� �� ȸ���� ID�� ���ĺ� ������� ���
SELECT DISTINCT ID FROM BOARD ORDER BY ID; --DISTICT�� ID �ߺ� ����, ID�� ��������(A~Z)���� ����

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
SELECT ID, SUBSTR(PHONE,0,3) FROM MEMBER;
--ȸ�� ID�� �� ȸ�� ID�� ���� �� ���
SELECT ID, LENGTH(ID) FROM MEMBER;

--[�Խ��� �� ��������]
--�� ��ȣ�� 10~20���� ��
SELECT * FROM BOARD WHERE NUM BETWEEN 10 AND 20;

--�� ���� ��õ�� / ��ȸ��, �Ҽ��� ��°�ڸ����� �ݿø�
SELECT NUM, ROUND(LIKES / HITS * 100, 1) "��õ����" FROM BOARD WHERE NUM = 7;
--1��° ���
SELECT 
    NUM,
    CASE
        WHEN HITS  IS NULL THEN 0
        WHEN HITS = 0 THEN 0
        ELSE ROUND(LIKES / HITS * 100, 1)
        END "��õ ����"
FROM BOARD;

--2��° ���
SELECT
    NUM, 
    CASE WHEN NVL(LIKES, 0) != 0 THEN ROUND(LIKES / HITS * 100, 1) 
    ELSE 0
    END 
    AS "��õ����"  
FROM 
    BOARD; 

--<��¥ �Լ�>
SELECT NUM, INPUTDATE FROM BOARD;
SELECT NUM, TO_CHAR(INPUTDATE, 'YYYY/MM/DD HH24:MI:SS') FROM BOARD;
SELECT NUM, INPUTDATE + 1 FROM BOARD;       --�ϴ��� ���
SELECT NUM, INPUTDATE - 2 FROM BOARD;       --�ϴ��� ���
SELECT NUM, SYSDATE - INPUTDATE FROM BOARD; --�ϴ��� ���

--�⵵ �Ʒ� ����
SELECT NUM, TRUNC(INPUTDATE, 'YYYY') FROM BOARD;   --TRUNC(Į��, �ڸ� ����) -> ������ ����� ��, �� ����, �ۼ��� ��¥�� �⵵
--�� �Ʒ� ����
SELECT NUM, TRUNC(INPUTDATE, 'MONTH') FROM BOARD;      --���� ����� ���� ����, �ۼ��� ��¥�� ù��
--�� �Ʒ� ����
SELECT NUM, TRUNC(INPUTDATE, 'DD') FROM BOARD; 
--���� �ۼ��� �� ����� ���� ��
SELECT NUM, TRUNC(MONTHS_BETWEEN(SYSDATE, INPUTDATE)) FROM BOARD;
--���� �ۼ��� �� 3���� ���� ��¥
SELECT NUM, ADD_MONTHS(INPUTDATE,3) FROM BOARD;
--���� �ۼ��� �� �ٰ����� ���� ������
SELECT NUM, NEXT_DAY(INPUTDATE, 2) FROM BOARD;
--���� �ۼ��� �� 1������ ���� ���� �Ͽ���
SELECT NUM, NEXT_DAY(ADD_MONTH(INPUTDATE, 1),1) FROM BOARD;
--���� �ۼ��� ���� ù��° �����
SELECT NUM, NEXT_DAY(TRUNC(INPUTDATE, 'MONTH'),7) FROM BOARD;

--���ó�¥�� �����غ��� ��!
SELECT SYSDATE FROM DUAL; --19/12/05 -> ���� ��¥
SELECT TRUNC(SYSDATE, 'YYYY') FROM DUAL; --19/01/01 -> ���� �������� �߶� ��
SELECT TRUNC(SYSDATE, 'MM') FROM DUAL;  --19/12/01 -> ���� �������� �߶� ��
SELECT TRUNC(SYSDATE, 'DD') FROM DUAL;  --19/12/05 -> ���� �������� �߶� ��
SELECT ROUND(MONTHS_BETWEEN(SYSDATE, '19-01-01')) FROM DUAL; --11 ���� ��¥�� �ش� ��¥�� ����
SELECT ADD_MONTHS(SYSDATE,6) FROM DUAL;    --20/06/05 -> ���ڸ�ŭ ���� ���� ��
SELECT NEXT_DAY(SYSDATE,1) FROM DUAL; --���ڷν� 1�� �Ͽ���, 2�� ������ 7�� �����,8�� �����߻�
SELECT LAST_DAY(SYSDATE) FROM DUAL;    --�� ���� ������ ��¥�� ������
SELECT NEXT_DAY(TRUNC(SYSDATE, 'MONTH'),7) FROM DUAL; --�ش� ���� ù��° �����

--����ڰ� ��¥�� �Է���. 3�� 5�Ϻ��� 4�� 15�ϱ����� ��

--<�׷� �Լ�>
--��ü �׷� ��ȸ�� ���
SELECT AVG(HITS) FROM BOARD; --12
--ID�� ��ȸ�� ���
SELECT ID, AVG(HITS) FROM BOARD GROUP BY ID; 
--���� ���� ������� ID�� ��ȸ�� ���, ����� 10�̻��� ȸ���� ���(�Ҽ��� 2��° �ڸ����� �ݿø�)
SELECT 
    ID,
    ROUND(AVG(HITS),1) AS "ID�� ��ȸ�� ���"
FROM 
    BOARD 
WHERE 
    INPUTDATE > TRUNC(SYSDATE, 'YYYY') --���� ���� ���
GROUP BY 
    ID                                  --ID��
HAVING 
    ROUND(AVG(HITS),1) >= 10            --��ȸ�� ����� 10�̻� (�Ҽ��� 2��° �ڸ����� �ݿø�)
ORDER BY 
    ID;
    
--<���� ����>
--��� ��ȸ�� �̻��� ��
SELECT 
    NUM
    ,ID
    ,TITLE
    ,HITS 
FROM 
    BOARD 
WHERE 
    HITS >= (SELECT AVG(HITS) FROM BOARD); --SELECT AVG(HITS) FROM BOARD�� 12�� ����

--�۹�ȣ, ID, �̸�, ���� ���
SELECT 
    NUM 
    ,ID
    ,(SELECT NAME FROM MEMBER WHERE MEMBER.ID = BOARD.ID)NAME
    ,TITLE 
FROM 
    BOARD;

--��ȸ���� 0�̻��̸鼭 ID�� 'bbb'�� ��
SELECT
   *
FROM 
    (SELECT NUM, ID, TITLE, HITS FROM BOARD WHERE HITS > 0) B
WHERE
    ID = 'bbb';

--�� �Խñ��� ��ȣ�� ID, ����, ���ü� ���
SELECT 
    NUM
    , ID
    , TITLE
    , (SELECT COUNT(*) FROM REPLY WHERE BOARD.NUM = REPLY.BOARDNUM)REPLYCNT 
FROM 
    BOARD;
    
--��� ��ȸ���� 5�̻��� ȸ�� ���
SELECT
    ID
    ,NAME
FROM
    MEMBER
WHERE
    (SELECT AVG(HITS) FROM BOARD WHERE MEMBER.ID = BOARD.ID) >= 5;
    
--ȸ������ ID, �̸�, ���� ��� ��ȸ�� ���
SELECT 
    ID
    , NAME
    , (SELECT AVG(HITS) FROM BOARD WHERE MEMBER.ID = BOARD.ID) HITS
FROM MEMBER;

--���� �达�� ȸ������ ��
SELECT 
    * 
FROM 
    BOARD 
WHERE ID IN(SELECT ID FROM MEMBER WHERE NAME LIKE '��%');