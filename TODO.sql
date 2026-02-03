
select ename || '''s  sal is  $' || sal as "Name And Sal"
from emp;

--2026.02.03
--107, 108, 113p(nv12)
--107
select empno
      ,ename
      ,sal
      ,comm
      ,to_char((sal*12) + comm, '999,999')
from emp
where ename = 'ALLEN';

--108
select empno
      ,ename
      ,hiredate
      ,sal 
      ,to_char((sal * 12) + comm, '$999,99') "15% UP"
from emp;

--113
select empno
      ,ename
      ,comm
--      ,nvl2(comm, )
from emp
where deptno = 30;
--학생테이블의 생년월일을 기준으로 1~3 -> 1/4분기
--                           4~6 -> 2/4분기
--                           7~9 -> 3/4분기
--                           10~12 -> 4/4분기
