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

select name || '의 ''아이디''는 ' || id || ' 이고 ' || grade || '학년입니다.' 
       as "학년설명" --별칭(alias)
from student;
-- James seo의 '아이디'는 75true 이고 4학년입니다.
select  distinct name, grade --distinct : 중복된 값 제거 및 출력
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

--비교연산자 연습1) emp테이블 급여 3000보다 큰 직원
select *
from emp;

select *
from emp
where sal > 3000;

--비교연산자 연습2) emp테이블 보너스 있는 직원
select *
from emp
where comm is not null;

--비교연산자 연습3) student테이블 주전공학과: 101, 102, 103인 학생.
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
and (grade = 4 or height > 150); --우선순위 and가 조금 더 높음

--급여가 2000 이상인 직원, 커미션(급여 + 커미션)
select ename
      ,sal
      ,comm
from emp
where (sal + comm) >= 2000
or sal >= 2000;

--교수 -> 연봉이 4000 이상인 교수들, (pay * 12) + (bonus * 3)
select profno
      ,name
      ,pay
      ,bonus
      ,pay * 12 as total_1
      ,pay * 12 + bonus * 3 as total_2
from professor
where (pay * 12 >= 3000 and bonus is null)
or (pay * 12 + bonus * 3 >= 3000 and bonus is not null)
order by 5; --order by(정렬기준). col순번으로도 가능

--문자열 like연산자
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

--학생테이블, 전화번호(02, 03, 051, 052, 053..)
--부산거주,(051)
select name
      ,tel
from student
where tel like '051%';

--이름 M으로 시작하면서 8개 이상인 사람만 조회
select name
from student
where name like '%M________%';

--주민번호 10월달에 태어난 사람조회
select name
      ,jumin
      ,birthday
from student      
where birthday like '%__10%';