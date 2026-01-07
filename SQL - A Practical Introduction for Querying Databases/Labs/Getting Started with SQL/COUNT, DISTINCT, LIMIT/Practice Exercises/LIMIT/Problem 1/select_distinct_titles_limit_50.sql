-- Practice SQL
-- Database: SanFranciscoFilmLocations

-- Query: Get first 50 distinct film titles from the FilmLocations table
SELECT DISTINCT Title FROM FilmLocations LIMIT 50;

/*
Expected Output:
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
(50 distinct film titles)

Interpretation:
- Returns first 50 unique film titles in alphabetical/natural order
- DISTINCT eliminates duplicate titles that occur when films have multiple locations
- LIMIT 50 restricts the output to only 50 records
- Useful for getting a sample of film titles or implementing pagination for film lists
*/

-- File name: select_distinct_titles_limit_50.sql

-- Comprehensive pagination and sampling analysis:

-- 1. Count total distinct films for pagination context
SELECT COUNT(DISTINCT Title) as TotalUniqueFilms FROM FilmLocations;
/*
Expected: 316 unique films (based on previous queries)
50 shown here represents about 15.8% of total films
*/

-- 2. Get next 50 distinct films (page 2)
SELECT DISTINCT Title FROM FilmLocations LIMIT 50 OFFSET 50;

-- 3. Get all distinct films with pagination metadata
SELECT 
    COUNT(*) OVER() as TotalFilms,
    ROW_NUMBER() OVER(ORDER BY Title) as RowNum,
    Title
FROM (
    SELECT DISTINCT Title FROM FilmLocations
) AS UniqueFilms
ORDER BY Title
LIMIT 50;

-- 4. Alphabetical distribution analysis
SELECT 
    UPPER(LEFT(Title, 1)) as FirstLetter,
    COUNT(*) as FilmCount
FROM (
    SELECT DISTINCT Title FROM FilmLocations
) AS UniqueFilms
GROUP BY UPPER(LEFT(Title, 1))
ORDER BY FirstLetter;
/*
Shows film distribution by first letter
*/

-- 5. Get films starting with specific letters
SELECT DISTINCT Title 
FROM FilmLocations 
WHERE Title LIKE 'A%'
ORDER BY Title
LIMIT 50;
/*
Returns films starting with 'A'
*/

-- 6. Pagination with complete film information
SELECT DISTINCT 
    Title,
    ReleaseYear,
    Director
FROM FilmLocations 
ORDER BY Title
LIMIT 50;

-- 7. Most recent films (first 50 by release date)
SELECT DISTINCT 
    Title,
    ReleaseYear
FROM FilmLocations 
ORDER BY ReleaseYear DESC
LIMIT 50;

-- 8. Oldest films (first 50 by release date)
SELECT DISTINCT 
    Title,
    ReleaseYear
FROM FilmLocations 
ORDER BY ReleaseYear
LIMIT 50;

-- 9. Films with location count (first 50)
SELECT 
    Title,
    COUNT(*) as LocationCount
FROM FilmLocations 
GROUP BY Title
ORDER BY Title
LIMIT 50;

-- 10. Search within the first 50 films
SELECT * FROM (
    SELECT DISTINCT Title FROM FilmLocations LIMIT 50
) AS First50
WHERE Title LIKE '%Man%' OR Title LIKE '%Love%';
/*
Search for specific keywords within first 50 films
*/

-- 11. Pagination helper: Calculate page ranges
SELECT 
    1 as PageNumber,
    50 as PageSize,
    MIN(Title) as FirstFilm,
    MAX(Title) as LastFilm,
    COUNT(*) as FilmsOnPage
FROM (
    SELECT DISTINCT Title 
    FROM FilmLocations 
    ORDER BY Title 
    LIMIT 50
) AS Page1;

-- 12. Compare with random sample
SELECT DISTINCT Title 
FROM FilmLocations 
ORDER BY RANDOM()
LIMIT 50;

-- 13. Films by title length (first 50)
SELECT 
    Title,
    LENGTH(Title) as TitleLength
FROM (
    SELECT DISTINCT Title FROM FilmLocations
) AS UniqueFilms
ORDER BY TitleLength, Title
LIMIT 50;

-- 14. Films containing numbers in title
SELECT DISTINCT Title 
FROM FilmLocations 
WHERE Title REGEXP '[0-9]'
ORDER BY Title
LIMIT 50;

-- 15. Complete pagination system example
-- For a web application showing 50 films per page:
/*
SET @page_number = 1;
SET @page_size = 50;
SET @offset = (@page_number - 1) * @page_size;

SELECT 
    Title,
    ReleaseYear,
    (SELECT COUNT(DISTINCT Title) FROM FilmLocations) as TotalFilms,
    CEIL((SELECT COUNT(DISTINCT Title) FROM FilmLocations) / @page_size) as TotalPages
FROM FilmLocations 
GROUP BY Title, ReleaseYear
ORDER BY Title
LIMIT @page_size OFFSET @offset;
*/

-- 16. Verify first 50 films are truly distinct
SELECT Title, COUNT(*) as DuplicateCount
FROM (
    SELECT DISTINCT Title FROM FilmLocations LIMIT 50
) AS First50
GROUP BY Title
HAVING COUNT(*) > 1;
/*
Should return 0 rows if truly distinct
*/

-- 17. Films with special characters (first 50)
SELECT DISTINCT Title 
FROM FilmLocations 
WHERE Title REGEXP '[^a-zA-Z0-9 ]'
ORDER BY Title
LIMIT 50;

-- 18. Pagination with film statistics
SELECT 
    f.Title,
    f.ReleaseYear,
    COUNT(fl.Locations) as LocationCount
FROM (
    SELECT DISTINCT Title, ReleaseYear 
    FROM FilmLocations 
    ORDER BY Title 
    LIMIT 50
) AS f
JOIN FilmLocations fl ON f.Title = fl.Title
GROUP BY f.Title, f.ReleaseYear
ORDER BY f.Title;

-- 19. Export first 50 films for analysis
/*
This query could be used to export a sample for further analysis
*/
SELECT DISTINCT 
    Title,
    MIN(ReleaseYear) as ReleaseYear,
    GROUP_CONCAT(DISTINCT Director) as Directors,
    COUNT(*) as TotalLocations
FROM FilmLocations 
GROUP BY Title
ORDER BY Title
LIMIT 50;