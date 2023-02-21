CREATE TABLE games(
    id serial PRIMARY KEY,
    multiplayer varchar(255),
    last_palayed_at DATE,
    publish_date Date,
    archived Boolean,
)

CREATE TABLE authors(
    id serial PRIMARY KEY,
    first_name varchar(255),
    last_name varchar(255),
)

CREATE TABLE "genre"(
    "id" INT PRIMARY KEY,
    "name" VARCHAR(255)
);

CREATE TABLE "music_albums"(
    "id" INT PRIMARY KEY,
    "on_spotify" BOOLEAN,
    "genre" INT,
    "author" INT,
    "source" INT,
    "label" INT,
    "publish_date" DATE,
    "archived" BOOLEAN
);

ALTER TABLE
    "music_albums" ADD CONSTRAINT "music_albums_genre_foreign" FOREIGN KEY("genre") REFERENCES "genre"("id");