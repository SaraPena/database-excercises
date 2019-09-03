-- 1. Create a new file called 3.4_select_exercises.sql. Do your work for this exercise in that file.

-- 2. Use the albums_db database.
SHOW DATABASES;
USE albums_db;

-- 3. Explore the structure of the albums table.
Describe albums;

-- 4. Write queries to find the following information.
--	The name of all albums by Pink Floyd.
SELECT name FROM albums WHERE artist = 'Pink Floyd';

--	The year Sgt. Pepper's Lonely Hearts Club Band was released.
describe albums;
Select release_date FROM albums WHERE name = 'Sgt. Pepper\'s Lonely Hearts Club Band';

--	The genre for the album Nevermind.
describe albums;
SELECT genre FROM albums WHERE name = 'Nevermind';

--	Which albums were released in the 1990s.
describe albums;
SELECT name, release_date FROM albums Where release_date BETWEEN 1990 AND 1999;

--	Which albums had less than 20 million certified sales.
describe albums;
SELECT name, sales FROM albums WHERE sales < 20;

-- All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"? These result do not include "Hard rock" or "Progressive rock" because in our code we are only asking for the specific work in the genre "Rock".
SELECT name, genre FROM albums WHERE genre = 'Rock';
