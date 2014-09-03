CREATE TABLE "category" (
	category_id SERIAL,
	category_title varchar(50) NOT NULL,
	category_created INTEGER NOT NULL DEFAULT cast(extract(epoch from now()) AS INTEGER),
	category_updated INTEGER NOT NULL DEFAULT cast(extract(epoch from now()) AS INTEGER),
	PRIMARY KEY(category_id),
	UNIQUE(category_id)
);

CREATE TABLE "author" (
	author_id SERIAL,
	author_age int NOT NULL,
	author_fname varchar(64) NOT NULL,
	author_lname varchar(64) NOT NULL,
	author_created INTEGER NOT NULL DEFAULT cast(extract(epoch from now()) AS INTEGER),
	author_updated INTEGER NOT NULL DEFAULT cast(extract(epoch from now()) AS INTEGER),
	PRIMARY KEY(author_id),
	UNIQUE(author_id)
);

CREATE TABLE "article" (
	article_id SERIAL,
	article_title varchar(50) NOT NULL,
	article_text text NOT NULL,
	article_created INTEGER NOT NULL DEFAULT cast(extract(epoch from now()) AS INTEGER),
	article_updated INTEGER NOT NULL DEFAULT cast(extract(epoch from now()) AS INTEGER),
	PRIMARY KEY(article_id),
	UNIQUE(article_id)
);

