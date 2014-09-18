CREATE TABLE "section" (
	"section_id" SERIAL PRIMARY KEY,
	"section_title" varchar(255),
	"section_created" INTEGER NOT NULL DEFAULT cast(extract(epoch from now()) AS INTEGER),
	"section_updated" INTEGER NOT NULL DEFAULT cast(extract(epoch from now()) AS INTEGER)
);

CREATE TABLE "comment" (
	"comment_id" SERIAL PRIMARY KEY,
	"comment_author" varchar(255),
	"comment_text" varchar(255),
	"comment_date" integer,
	"comment_created" INTEGER NOT NULL DEFAULT cast(extract(epoch from now()) AS INTEGER),
	"comment_updated" INTEGER NOT NULL DEFAULT cast(extract(epoch from now()) AS INTEGER)
);

CREATE TABLE "category" (
	"category_id" SERIAL PRIMARY KEY,
	"category_title" varchar,
	"category_created" INTEGER NOT NULL DEFAULT cast(extract(epoch from now()) AS INTEGER),
	"category_updated" INTEGER NOT NULL DEFAULT cast(extract(epoch from now()) AS INTEGER)
);

CREATE TABLE "user" (
	"user_id" SERIAL PRIMARY KEY,
	"user_name" varchar(255),
	"user_email" varchar(255),
	"user_created" INTEGER NOT NULL DEFAULT cast(extract(epoch from now()) AS INTEGER),
	"user_updated" INTEGER NOT NULL DEFAULT cast(extract(epoch from now()) AS INTEGER)
);

CREATE TABLE "tag" (
	"tag_id" SERIAL PRIMARY KEY,
	"tag_name" varchar(255),
	"tag_created" INTEGER NOT NULL DEFAULT cast(extract(epoch from now()) AS INTEGER),
	"tag_updated" INTEGER NOT NULL DEFAULT cast(extract(epoch from now()) AS INTEGER)
);

CREATE TABLE "post" (
	"post_id" SERIAL PRIMARY KEY,
	"post_content" text,
	"post_title" varchar(255),
	"post_created" INTEGER NOT NULL DEFAULT cast(extract(epoch from now()) AS INTEGER),
	"post_updated" INTEGER NOT NULL DEFAULT cast(extract(epoch from now()) AS INTEGER)
);

CREATE OR REPLACE FUNCTION update_section_timestamp()
RETURNS TRIGGER AS $$
BEGIN
	NEW.section_updated = cast(extract(epoch from now()) as integer);
	RETURN NEW;
END;
$$ language 'plpgsql';
CREATE TRIGGER "tr_section_updated" BEFORE UPDATE ON "section" FOR EACH ROW EXECUTE PROCEDURE update_section_timestamp();

CREATE OR REPLACE FUNCTION update_comment_timestamp()
RETURNS TRIGGER AS $$
BEGIN
	NEW.comment_updated = cast(extract(epoch from now()) as integer);
	RETURN NEW;
END;
$$ language 'plpgsql';
CREATE TRIGGER "tr_comment_updated" BEFORE UPDATE ON "comment" FOR EACH ROW EXECUTE PROCEDURE update_comment_timestamp();

CREATE OR REPLACE FUNCTION update_category_timestamp()
RETURNS TRIGGER AS $$
BEGIN
	NEW.category_updated = cast(extract(epoch from now()) as integer);
	RETURN NEW;
END;
$$ language 'plpgsql';
CREATE TRIGGER "tr_category_updated" BEFORE UPDATE ON "category" FOR EACH ROW EXECUTE PROCEDURE update_category_timestamp();

CREATE OR REPLACE FUNCTION update_user_timestamp()
RETURNS TRIGGER AS $$
BEGIN
	NEW.user_updated = cast(extract(epoch from now()) as integer);
	RETURN NEW;
END;
$$ language 'plpgsql';
CREATE TRIGGER "tr_user_updated" BEFORE UPDATE ON "user" FOR EACH ROW EXECUTE PROCEDURE update_user_timestamp();

CREATE OR REPLACE FUNCTION update_tag_timestamp()
RETURNS TRIGGER AS $$
BEGIN
	NEW.tag_updated = cast(extract(epoch from now()) as integer);
	RETURN NEW;
END;
$$ language 'plpgsql';
CREATE TRIGGER "tr_tag_updated" BEFORE UPDATE ON "tag" FOR EACH ROW EXECUTE PROCEDURE update_tag_timestamp();

CREATE OR REPLACE FUNCTION update_post_timestamp()
RETURNS TRIGGER AS $$
BEGIN
	NEW.post_updated = cast(extract(epoch from now()) as integer);
	RETURN NEW;
END;
$$ language 'plpgsql';
CREATE TRIGGER "tr_post_updated" BEFORE UPDATE ON "post" FOR EACH ROW EXECUTE PROCEDURE update_post_timestamp();

