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

CREATE TABLE labels (
  id serial PRIMARY KEY,
  title VARCHAR(200) NOT NULL,
  color VARCHAR(200) NOT NULL,
  PRIMARY KEY (id)
)

CREATE TABLE books (
  id serial PRIMARY KEY,
  publish_date DATE NOT NULL,
  archived BOOLEAN NOT NULL,
  genre_id INT,
  author_id INT,
  label_id INT,
  PRIMARY KEY (id)
  FOREIGN KEY (genre_id) REFERENCES genres(id),
  FOREIGN KEY (author_id) REFERENCES authors(id),
  FOREIGN KEY (label_id) REFERENCES labels(id),  
)

CREATE INDEX genres_id_asc ON genres(id ASC);
CREATE INDEX authors_id_asc ON authors(id ASC);
CREATE INDEX labels_id_asc ON labels(id ASC);

ALTER TABLE
    "music_albums" ADD CONSTRAINT "music_albums_genre_foreign" FOREIGN KEY("genre") REFERENCES "genre"("id");

CREATE INDEX genre_id_asc ON genre(id ASC);
