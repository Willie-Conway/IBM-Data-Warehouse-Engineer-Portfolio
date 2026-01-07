--Drop the table.
DROP TABLE IF EXISTS BookShop_AuthorDetails;
-----Rereate another table BookShop_AuthorDetails with author id as the primary key
CREATE TABLE BookShop_AuthorDetails(AUTHOR_ID INTEGER NOT NULL,AUTHOR_NAME VARCHAR(30) NOT NULL,AUTHOR_BIO VARCHAR(250),PRIMARY KEY (AUTHOR_ID)) ;
-----Insert the records of Bookshop to this table.
insert into BookShop_AuthorDetails select DISTINCT AUTHOR_ID, AUTHOR_NAME, AUTHOR_BIO FROM BookShop;
select * from BookShop_AuthorDetails;