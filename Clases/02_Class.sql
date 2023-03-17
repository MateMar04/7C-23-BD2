DROP DATABASE IF EXISTS IMDB;
CREATE DATABASE IF NOT EXISTS IMDB;
USE IMDB;

CREATE TABLE FILM
(
    ID           INT AUTO_INCREMENT PRIMARY KEY,
    TITLE        VARCHAR(30),
    DESCRIPCION  TEXT,
    RELEASE_YEAR DATE
);

CREATE TABLE ACTOR
(
    ID         INT AUTO_INCREMENT PRIMARY KEY,
    FIRST_NAME VARCHAR(50),
    LAST_NAME  VARCHAR(50)
);

CREATE TABLE FILM_ACTOR
(
    ID       INT AUTO_INCREMENT PRIMARY KEY,
    FILM_ID  INT,
    ACTOR_ID INT
);

ALTER TABLE ACTOR
    ADD COLUMN LAST_UPDATE DATE;

ALTER TABLE FILM
    ADD COLUMN LAST_UPDATE DATE;


ALTER TABLE FILM_ACTOR
    ADD CONSTRAINT `FILM_ACTOR->FILM` FOREIGN KEY (FILM_ID) REFERENCES FILM (ID);

ALTER TABLE FILM_ACTOR
    ADD CONSTRAINT `FILM_ACTOR->ACTOR` FOREIGN KEY (ACTOR_ID) REFERENCES ACTOR (ID);

INSERT INTO FILM (TITLE, DESCRIPCION, RELEASE_YEAR)
VALUES ('The Shawshank Redemption',
        'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.',
        '1994-09-22'),
       ('The Godfather', 'An organized crime dynasty transfers control from father to son.', '1972-03-24'),
       ('The Dark Knight',
        'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.',
        '2008-07-18'),
       ('Pulp Fiction',
        'The lives of two mob hitmen, a boxer, a gangster and his wife, and a pair of diner bandits intertwine in four tales of violence and redemption.',
        '1994-05-21'),
       ('Forrest Gump',
        'The presidencies of Kennedy and Johnson, the events of Vietnam, Watergate, and other historical events unfold through the perspective of an Alabama man with an IQ of 75, whose only desire is to be reunited with his childhood sweetheart.',
        '1994-07-06');

INSERT INTO ACTOR (FIRST_NAME, LAST_NAME)
VALUES ('Tom', 'Hanks'),
       ('Morgan', 'Freeman'),
       ('Al', 'Pacino'),
       ('Marlon', 'Brando'),
       ('Christian', 'Bale');

INSERT INTO FILM_ACTOR (FILM_ID, ACTOR_ID)
VALUES (1, 1),
       (1, 2),
       (2, 3),
       (2, 4),
       (3, 5);
