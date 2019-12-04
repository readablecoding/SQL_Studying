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
    INPUTDATE   DATE DEFAULT SYSDATE,           --�ۼ��ð� -> ����Ǵ� ������ �ð�
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


--�Խ��ǿ� ���� �ѹ��̶� �� ȸ���� ID�� ���ĺ� ������� ���
SELECT DISTINCT ID FROM BOARD ORDER BY ID; --DISTICT�� ID �ߺ� ����, ID�� ��������(A~Z)���� ����