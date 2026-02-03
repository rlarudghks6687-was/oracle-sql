--함수
select *
from professor;

select profno
      ,name
      ,pay*12 + nvl(bonus,0)*3 as "연봉"
      ,pay
      ,nvl(bonus, 0) bonus
from professor;

--inicap('문자열' / 컬럼)
select initcap('hello')
from dual;

select profno
      ,initcap(name) --첫글자만 대문자
      ,lower(name) --전체 소문자
      ,upper(name) --전체 대문자
      ,length(name) --문자열의 길이
      ,lengthb(name) --문자열의 길이
      ,concat(name, pay)
from professor;

--예1) 교수테이블의 이름에 'st'가 포함된 교수의 교수번호, 이름, 입사일 출력
select *
from professor;

select profno
      ,name
      ,hiredate
from professor
where lower(name) like '%st%';


--예2) 교수테이블의 교수이름이 10글자가 안되는 교수의 번호, 이름, 이메일 출력
select profno
      ,name
      ,email
      ,profno || name
      ,concat(profno, name) -- ||와 같다
from professor
where length(name) < 10;

--subsrt
select 'hello, world' 
       ,substr('hello, world', 1, 5) substr -- +값이면 왼쪽 순번,
       ,substr('hello, world', -5, 5) substr2 -- -값이면 오른쪽부터 왼쪽 순번
       ,substr('0'||5, -2, 2) mm
       ,substr('02)-3456-2345', 1, instr('02)3456-2345', ')', 1) - 1) instr1 --찾고자하는 글자의 위치를 찾아주는 함수
       ,substr('031)-2345-2312', 1, instr('031)2345-2312', ')', 1) - 1) instr2
       ,instr('031)-2345-2312', ')', 1) instr --문자열에서 찾을 문자열의 위치 반환
from dual;

--주전공(201) -> 전화번호, 지역번호 구분
select name, tel
,deptno1
,substr(tel, 1, instr(tel, ')', 1)-1) area 
,substr(tel, instr(tel, ')', 1),instr(tel,'-',1))
,substr(tel                     --문자열
       , instr(tel, ')', 1) + 1 --시작위치
       , instr(tel, '-',1) - instr(tel, ')',1) -1 ) "asd" --크기
       ,instr(tel, ')', 1)
       ,instr(tel, '-', 1)
from student
where deptno1 = 201;

--LOAD(): 문자열 또는 컬럼명, 왼쪽에서 부터 자릿수 채우기, RPAD(): 오른쪽에서 부터
select lpad('hello', 10, '*')
from dual;

select ename
      ,deptno
      ,lpad(ename, 9, '2134') result
from emp
where deptno = 10;

select lengthb(ename)
      ,rpad(ename, 9, substr('123456789',length(ename)+1, length(ename)+1))
from emp
where deptno = 10;

--ltrim('값', '찾을문자열') 제거
select rtrim('Hello', 'o')
from dual;

--replace('값', '찾을문자열', '대체문자열')
select replace('Hello', 'o', 'o, world')
from dual;

select ename
      ,replace(ename, substr(ename, 1, 2), '**') replace
from emp
where deptno = 10;

select ename
      ,replace(ename, substr(ename, 2, 2), '--')
from emp
where deptno = 20;

select name
      ,jumin
      ,replace(jumin, substr(jumin, 7,8), '-/-/-/-')
from student
where deptno1 = 101;

select name, tel
           , replace(tel, substr(tel, 5,3), '***')
from student
where deptno1 = 102;

select name, tel
             , replace(tel, substr(tel,instr(tel,'-',1)+1, 4), '****')
             , substr(tel, instr(tel, '-', 1) +1)
from student
where deptno1 = 101;

--round(123.4) 반올림
select round(123.456, -2) round
      ,trunc(123.4567, 1) trunc --버림
      ,mod(12, 5) mod --나머지 값
      ,ceil(12.3) --주어진 숫자와 근접한 큰 정수
      ,floor(12.3) floor --주어진 숫자와 근접한 작은 정수
      ,trunc(sysdate) trunc -- 년/월/일 시/분/초
      ,to_char(trunc(sysdate, 'hh'), 'rrrr/mm/dd hh24:mi:ss')
from dual;

--날짜관련함수
select add_months(sysdate, -1) next_month
      ,months_between(sysdate + 28, sysdate) months_between
from dual;

select * --사원번호, 이름, 근손년수(23년),
from emp;

select empno
      ,ename
      ,hiredate
      ,trunc(months_between(sysdate, hiredate) / 12) || '년'||
       mod(trunc(months_between(sysdate, hiredate)), 12) ||'개월'  "근무기간" --(23년 7개월)
from emp;      

select *  --교수번호, 이름, 입사일자, 급여 (30년 이상)
from professor;

select profno
      ,name
      ,hiredate
      ,position
      ,pay
--      ,p.*
from professor p
where trunc(months_between(sysdate, hiredate) / 12) >= 30
order by 3;
--학과 department
select *
from department;

select profno, name, p.deptno, d.deptno, dname
from professor p, department d
where p.deptno = d.deptno
and d.dname = 'Computer Engineering'; --16 * 12 = 192

--교수번호, 이름, 입사일자, 급여 (20년 이상, Software Engineering)
select profno
      ,name
      ,hiredate
      ,p.position
      ,pay
      ,p.deptno p_deptno
      ,d.deptno d_deptno
from professor p, department d
where trunc(months_between(sysdate, p.hiredate) / 12) >= 20
and d.dname = 'Software Engineering'
and p.deptno = d.deptno;

--emp
select *
from emp, dept
where emp.deptno = dept.deptno
order by emp.empno;

-- SALES부서에서 근속년 40년이 넘는 사람, 사번, 이름, 급여, 부서명
select e.empno, e.ename, e.sal, d.dname, e.hiredate
from emp e, dept d
where e.deptno = d.deptno
and d.dname = 'SALES'
and months_between(sysdate, e.hiredate) / 12 > 40
order by e.empno;      

-- 2 + '2'
select 2 + to_number('2', 9)
      ,concat(2, '2')
      ,sysdate
from dual
where sysdate > '2026/02/03';

--to_char(날짜, '포맷문자')
select sysdate
      ,to_char(sysdate, 'rrrr-month-dd hh24:mi:ss') to_char
      ,to_date('05/24/03', 'mm/rr/dd') to_date
from dual;      

--to_char(숫자)
select to_char(12345.6789, '099,999.99') --반올림 한 연산결과를 문자출력
from dual;

--생일이 1월인 학생의 이름과 birthday 출력
select studno
      ,name
      ,birthday
from student
where to_char(birthday, 'mm') = '01';

--nvl()
select nvl(10, 0) --null ? 0 : 10
from dual;

select pay + nvl(bonus, 0) "월급"
from professor;

--student(profno) -> 9999(없으면) / 담당교수
select profno
      ,nvl(profno, 9999) null9999
      ,nvl(to_char(profno), '담당교수없음') null교수없음
from student
order by profno desc;

--decode(A, B, '같은조건', '다른조건')
select decode(10, 20, '같다', '다르다') -- 10 == 20 ? '같다' : '다르다'
from dual;

select studno, profno, decode(profno, null, 9999, profno)
from student
order by profno desc;

select decode('C', 'A', '현재A', 'B', '현재B', '기타') -- A -> 현재A, B -> 현재B, 그외 기타
from dual;

select deptno
      ,name
      ,decode(deptno, 101, 'Computer Engineering')
from professor;

select deptno
      ,name
      ,decode(deptno, 101, 'Computer Engineering', 'ETC')
from professor;

select deptno
      ,name
      ,decode(deptno, 101, 'Computer Engineering', 102, 'Multimedia Engineering', 103, 'Software Engineering', 'ETC')
from professor;

