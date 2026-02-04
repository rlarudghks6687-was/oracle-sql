-- Oracle(DBMS) - version(21C) -xe(database명)
-- user(scott) - 테이블.
-- Structured Query Language (SQL)
SELECT studno, name -- 칼럼명(전체)
FROM STUDENT; -- 테이블.

-- 1. professor 테이블. 전체 컬럼 조회.
SELECT *
FROM student;

-- 2. student 테이블. 학생번호, 이름, 학년
SELECT studno, name, grade
FROM STUDENT;

--숙제완료함.(연습문제 3)
select name || '의 아이디는 ' || id as "전체설명" -- 별칭(alias) as는 있으나 없으나
       ,grade "학년"                           -- || 연결 연산자
from student;
-- James Seo의 아이디는 75true 이고 4학년 입니다. -> alias (학년설명)

select name || '�� ''���̵�''�� ' || id || ' �̰� ' || grade || '�г��Դϴ�.' 
       as "�г⼳��" --��Ī(alias)
from student;
-- James seo�� '���̵�'�� 75true �̰� 4�г��Դϴ�.
select  distinct name, grade --distinct : �ߺ��� �� ���� �� ���
from student;

select *
from emp;

select name || '''s ID: ' || id || ', WEIGHT is ' || weight || 'Kg' as "ID AND WEIGT"
from student;

select ename || '(' || JOB || '), ' || ename ||'''' ||  JOB || '''' as "NAME AND JOB"
from emp;

--WHERE
SELECT *
FROM student
WHERE weight between 60 and 70 -- weight >= 60 AND weight <= 70
AND deptno1 in (101, 201); -- !=, <>

select *
from student
where deptno2 is not null;

--�񱳿����� ����1) emp���̺� �޿� 3000���� ū ����
select *
from emp;

select *
from emp
where sal > 3000;

--�񱳿����� ����2) emp���̺� ���ʽ� �ִ� ����
select *
from emp
where comm is not null;

--�񱳿����� ����3) student���̺� �������а�: 101, 102, 103�� �л�.
SELECT *
from student
where deptno1 in (101, 102, 103);

--AND / OR
--if(sal > 100 || height > 170)
select studno
      ,name
      ,grade
      ,height
      ,weight
from student
where (height> 170
or   weight > 60)
and (grade = 4 or height > 150); --�켱���� and�� ���� �� ����

--�޿��� 2000 �̻��� ����, Ŀ�̼�(�޿� + Ŀ�̼�)
select ename
      ,sal
      ,comm
from emp
where (sal + comm) >= 2000
or sal >= 2000;

--���� -> ������ 4000 �̻��� ������, (pay * 12) + (bonus * 3)
select profno
      ,name
      ,pay
      ,bonus
      ,pay * 12 as total_1
      ,pay * 12 + bonus * 3 as total_2
from professor
where (pay * 12 >= 3000 and bonus is null)
or (pay * 12 + bonus * 3 >= 3000 and bonus is not null)
order by 5; --order by(���ı���). col�������ε� ����

--���ڿ� like������
select *
from student
where name like '%on____%';

--
select profno
      ,name
      ,pay
      ,bonus
      ,hiredate
from professor
where hiredate > to_date('1999-01-01', 'rrrr-mm-dd')
order by hiredate; --1970.01.01

--�л����̺�, ��ȭ��ȣ(02, 03, 051, 052, 053..)
--�λ����,(051)
select name
      ,tel
from student
where tel like '051%';

--�̸� M���� �����ϸ鼭 8�� �̻��� ����� ��ȸ
select name
from student
where name like '%M________%';

--�ֹι�ȣ 10���޿� �¾ �����ȸ
select name
      ,jumin
      ,birthday
from student      
where birthday like '%__10%';