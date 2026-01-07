-- Practice SQL
-- Database: SanFranciscoFilmLocations

-- Query: Get all unique film titles from the FilmLocations table
SELECT DISTINCT Title FROM FilmLocations;

/*
Expected Output Structure (first 50 rows shown):
+----------------------------------------+
| Title                                  |
+----------------------------------------+
| 180                                    |
| 24 Hours on Craigslist                |
| A Night Full of Rain                   |
| About a Boy                           |
| Age of Adaline                        |
| After the Thin Man                    |
| Ant-Man                               |
| Americana                             |
| Another 48 Hours                      |
| Around the Fire                       |
| Attack of the Killer Tomatoes         |
| Basic Instinct                        |
| Bedazzled                             |
| Blue Jasmine                          |
| Bee Season                            |
| Bicentennial Man                      |
| Big Eyes                              |
| Big Sur                               |
| Boys and Girls                        |
| Summertime                            |
| Broken-A Modern Love Story            |
| Cardinal X                            |
| Casualties of War                     |
| Class Action                          |
| Common Threads: Stories From the Quilt|
| Confessions of a Burning Man          |
| Copycat                               |
| Dawn of the Planet of the Apes        |
| Desperate Measures                    |
| Doctor Dolittle                       |
| Getting Even with Dad                 |
| Dopamine                              |
| Dr. Dolittle 2                        |
| Faces of Death                        |
| Fandom                                |
| Fat Man and Little Boy                |
| Final Analysis                        |
| Flubber                               |
| Forrest Gump                          |
| 40 Days and 40 Nights                 |
| George of the Jungle                  |
| God is a Communist?* (show me heart universe)|
| Godzilla                              |
| I Am Michael                          |
| Haiku Tunnel                          |
| Happy Gilmore                         |
| Heart and Souls                       |
| Just Like Heaven                      |
| Hereafter                             |
| High Crimes                           |
+----------------------------------------+
(316 unique films total, 266 films hidden in truncated output)

Notes:
- DISTINCT keyword eliminates duplicate film titles
- Returns 316 unique films (as indicated by "266 results hidden" from 50 shown)
- Some titles have special characters or punctuation
- Film titles vary in length and format
- Some appear to be documentaries, TV shows, or specials mixed with feature films
*/

-- File name: select_distinct_film_titles.sql

-- Follow-up analysis queries:

-- 1. Count total unique films
SELECT COUNT(DISTINCT Title) as UniqueFilmCount FROM FilmLocations;
/*
Expected: 316 unique films
*/

-- 2. Get unique films with additional information
SELECT DISTINCT Title, ReleaseYear, Director 
FROM FilmLocations 
ORDER BY Title;
/*
Shows films with their release year and director
*/

-- 3. Films with the most location entries
SELECT Title, COUNT(*) as LocationCount 
FROM FilmLocations 
GROUP BY Title 
ORDER BY LocationCount DESC 
LIMIT 20;
/*
Shows which films have the most filming locations in San Francisco
*/

-- 4. Search for films by keyword
SELECT DISTINCT Title 
FROM FilmLocations 
WHERE Title LIKE '%Man%' 
ORDER BY Title;
/*
Finds all films with "Man" in the title
*/

-- 5. Films by release decade
SELECT 
    FLOOR(ReleaseYear/10)*10 as Decade,
    COUNT(DISTINCT Title) as FilmCount
FROM FilmLocations 
GROUP BY FLOOR(ReleaseYear/10)*10 
ORDER BY Decade;
/*
Shows distribution of films across decades
*/

-- 6. Films without specific information
SELECT DISTINCT Title 
FROM FilmLocations 
WHERE Director = '' 
   OR Writer = '' 
   OR Locations = ''
ORDER BY Title;
/*
Finds films missing key information
*/

-- 7. Alphabetical list with pagination concept
SELECT DISTINCT Title 
FROM FilmLocations 
ORDER BY Title 
LIMIT 50 OFFSET 50;
/*
Gets the second page of 50 films (films 51-100)
*/

-- 8. Films with special characters
SELECT DISTINCT Title 
FROM FilmLocations 
WHERE Title LIKE '%?%' 
   OR Title LIKE '%*%' 
   OR Title LIKE '%-%'
ORDER BY Title;
/*
Finds films with punctuation in titles
*/

-- 9. Shortest and longest film titles
SELECT 
    Title,
    LENGTH(Title) as TitleLength
FROM (
    SELECT DISTINCT Title FROM FilmLocations
) as UniqueTitles
ORDER BY TitleLength 
LIMIT 5;
/*
Shows the 5 shortest film titles
*/

SELECT 
    Title,
    LENGTH(Title) as TitleLength
FROM (
    SELECT DISTINCT Title FROM FilmLocations
) as UniqueTitles
ORDER BY TitleLength DESC 
LIMIT 5;
/*
Shows the 5 longest film titles
*/

-- 10. Films by first letter distribution
SELECT 
    UPPER(LEFT(Title, 1)) as FirstLetter,
    COUNT(DISTINCT Title) as FilmCount
FROM FilmLocations 
GROUP BY UPPER(LEFT(Title, 1))
ORDER BY FirstLetter;
/*
Shows how many films start with each letter of the alphabet
*/