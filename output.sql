CREATE TABLE "author" (
	"author_id" SERIAL PRIMARY KEY,
	"author_lastname" varchar(64),
	"author_firstname" varchar(64),
	"author_age" int,
	"author_created" INTEGER NOT NULL DEFAULT cast(extract(epoch from now()) AS INTEGER),
	"author_updated" INTEGER NOT NULL DEFAULT cast(extract(epoch from now()) AS INTEGER)
);

CREATE TABLE "category" (
	"category_id" SERIAL PRIMARY KEY,
	"author_lastname" varchar(64),
	"author_firstname" varchar(64),
	"author_age" int,
	"category_title" varchar(50),
	"category_created" INTEGER NOT NULL DEFAULT cast(extract(epoch from now()) AS INTEGER),
	"category_updated" INTEGER NOT NULL DEFAULT cast(extract(epoch from now()) AS INTEGER)
);

CREATE TABLE "article" (
	"article_id" SERIAL PRIMARY KEY,
	"author_lastname" varchar(64),
	"author_firstname" varchar(64),
	"author_age" int,
	"category_title" varchar(50),
	"article_text" text,
	"article_title" varchar(50),
	"article_created" INTEGER NOT NULL DEFAULT cast(extract(epoch from now()) AS INTEGER),
	"article_updated" INTEGER NOT NULL DEFAULT cast(extract(epoch from now()) AS INTEGER)
);

CREATE OR REPLACE FUNCTION update_author_timestamp()
RETURNS TRIGGER AS $$
BEGIN
	NEW.author_updated = cast(extract(epoch from now()) as integer);
	RETURN NEW;
END;
$$ language 'plpgsql';
CREATE TRIGGER "tr_author_updated" BEFORE UPDATE ON "author" FOR EACH ROW EXECUTE PROCEDURE update_author_timestamp();

CREATE OR REPLACE FUNCTION update_category_timestamp()
RETURNS TRIGGER AS $$
BEGIN
	NEW.category_updated = cast(extract(epoch from now()) as integer);
	RETURN NEW;
END;
$$ language 'plpgsql';
CREATE TRIGGER "tr_category_updated" BEFORE UPDATE ON "category" FOR EACH ROW EXECUTE PROCEDURE update_category_timestamp();

CREATE OR REPLACE FUNCTION update_article_timestamp()
RETURNS TRIGGER AS $$
BEGIN
	NEW.article_updated = cast(extract(epoch from now()) as integer);
	RETURN NEW;
END;
$$ language 'plpgsql';
CREATE TRIGGER "tr_article_updated" BEFORE UPDATE ON "article" FOR EACH ROW EXECUTE PROCEDURE update_article_timestamp();

