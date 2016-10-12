---------------- create tables ---------------------------------------
/*

drop table versions;
drop table pages;
drop table student_pages;

*/

create table versions
(
    id       int,
    test_id  int,
    name     char 
);

create table pages
(
    id          int,
    version_id  int,
    index       int
);


create table student_pages
(
    student_id  int not null,
    page_id     int not null   
);

---------

/*
ALTER TABLE pages
ADD CONSTRAINT pages_version_id_fk
FOREIGN KEY (version_id) REFERENCES versions (id);

ALTER TABLE student_pages
ADD CONSTRAINT student_pages_page_id_fk
FOREIGN KEY (page_id) REFERENCES pages (id);

*/

---------

insert into versions (id, test_id, name) values (1, 1, 'F');
insert into versions (id, test_id, name) values (2, 1, 'F');
insert into versions (id, test_id, name) values (3, 1, 'F');

insert into versions (id, test_id, name) values (4, 2, 'S');
insert into versions (id, test_id, name) values (5, 2, 'S');
insert into versions (id, test_id, name) values (6, 2, 'S');

insert into versions (id, test_id, name) values (7, 3, 'T');
insert into versions (id, test_id, name) values (8, 3, 'T');
insert into versions (id, test_id, name) values (9, 3, 'T');


------

insert into pages (id, version_id, index) values (1, 1, 1 );
insert into pages (id, version_id, index) values (2, 1, 2 );
insert into pages (id, version_id, index) values (3, 1, 3 );
insert into pages (id, version_id, index) values (4, 1, 4 );

insert into pages (id, version_id, index) values (5, 2, 1 );
insert into pages (id, version_id, index) values (6, 2, 2 );
insert into pages (id, version_id, index) values (7, 2, 3 );
insert into pages (id, version_id, index) values (8, 2, 4 );

insert into pages (id, version_id, index) values ( 9, 3, 1 );
insert into pages (id, version_id, index) values (10, 3, 2 );
insert into pages (id, version_id, index) values (11, 3, 3 );
insert into pages (id, version_id, index) values (12, 3, 4 );

insert into pages (id, version_id, index) values (13, 4, 1 );
insert into pages (id, version_id, index) values (14, 4, 2 );
insert into pages (id, version_id, index) values (15, 4, 3 );
insert into pages (id, version_id, index) values (16, 4, 4 );

insert into pages (id, version_id, index) values (17, 5, 1 );
insert into pages (id, version_id, index) values (18, 5, 2 );
insert into pages (id, version_id, index) values (19, 5, 3 );
insert into pages (id, version_id, index) values (20, 5, 4 );

insert into pages (id, version_id, index) values (21, 6, 1 );
insert into pages (id, version_id, index) values (22, 6, 2 );
insert into pages (id, version_id, index) values (23, 6, 3 );
insert into pages (id, version_id, index) values (24, 6, 4 );

insert into pages (id, version_id, index) values (25, 7, 1 );
insert into pages (id, version_id, index) values (26, 7, 2 );
insert into pages (id, version_id, index) values (27, 7, 3 );
insert into pages (id, version_id, index) values (28, 7, 4 );

insert into pages (id, version_id, index) values (29, 8, 1 );
insert into pages (id, version_id, index) values (30, 8, 2 );
insert into pages (id, version_id, index) values (31, 8, 3 );
insert into pages (id, version_id, index) values (32, 8, 4 );

insert into pages (id, version_id, index) values (33, 9, 1 );
insert into pages (id, version_id, index) values (34, 9, 2 );
insert into pages (id, version_id, index) values (35, 9, 3 );
insert into pages (id, version_id, index) values (36, 9, 4 );


--

-------- 1-й ученик ничего не потерял ------

-- 1-й ученик, вариант 1 (тест 1), все листы сданы
insert into student_pages (student_id, page_id) values (1, 1);
insert into student_pages (student_id, page_id) values (1, 2);
insert into student_pages (student_id, page_id) values (1, 3);
insert into student_pages (student_id, page_id) values (1, 4);

-- 1-й ученик, вариант 5 (тест 2), все листы сданы
insert into student_pages (student_id, page_id) values (1, 17);
insert into student_pages (student_id, page_id) values (1, 18);
insert into student_pages (student_id, page_id) values (1, 19);
insert into student_pages (student_id, page_id) values (1, 20);

-- 1-й ученик, вариант 9 (тест 3), все листы сданы
insert into student_pages (student_id, page_id) values (1, 33);
insert into student_pages (student_id, page_id) values (1, 34);
insert into student_pages (student_id, page_id) values (1, 35);
insert into student_pages (student_id, page_id) values (1, 36);


--- 2-й потерял 2 страницы 4-го варианта                                      -- #2

-- 2-й ученик, вариант 3 (тест 1), все листы сданы
insert into student_pages (student_id, page_id) values (2, 9);
insert into student_pages (student_id, page_id) values (2, 10);
insert into student_pages (student_id, page_id) values (2, 11);
insert into student_pages (student_id, page_id) values (2, 12);

-- 2-й ученик, вариант 5 (тест 2), все листы сданы
--insert into student_pages (student_id, page_id) values (2, 17);
insert into student_pages (student_id, page_id) values (2, 18);
--insert into student_pages (student_id, page_id) values (2, 19);
insert into student_pages (student_id, page_id) values (2, 20);

-- 2-й ученик, вариант 8 (тест 3), все листы сданы
insert into student_pages (student_id, page_id) values (2, 29);
insert into student_pages (student_id, page_id) values (2, 30);
insert into student_pages (student_id, page_id) values (2, 31);
insert into student_pages (student_id, page_id) values (2, 32);


---- 3-й ученик ничего не потерял ---------

-- 3-й ученик, вариант 2 (тест 1), все листы сданы
insert into student_pages (student_id, page_id) values (3, 5);
insert into student_pages (student_id, page_id) values (3, 6);
insert into student_pages (student_id, page_id) values (3, 7);
insert into student_pages (student_id, page_id) values (3, 8);

-- 3-й ученик, вариант 4 (тест 2), все листы сданы
insert into student_pages (student_id, page_id) values (3, 13);
insert into student_pages (student_id, page_id) values (3, 14);
insert into student_pages (student_id, page_id) values (3, 15);
insert into student_pages (student_id, page_id) values (3, 16);

-- 3-й ученик, вариант 7 (тест 3), все листы сданы
insert into student_pages (student_id, page_id) values (3, 25);
insert into student_pages (student_id, page_id) values (3, 26);
insert into student_pages (student_id, page_id) values (3, 27);
insert into student_pages (student_id, page_id) values (3, 28);


---- 4-й ученик потерял 1 страницу первого теста и одну третьего ---------    -- #4

-- 4-й ученик, вариант 3 (тест 1), потеряна одна страница
--insert into student_pages (student_id, page_id) values (4, 5);
insert into student_pages (student_id, page_id) values (4, 6);
insert into student_pages (student_id, page_id) values (4, 7);
insert into student_pages (student_id, page_id) values (4, 8);

-- 4-й ученик, вариант 4 (тест 2), все листы сданы
insert into student_pages (student_id, page_id) values (4, 13);
insert into student_pages (student_id, page_id) values (4, 14);
insert into student_pages (student_id, page_id) values (4, 15);
insert into student_pages (student_id, page_id) values (4, 16);

-- 4-й ученик, вариант 7 (тест 3), потеряна одна страница
insert into student_pages (student_id, page_id) values (4, 25);
insert into student_pages (student_id, page_id) values (4, 26);
insert into student_pages (student_id, page_id) values (4, 27);
--insert into student_pages (student_id, page_id) values (4, 28);


---- 5-й ученик потерял 1 страницу первого теста и одну второго ---------  -- #6

-- 5-й ученик, вариант 1 (тест 1), все листы сданы
insert into student_pages (student_id, page_id) values (5, 1);
--insert into student_pages (student_id, page_id) values (5, 2);
insert into student_pages (student_id, page_id) values (5, 3);
insert into student_pages (student_id, page_id) values (5, 4);

-- 5-й ученик, вариант 5 (тест 2), все листы сданы
insert into student_pages (student_id, page_id) values (5, 17);
insert into student_pages (student_id, page_id) values (5, 18);
insert into student_pages (student_id, page_id) values (5, 19);
--insert into student_pages (student_id, page_id) values (5, 20);

-- 5-й ученик, вариант 9 (тест 3), все листы сданы
insert into student_pages (student_id, page_id) values (5, 33);
insert into student_pages (student_id, page_id) values (5, 34);
insert into student_pages (student_id, page_id) values (5, 35);
insert into student_pages (student_id, page_id) values (5, 36);


---- 6-й ученик не вообще сдавал третий тест, остальные страницы есть  ---------

-- 6-й ученик, вариант 1 (тест 1), все листы сданы
insert into student_pages (student_id, page_id) values (6, 1);
insert into student_pages (student_id, page_id) values (6, 2);
insert into student_pages (student_id, page_id) values (6, 3);
insert into student_pages (student_id, page_id) values (6, 4);

-- 6-й ученик, вариант 5 (тест 2), все листы сданы
insert into student_pages (student_id, page_id) values (6, 17);
insert into student_pages (student_id, page_id) values (6, 18);
insert into student_pages (student_id, page_id) values (6, 19);
insert into student_pages (student_id, page_id) values (6, 20);


---- 7-й ученик потерял 3 страницs третьего теста      ---------  -- #7

-- 7-й ученик, вариант 1 (тест 1), все листы сданы
insert into student_pages (student_id, page_id) values (7, 1);
insert into student_pages (student_id, page_id) values (7, 2);
insert into student_pages (student_id, page_id) values (7, 3);
insert into student_pages (student_id, page_id) values (7, 4);

-- 7-й ученик, вариант 5 (тест 2), все листы сданы
insert into student_pages (student_id, page_id) values (7, 17);
insert into student_pages (student_id, page_id) values (7, 18);
insert into student_pages (student_id, page_id) values (7, 19);
insert into student_pages (student_id, page_id) values (7, 20);

-- 7-й ученик, вариант 9 (тест 3), все листы сданы
insert into student_pages (student_id, page_id) values (7, 33);
--insert into student_pages (student_id, page_id) values (7, 34);
--insert into student_pages (student_id, page_id) values (7, 35);
--insert into student_pages (student_id, page_id) values (7, 36);
