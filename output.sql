CREATE TABLE "category" (
    "category_id" SERIAL PRIMARY KEY,
    "category_title" varchar,
    "category_created" timestamp DEFAULT CURRENT_TIMESTAMP,
    "category_updated" timestamp DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "comment" (
    "comment_id" SERIAL PRIMARY KEY,
    "comment_date" integer,
    "comment_author" varchar(255),
    "comment_text" varchar(255),
    "comment_created" timestamp DEFAULT CURRENT_TIMESTAMP,
    "comment_updated" timestamp DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "section" (
    "section_id" SERIAL PRIMARY KEY,
    "section_title" varchar(255),
    "section_created" timestamp DEFAULT CURRENT_TIMESTAMP,
    "section_updated" timestamp DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "user" (
    "user_id" SERIAL PRIMARY KEY,
    "user_email" varchar(255),
    "user_name" varchar(255),
    "user_created" timestamp DEFAULT CURRENT_TIMESTAMP,
    "user_updated" timestamp DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "post" (
    "post_id" SERIAL PRIMARY KEY,
    "post_content" text,
    "post_title" varchar(255),
    "post_created" timestamp DEFAULT CURRENT_TIMESTAMP,
    "post_updated" timestamp DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "tag" (
    "tag_id" SERIAL PRIMARY KEY,
    "tag_name" varchar(255),
    "tag_created" timestamp DEFAULT CURRENT_TIMESTAMP,
    "tag_updated" timestamp DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION update_category_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.category_updated = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';
CREATE TRIGGER "tr_category_updated" BEFORE UPDATE ON "category" FOR EACH ROW EXECUTE PROCEDURE update_category_timestamp();

CREATE OR REPLACE FUNCTION update_comment_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.comment_updated = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';
CREATE TRIGGER "tr_comment_updated" BEFORE UPDATE ON "comment" FOR EACH ROW EXECUTE PROCEDURE update_comment_timestamp();

CREATE OR REPLACE FUNCTION update_section_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.section_updated = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';
CREATE TRIGGER "tr_section_updated" BEFORE UPDATE ON "section" FOR EACH ROW EXECUTE PROCEDURE update_section_timestamp();

CREATE OR REPLACE FUNCTION update_user_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.user_updated = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';
CREATE TRIGGER "tr_user_updated" BEFORE UPDATE ON "user" FOR EACH ROW EXECUTE PROCEDURE update_user_timestamp();

CREATE OR REPLACE FUNCTION update_post_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.post_updated = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';
CREATE TRIGGER "tr_post_updated" BEFORE UPDATE ON "post" FOR EACH ROW EXECUTE PROCEDURE update_post_timestamp();

CREATE OR REPLACE FUNCTION update_tag_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.tag_updated = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';
CREATE TRIGGER "tr_tag_updated" BEFORE UPDATE ON "tag" FOR EACH ROW EXECUTE PROCEDURE update_tag_timestamp();

