CREATE TABLE "article" (
	article_id SERIAL,
	article_title varchar(50) NOT NULL,
	article_text text NOT NULL,
	PRIMARY KEY(article_id),
	UNIQUE(article_id));

CREATE TABLE "author" (
	author_id SERIAL,
	author_fname varchar(64) NOT NULL,
	author_lname varchar(64) NOT NULL,
	author_age int NOT NULL,
	PRIMARY KEY(author_id),
	UNIQUE(author_id));

CREATE TABLE "category" (
	category_id SERIAL,
	category_title varchar(50) NOT NULL,
	PRIMARY KEY(category_id),
	UNIQUE(category_id));

