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
    INPUTDATE   DATE DEFAULT SYSDATE,           --�ۼ��ð�
    HITS        NUMBER DEFAULT 0,               --��ȸ��
    LIKES       NUMBER DEFAULT 0                --��õ��
);

--�Խ��� �� ��ȣ�� ����� ������
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
    ON DELETE CASCADE --BOARDNUM�� BOARD(NUM)�� �����Ѵ�. ������ ������ �� ON DELETE CASCADE�� �ϸ� ���� �ֵ鵵 �� �����ȴ�.
);

--��� ��ȣ�� ����� ������
CREATE SEQUENCE REPLY_SEQ;
--���� ��
INSERT INTO REPLY(REPLYNUM, BOARDNUM, ID, TEXT) 
    VALUES (REPLY_SEQ.NEXTVAL, 1, '123', 'ù ���');
INSERT INTO REPLY(REPLYNUM, BOARDNUM, ID, TEXT) 
    VALUES (REPLY_SEQ.NEXTVAL, 2, '555', '�ɽ��� �Ϸ�');

    




