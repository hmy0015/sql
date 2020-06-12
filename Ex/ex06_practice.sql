/* 작가 테이블 생성 */
CREATE TABLE AUTHOR (
    author_id   NUMBER(5),
    author_name VARCHAR2(50),
    author_desc VARCHAR2(150),
    PRIMARY KEY(author_id)
);

/* 도서 테이블 생성 */
CREATE TABLE BOOK (
    book_id NUMBER(5),
    title VARCHAR2(150),
    pubs VARCHAR2(50),
    pub_date DATE,
    author_id NUMBER(5),
    CONSTRAINT book_fk FOREIGN KEY (author_id)
    REFERENCES author(author_id)
);

/* 시퀀스 생성 */
CREATE SEQUENCE sqn_book_id
INCREMENT BY 1
START WITH 1;

CREATE SEQUENCE sqn_author_id
INCREMENT BY 1
START WITH 1;

/* 작가 테이블 데이터 삽입 */
INSERT INTO author
VALUES (sqn_author_id.nextval, '이문열', '경북 영양');

INSERT INTO author
VALUES (sqn_author_id.nextval, '박경리', '경상남도 통영');

INSERT INTO author
VALUES (sqn_author_id.nextval, '유시민', '17대 국회의원');

INSERT INTO author
VALUES (sqn_author_id.nextval, '기안84', '기안동에서 산 84년생');

INSERT INTO author
VALUES (sqn_author_id.nextval, '강풀', '온라인 만화가 1세대');

INSERT INTO author
VALUES (sqn_author_id.nextval, '김영하', '알쓸신잡');

select * from author;

/* 도서 테이블 데이터 삽입 */
INSERT INTO book
VALUES (sqn_book_id.nextval, '우리들의 일그러진 영웅', '다림', '1998-02-22', 1);

INSERT INTO book
VALUES (sqn_book_id.nextval, '삼국지', '민음사', '2002-03-01', 1);

INSERT INTO book
VALUES (sqn_book_id.nextval, '토지', '마로니에북스', '2012-08-15', 2);

INSERT INTO book
VALUES (sqn_book_id.nextval, '유시민의 글쓰기 특강', '생각의 길', '2015-04-01', 3);

INSERT INTO book
VALUES (sqn_book_id.nextval, '패션왕', '중앙북스(books)', '2012-02-22', 4);

INSERT INTO book
VALUES (sqn_book_id.nextval, '순정만화', '재미주의', '2011-08-03', 5);

INSERT INTO book
VALUES (sqn_book_id.nextval, '오직두사람', '문학동네', '2017-05-04', 6);

INSERT INTO book
VALUES (sqn_book_id.nextval, '26년', '재미주의', '2012-02-04', 5);

select *
from book;

/* 도서 테이블과 작가 테이블 조인하여 출력 - 확인용 */
select *
from book b, author a
where b.author_id = a.author_id;

/* 강풀의 author_desc 정보를 ‘서울특별시’ 로 변경 */
UPDATE author
SET author_desc = '서울특별시'
WHERE author_id = 5;

select * from author;

/* author 테이블에서 기안84 데이터를 삭제 */
DELETE FROM book
WHERE author_id = 4;

select *
from book;

select *
from author;

DELETE FROM author
WHERE author_id = 4;

select *
from author;

/* 도서 테이블과 작가 테이블 조인하여 출력 - 최종 */
select b.book_id,
        b.title,
        b.pubs,
        to_char(b.pub_date, 'YYYY-MM-DD') "PUB_DATE",
        a.*
from book b, author a
where b.author_id = a.author_id;