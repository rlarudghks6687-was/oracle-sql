select *
from emp;

select *
from dept;

select e.*, dname, loc
from emp e, dept d
where e.deptno = d.deptno;

--ansei vs, oracle
select *
from emp e
join dept d on e.deptno = d.deptno
where job = 'SALESMAN';

--student(profno), professor(profno)
-- 학생번호, 이름, 담당교수번호, 이름
select studno, s.name, p.profno, p.name
from student s
full outer join professor p on s.profno = p.profno; --left outer: 조건에 충족하지 못한 것들도 반영
--right outer: 주 기준이 아닌 조건을 기준으로
--full outer: 전체조건

select *
from student;

select *
from professor;

--학생번호, 학생이름, 담당교수이름 / 담당교수 없음
-- 0615, Daniel Day-Lewis, Jodie Foster
-- 9712, Sane Connery, 담당교수 없음
select studno
      ,s.name
      ,nvl(to_char(p.name), '담당교수 없음') 교수이름
from student s
left outer join professor p on s.profno = p.profno;

--nvl(), decode(), case when end
--student 지역번호 구분 02(서울), 031(경기도), 051(부산) 그외(기타)
select name
      ,substr(tel, 1, instr(tel, ')', 1) - 1) tel
      ,case substr(tel, 1, instr(tel, ')', 1) - 1) when '02' then '서울'
                                                   when '031' then '경기도'
                                                   when '051' then '부산'
                                                   else '기타'
     end "지역명"                                              
from student;

select name
      ,jumin
      ,case when substr(jumin, 3, 2) between '01' and '03' then '1/4분기'
            when substr(jumin, 3, 2) between '04' and '06' then '2/4분기'
            when substr(jumin, 3, 2) between '07' and '09' then '3/4분기'
            when substr(jumin, 3, 2) between '10' and '12' then '4/4분기'
            end 분기
from student;

select empno
      ,ename
      ,sal
      ,case when sal between 1 and 1000 then 'LEVEL 1'
            when sal between 1001 and 2000 then 'LEVEL 2'
            when sal between 2001 and 3000 then 'LEVEL 3'
            when sal between 3001 and 4000 then 'LEVEL 4'
            else 'LEVEL 5'
      end         as  "level"
from emp
order by "level";


select job, count(*), sum(sal), round(avg(sal),1), min(sal), max(sal)
from emp
group by job;







--rollup()
--부서별 직무별 평균급여, 사원수
select deptno
      ,job
      ,avg(sal)
      ,count(*)
from emp
group by deptno
        ,job
union
--2)부서별 평균급여, 사원수
select deptno
      ,'소계'
      ,round(avg(sal), 1)
      ,count(*)
from emp
group by deptno
union

--3)전체 평균급여, 사원수
select 99
      ,'전체집계'
      ,round(avg(sal), 1)
      ,count(*)
from emp
order by 1;

--rollup
select deptno
      ,job
      ,round(avg(sal), 1)
      ,count(*)
from emp
group by rollup(deptno, job)
order by 1;



--게시판(board)
--글번호, 제목, 작성자, 글내용, 작성시간--, 조회수, 수정시간, 수정자...
drop table board;
create table board (
  board_no number(10) primary key, --글번호 primary key (중복값을 제거)
  title  varchar2(300) not null, --제목
  writer VARCHAR2(50) not null, --작성자
  content VARCHAR2(100) not null, --글내용
  created_at date default sysdate -- 작성시간
);
--컬럼 추가, 변경
alter table board add (click_cnt number);
alter table board modify content varchar2(1000);
alter table board modify click_cnt number default 0;

desc board;

insert into board (board_no, title, writer, content)
values (3, 'test', 'user01', 'test');

insert into board (board_no, title, writer, content)
values (2, 'test2', 'user02', 'test2');

select *
from board;


update board
set title = 'test3'
where board_no = 3;

update board
set writer = 'user03'
where board_no = 3;