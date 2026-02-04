select *
from emp;

--추가작업(origin merge 테스트)
select *
from dept;

--DML (insert, update, delete, merge)
--1) insert into table명 (컬럼1, 컬럼2......) values(값1, 값2......);
select * from board;
-- 4/ 글등록연습 / user01/ sql연습중   insert into board
--insert 완성
insert into board (board_no, title, content, writer)
values((select max(board_no)+1 from board)
       , :title
       , :content
       , :writer
       );
       
insert into board
values(8, 'title', 'user02', 'content', sysdate, 0);

select max(board_no)+1 from board;

update board
set    click_cnt = click_cnt + 1  --조회수
      ,title = :title             --제목
      ,content = :content         --내용
where board_no = :bno;            --글번호

delete from board
where content like '%바인드%';

select * from board;

select * from emp order by 1 desc;
-- max+1, 이름, SALESMAN, , 2026-02-01, 3000, 10, 30
insert into emp (empno, ename, job, hiredate, sal, comm, deptno)
values((select max(empno)+1 from emp)
      ,'김경환', 'SALESMAN', to_date('2026-02-01', 'rrrr-mm-dd')
      ,3000, 10, 30);

-- 30부서의 MANAGER의 사번
update emp
set mgr = (select empno from emp
           where deptno = 30
           and job = 'MANAGER')
where empno = 7935;

select empno from emp
where deptno = 30
and job = 'MANAGER';

-- 상품테이블
-- 상품코드, 상품명, 가격, 상품설명, 평점(5~1), 제조사, 등록일자
-- key      nn     nn    nn      3                 sysdate

create table prod_table(
     prod_code VARCHAR2(5) primary key,
     pname varchar2(100) not null,
     price number(5) not null,
     descrip varchar2(10) not null,
     rating number(5),
     company  varchar2(1000), 
     regiscrip date default sysdate
     );

insert into prod_table(prod_code, pname, price, descrip, rating, company, regiscrip)
values('a002', '연필', 500, '가볍고 튼튼한 연필', 5, '모나미', sysdate);

alter table prod_table
modify(descrip VARCHAR2(1000));


update prod_table
set pname = :pname,
    price = :price,
    descrip = :descrip,
    company = :company,
    regiscrip = :regiscrip;

select *
from prod_table;

--select 'S' ||
--      (select lpad(max(substr(prod_code, 2, 3)) +1, 3, '0') frome prod_table)
--from dual;

--merge into table1
--using table2
--on 병합조건
--when matched then
--update...
--when not matched then
--insert...
merge into prod_table tbl1
using(select 'S014' prod_code
                  ,'새로운상품14'pname
                  ,14000 price
                  ,'아주좋은 14상품'descrip
            from dual) tbl2
on (tbl1.prod_code = tbl2.prod_code)
when matched then 
update set tbl1.pname = tbl2.pname
          ,tbl1.price = tbl2.price
          ,tbl1.descrip = tbl2.descrip
when not matched then
 insert (prod_code, pname, price, descrip)
 values(tbl2.prod_code, tbl2.pname, tbl2.price, tbl2.descrip);
