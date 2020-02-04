/*Exercises
1. Create a new file named 3.4_select_exercises.sql. Do you work for these exercises in that file.

2. Use the `albums_db` database */

/* SHOW databases; */

USE albums_db;

/* 3. Explore the structure of the `albums` table */

DESCRIBE albums;

/* 4. Write queries to find the following information.
 - The name of all albums by Pink Floyd*/
 
SELECT 'Albums by Pink Floyd' as INFO;
 
SELECT name
From albums
WHERE artist = 'Pink Floyd';

/* The year Sgt. Pepper's Lonely Hearts Club Band was released*/

SELECT 'The year Sgt. Pepper\'s Lonely Hearts Club Band was released' as INFO;

SELECT release_date
FROM albums
WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";

/*The genre of the album Nevermind*/

SELECT 'Genre of the album Nevermind' as INFO;

SELECT genre
FROM albums
WHERE name = 'Nevermind';

/* Which albums were relased in the 90's*/

SELECT 'Which albums were released in the 90\'s' as INFO;

SELECT name
From albums
WHERE release_date BETWEEN 1990 and 1999;

/* Which albums had less than 20 million certified sales*/

SELECT 'Which albums had less than 20 million certified sales' as INFO;

SELECT name
FROM albums
WHERE sales < 20;

/*All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?
ANSWER - using the `=` operator only gives you exact matches to Rock. */

SELECT 'All the albums with a genre \'Rock\'' as INFO;

SELECT name, genre
FROM albums
WHERE genre = 'ROCK';