/* [ DDL - 테이블 관리 ] */

-- 테이블 생성
create table book (
    book_id number(5),
    title varchar2(50),
    author varchar2(10),
    pub_date date
);

-- 모든 테이블 조회
select *
from tabs;

/* 컬럼에 대한 추가, 수정, 삭제 */
-- 1. 컬럼 추가
alter table book ADD (pubs VARCHAR2(50));

-- 2. 컬럼 수정
alter table book modify (title varchar(100)); -- 컬럼 수정
alter table book rename column title to subject; -- 컬럼명 수정

-- 3. 컬럼 삭제
alter table book drop (author);

select *
from book;

/* 테이블에 대한 수정, 삭제 */
-- 1. 테이블명 수정
rename book to article;

-- 오류남
select *
from book;

-- 정상 작동
select *
from article;

-- 2. 테이블 삭제
drop table article;

-- 3. 테이블의 모든 로우 제거
truncate table article;

/* 제약 조건 (NOT NULL, UNIQUE, PK, FK */
-- 작가 테이블 생성
create table author (
    author_id    number(10),
    author_name  varchar2(100) not null,
    author_desc  varchar(500),
    primary key(author_id)
);

select *
from author;

-- 도서 테이블 생성
create table book (
    book_id    number(10),
    title      varchar2(100) not null,
    pubs       varchar2(100),
    pub_date   date,
    author_id  number(10),
    primary key(book_id),
    constraint c_book_fk foreign key(author_id)
    references author(author_id)
);

-----------------------------------------------------------------------

/* 제약 조건 (NOT NULL, UNIQUE, PK, FK */
-- 작가 테이블 생성
create table author (
    author_id    number(10),
    author_name  varchar2(100) not null,
    author_desc  varchar(500),
    primary key(author_id)
);

select *
from author;

-- 도서 테이블 생성
create table book (
    book_id    number(10),
    title      varchar2(100) not null,
    pubs       varchar2(100),
    pub_date   date,
    author_id  number(10),
    primary key(book_id),
    constraint c_book_fk foreign key(author_id)
    references author(author_id)
);

/* [ DML - INSERT(삽입) / UPBATE(수정) / DELETE(삭제) */
/* INSERT
 1. 묵시적 방법
  - 컬럼 이름, 순서 지정하지 않음
  - 테이블 생성시 정의한 순서에 따라 값 지정 */
insert into author
values (1, '박경리', '토지 작가');

/* INSERT
 2. 명시적 방법
  - 컬럼 이름 명시적 사용
  - 지정되지 않은 컬럼 NULL 자동 입력 */
insert into author (author_id, author_name)
values(2, '이문열');

insert into author
values(3, '기안84', '');

select *
from author;

/* UPDATE
 - 조건에 만족하는 레코드 변경
 - 칼럼 이름, 순서 지정하지 x
 - 테이블 생성시 정의한 순서에 따라 값 지정
 - WHERE 절이 생략되면 모든 레코드에 적용됨(주의) */
update author
set author_name = '기안83',
    author_desc = '웹툰작가'
where author_id = 3;    

/* DELETE
 - 조건에 만족하는 레코드 삭제
 - WHERE 절이 생략되면 모든 레코드에 적용됨(주의) */
 delete from author
 where author_id = 1;
 
 -- 모든 데이터 삭제
 delete from author;
 
select *
from author;

/* [ SEQUENCE / SYSDATE ] */
/* SEQUENCE
   1. 시퀀스 생성 */
create sequence seq_author_id
increment by 1
start with 1;

/* SEQUENCE
   2. 시퀀스 사용 */
insert into author
values(seq_author_id.nextval, '박경리', '토지작가');

select *
from author;

-- 묵시적 삽입
insert into author
values(seq_author_id.nextval, '기안84', '웹툰작가');

-- 명시적 삽입
insert into author (author_id, author_name)
values(seq_author_id.nextval, '이문열');

/* SEQUENCE
   3. 시퀀스 명령어 */
-- 시퀀스 조회
select * from user_sequences;

-- 현재 시퀀스 조회
select seq_author_id.currval from dual;

-- 다음 시퀀스 조회
select seq_author_id.nextval from dual;

-- 시퀀스 삭제
drop sequence seq_author_id;

/* SYSDATE : 현재 시간이 입력 됨 */
insert into board
values (1, '게시판제목', '본문내용', sysdate);