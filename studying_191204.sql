--19.12.4 �� 
--<������ ����>
--UPDATE ���̺�� SET ���ϴ� �� WHERE ����
--�Խ��� 1�� ���� ������ 'oracle'�� ����
UPDATE BOARD SET TILTE = 'oracle' WHERE NUM = 1;
--�Խ��� 2�� ���� ��ȸ���� 10����, ��õ���� 5�� ����
UPDATE BOARD SET HITS = 10, LIKES = 5 WHERE NUM = 2;
--�Խ��� 2�� ���� ��ȸ���� ����
UPDATE BOARD SET HITS = HITS + 1 WHERE NUM = 2;
--�Խ����� 123������ �� ������ �ٲ�
UPDATE BOARD SET CONTENTS = '������� �Ϸ�' WHERE ID = '123';

--<������ �˻�>
--�ۼ��� ID�� ��õ���� "ȫ�浿�� ��õ10ȸ" �������� �˻�
SELECT (ID || '��') ID, ('��õ' || LIKES || 'ȸ') LIKES FROM BOARD;
--'aaa'�� �� ��� ��
SELECT * FROM BOARD WHERE ID = 'aaa';
----19�� 12�� 1�� ������ ��
SELECT * FROM BOARD WHERE INPUTDATE > '19/12/01';
--��ȸ���� 10~15 ������ ��
SELECT * FROM BOARD WHERE HITS BETWEEN 10 AND 15;
--��ȸ���� 10�̻��̰� ��õ���� 5 �̻��� ��
SELECT* FROM BOARD WHERE HITS >= 10 AND LIKES >= 5;
--���� �� ��
SELECT * FROM BOARD WHERE TRUNC(SYSDATE) <= INPUTDATE;
--���� �� ��
SELECT * FROM BOARD WHERE TO_CHAR(SYSDATE,'YYYY') = TO_CHAR(INPUTDATE,'YYYY');
--��ü ���� ��ȸ�� ���
SELECT AVG(HITS) AS HITS FROM BOARD;
--�̹��޿� �� ���� ����
SELECT COUNT(*) FROM BOARD WHERE TO_CHAR(SYSDATE,'YYMM') = TO_CHAR(INPUTDATE,'YYMM');
--ID�� 'b'�� ���� ���� ȸ���� �۵�
SELECT * FROM BOARD WHERE ID NOT LIKE '%B%';
SELECT * FROM BOARD WHERE NOT (ID LIKE '%B%');

--<�׷��Լ�>
SELECT COUNT(*) FROM BOARD WHERE ID ='aaa';
SELECT ID, COUNT(*) FROM BOARD GROUP BY ID;

--������ �� ����
SELECT 
    TO_CHAR(INPUTDATEE,'YYYY') || '��' AS "����"
    , COUNT(*) AS "�� ����" 
FROM 
    BOARD 
GROUP BY 
    TO_CHAR(INPUTDATEE,'YYYY');

--������ ���� ��ȸ�� ���
SELECT 
    TO_CHAR(INPUTDATE, 'MM') || '��' AS "��"
    , AVG(HITS) AS "��ȸ�� ���" 
FROM 
    BOARD 
GROUP BY 
    TO_CHAR(INPUTDATE,'MM');
    
--���� �̹����� ��ȸ�� ����� 10�̻��� ���    
--����: WHERE -> GROUY BY -> HAVING -> ORDER BY
SELECT 
    TO_CHAR(INPUTDATE, 'MM') || '��' AS INPUTDATE   --��¥ ��Ÿ����
    ,AVG(HITS) AS "��ȸ�� ���"                      --��ȸ�� ��� ��Ÿ����
 FROM 
    BOARD
WHERE 
    INPUTDATE >= TRUNCE(SYSDATE, 'YYYY') --����1) ���ظ� ��Ÿ��
GROUP BY 
    TO_CHAR(INPUTDATE, 'MM') --����2)���� �������� ��Ÿ��
HAVING 
    AVG(HITS) >= 10 --����3)��ȸ���� 10�̻��� ���
ORDER BY 
    INPUTDATE; --����4)INPUTDATE�� ������������ ����

--<����>
SELECT * FROM BOARD ORDER BY NUM;                   --NUM�� �������� �������� ����
SELECT * FROM BOARD ORDER BY NUM DESC;              --NUM�� �������� �������� ����
SELECT * FROM BOARD ORDER BY ID, INPUTDATE DESC;    --�ϴ� ID�� �������� �������� ����, 2�������� INPUTDATE�� �������� �������� ����

--�Խ��ǿ� ���� �ѹ��̶� �� ȸ���� ID�� ���ĺ� ������� ���
SELECT DISTINCT ID FROM BOARD ORDER BY ID; --DISTINCT�� ID�� �ߺ��� ����, ID�� ������������ ����

