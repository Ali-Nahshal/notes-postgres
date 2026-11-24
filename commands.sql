CREATE TABLE notes (
    id SERIAL PRIMARY KEY,
    content text NOT NULL,
    important boolean,
    date time
);

insert into notes (content, important) values ('Relational databases rule the world', true);
insert into notes (content, important) values ('MongoDB is webscale', false);

select * from notes;

drop table notes;

SELECT content, important FROM notes;

SELECT * FROM notes WHERE important = true;

UPDATE notes SET important = true WHERE id = 2;

DELETE FROM notes WHERE id = 2;

ALTER TABLE notes ADD COLUMN user_id integer REFERENCES users(id);

-- Fetching notes with their creator's name
SELECT notes.id, notes.content, notes.important, notes.date, users.name
FROM notes
LEFT OUTER JOIN users ON notes.user_id = users.id;

-- Fetching users with their notes
SELECT users.*, notes.*
FROM users
LEFT OUTER JOIN notes ON users.id = notes.user_id;

SELECT "note". "id", "note". "content", "note". "important", "note". "date", "user". "id" 
        AS "user.id", "user". "name" 
        AS "user.name"
        FROM "notes" 
        AS "note" 
        LEFT OUTER JOIN "users" 
        AS "user" ON "note". "user_id" = "user". "id"
        WHERE "note". "important" = true;

-- Fetching with (Op.in)
SELECT "note"."id", "note"."content", "note"."important", "note"."date", "user"."id" 
        AS "user.id", "user"."name" 
        AS "user.name" 
        FROM "notes" 
        AS "note" 
        LEFT OUTER JOIN "users" 
        AS "user" 
        ON "note"."user_id" = "user"."id" 
        WHERE "note"."important" IN (true, false);

-- Search request without conditions the query does not have an unnecessary WHERE
SELECT "note". "id", "note". "content", "note". "important", "note". "date", "user". "id" 
        AS "user.id", "user". "name" 
        AS "user.name"
        FROM "notes" 
        AS "note" 
        LEFT OUTER JOIN "users" 
        AS "user" 
        ON "note". "user_id" = "user". "id";

-- Case-insensitive substring search (Op.iLike)
SELECT * FROM notes WHERE content ILIKE '%database%';