-- EXERCISES
-- Author: Marc Aradillas
-- Date: 06-26-2023

-- Create a new file called basic_statement_exercises.sql and save your work there. You should be testing your code in MySQL Workbench as you go.

# ✔️

-- 1. Use the albums_db database.

SHOW DATABASES;
USE albums_db;
SELECT database();

-- 2. What is the primary key for the albums table?

SHOW TABLES;

# The primary key is INT UNSIGNED - "id"

/*
SELECT COLUMN_NAME 
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE 
WHERE TABLE_SCHEMA = 'albums.db'
	AND TABLE_NAME = 'albums'
    AND CONSTRAINT_NAME = 'PRIMARY';
*/

-- 3. What does the column named 'name' represent?

SELECT * FROM albums;

# It represents the names albums

-- 4. What do you think the sales column represents?

# This value represents the number of albums sold

-- 5. Find the name of all albums by Pink Floyd.

SELECT name, artist
FROM albums
WHERE artist = 'Pink Floyd';

# The Dark Side of the Moon, The Wall

-- 6. What is the year Sgt. Pepper's Lonely Hearts Club Band was released?

SELECT release_date
FROM albums
WHERE name = 'Sgt. Pepper\'s Lonely Hearts Club Band';

# 1967

-- 7. What is the genre for the album Nevermind?

SELECT * FROM albums;

SELECT genre
FROM albums
WHERE name = 'Nevermind';

# Grunge, Alternative rock

-- 8. Which albums were released in the 1990s?

SELECT * FROM albums;

SELECT name
FROM albums
WHERE release_date BETWEEN 1990 and 1999; # BETWEEN function more precise

# The Bodyguard, Jagged Little Pill, Come On Over, Falling into You, 21, Let's Talk About Love, 1, Dangerous, The immaculate Collection, 
# Titanic: Music from the Motion Picture, Metallica, Nevermind, Supernatural

-- 9. Which albums had less than 20 million certified sales? Rename this column as low_selling_albums.

-- SELECT name
-- FROM albums
-- WHERE sales < 20.0;

# adams's attempt below
-- SELECT DISTINCT sales AS low_selling_albums from albums;
-- SELECT * FROM albums WHERE sales < 20;

# instructor entry
SELECT name 
AS low_selling_albums #as keyword used rename the column (use quotes '' for names that have spaces between words)
FROM albums 
WHERE sales < 20;

/*
'Grease: The Original Soundtrack from the Motion Picture', 'Bad', 'Sgt. Pepper\'s Lonely Hearts Club Band',
'Dirty Dancing', 'Let\'s Talk About Love', 'Dangerous', 'The Immaculate Collection', 'Abbey Road', 'Born in the U.S.A.'
'Brothers in Arms', 'Titanic: Music from the Motion Picture', 'Nevermind', 'The Wall'
*/

