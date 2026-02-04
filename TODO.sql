
select ename || '''s sal is $' || sal as "Name And Sal"
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
      ,to_char((sal * 12) + nvl(comm, 0), '$999,999') "sal"
      ,to_char((((sal * 12) + comm) * 0.15) + (sal*12) + comm, '$999,999') 
from emp
where comm >= 0 ;


--113
select empno
      ,ename
      ,comm
      ,nvl2(to_char(comm), 'Exist', 'null')
from emp
where deptno = 30;
--학생테이블의 생년월일을 기준으로 1~3 -> 1/4분기
--                           4~6 -> 2/4분기
--                           7~9 -> 3/4분기
--                           10~12 -> 4/4분기
select name
      ,birthday
      ,to_char(birthday, 'mm')
      ,decode(to_char(birthday,'mm'),
      '01', '1분기', '02', '1분기', '03', '1분기',
      '04', '2분기', '05', '2분기', '06', '2분기',
      '07', '3분기', '08', '3분기', '09', '3분기',
      '10', '4분기', '11', '4분기', '12' ,'4분기') 분기
from student
order by 3;

select name
      ,birthday
      ,to_char(birthday, 'q') || '/4분기' quarter1 --q
      ,ceil(to_char(birthday, 'mm') / 3) || '/4분기' quarter2
from student
order by 3;