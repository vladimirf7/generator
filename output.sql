CREATE TABLE "author" (
    "author_id" SERIAL PRIMARY KEY,
	"author_lname" varchar(64),
	"author_age" int,
	"author_fname" varchar(64),
    "author_created" INTEGER NOT NULL DEFAULT cast(extract(epoch from now()) AS INTEGER),
    "author_updated" INTEGER NOT NULL DEFAULT cast(extract(epoch from now()) AS INTEGER)
    );

CREATE TABLE "article" (
    "article_id" SERIAL PRIMARY KEY,
	"article_text" text,
	"article_title" varchar(50),
    "article_created" INTEGER NOT NULL DEFAULT cast(extract(epoch from now()) AS INTEGER),
    "article_updated" INTEGER NOT NULL DEFAULT cast(extract(epoch from now()) AS INTEGER)
    );

CREATE TABLE "category" (
    "category_id" SERIAL PRIMARY KEY,
	"category_title" varchar(50),
    "category_created" INTEGER NOT NULL DEFAULT cast(extract(epoch from now()) AS INTEGER),
    "category_updated" INTEGER NOT NULL DEFAULT cast(extract(epoch from now()) AS INTEGER)
    );

