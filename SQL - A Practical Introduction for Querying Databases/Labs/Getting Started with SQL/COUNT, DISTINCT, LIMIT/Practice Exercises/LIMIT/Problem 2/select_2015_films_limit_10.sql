-- Practice SQL
-- Database: SanFranciscoFilmLocations

-- Query: Get first 10 distinct films released in 2015
SELECT DISTINCT Title FROM FilmLocations WHERE ReleaseYear = 2015 LIMIT 10;

/*
Expected Output:
+--------------------+
| Title              |
+--------------------+
| Age of Adaline     |
| Ant-Man            |
| Americana          |
| Summertime         |
| Cardinal X         |
| I Am Michael       |
| Steve Jobs         |
| Quitters           |
| San Andreas        |
| Sense8             |
+--------------------+
(10 distinct films from 2015)

Interpretation:
- Returns 10 unique films that were released in 2015 and filmed in San Francisco
- DISTINCT ensures each film appears only once, even if it has multiple locations
- LIMIT 10 restricts output to first 10 results (typically alphabetical order)
- 2015 was an active year for San Francisco filming with diverse films
*/

-- File name: select_2015_films_limit_10.sql

-- Comprehensive analysis of 2015 San Francisco films:

-- 1. Count total 2015 films in database
SELECT COUNT(DISTINCT Title) as Total2015Films 
FROM FilmLocations 
WHERE ReleaseYear = 2015;
/*
This shows how many total 2015 films are in the database
*/

-- 2. Get all 2015 films with complete details
SELECT DISTINCT 
    Title, 
    Director,
    ProductionCompany,
    COUNT(*) as LocationCount
FROM FilmLocations 
WHERE ReleaseYear = 2015 
GROUP BY Title, Director, ProductionCompany
ORDER BY Title;
/*
Shows all 2015 films with their directors and location counts
*/

-- 3. Next 10 films from 2015 (pagination)
SELECT DISTINCT Title 
FROM FilmLocations 
WHERE ReleaseYear = 2015 
LIMIT 10 OFFSET 10;
/*
Gets films 11-20 from 2015
*/

-- 4. 2015 films with most filming locations
SELECT 
    Title,
    COUNT(*) as LocationCount
FROM FilmLocations 
WHERE ReleaseYear = 2015 
GROUP BY Title
ORDER BY LocationCount DESC
LIMIT 10;
/*
Shows which 2015 films used the most San Francisco locations
*/

-- 5. 2015 films by production company
SELECT 
    ProductionCompany,
    COUNT(DISTINCT Title) as FilmCount,
    GROUP_CONCAT(DISTINCT Title ORDER BY Title) as Films
FROM FilmLocations 
WHERE ReleaseYear = 2015 
  AND ProductionCompany != ''
GROUP BY ProductionCompany
ORDER BY FilmCount DESC;
/*
Shows distribution of 2015 films across production companies
*/

-- 6. 2015 films with actor information
SELECT DISTINCT 
    Title,
    Actor1,
    Actor2,
    Actor3
FROM FilmLocations 
WHERE ReleaseYear = 2015 
  AND (Actor1 != '' OR Actor2 != '' OR Actor3 != '')
ORDER BY Title;
/*
Shows 2015 films with their cast information
*/

-- 7. 2015 films with fun facts
SELECT DISTINCT 
    Title,
    Locations,
    FunFacts
FROM FilmLocations 
WHERE ReleaseYear = 2015 
  AND FunFacts != ''
ORDER BY Title;
/*
Shows 2015 films that have interesting filming facts
*/

-- 8. Compare 2015 with other recent years
SELECT 
    ReleaseYear,
    COUNT(DISTINCT Title) as FilmCount
FROM FilmLocations 
WHERE ReleaseYear BETWEEN 2010 AND 2015
GROUP BY ReleaseYear
ORDER BY ReleaseYear DESC;
/*
Shows filming activity from 2010-2015
*/

-- 9. Most popular filming locations in 2015
SELECT 
    Locations,
    COUNT(DISTINCT Title) as FilmCount
FROM FilmLocations 
WHERE ReleaseYear = 2015 
  AND Locations != ''
GROUP BY Locations
ORDER BY FilmCount DESC
LIMIT 10;
/*
Shows which locations were most popular in 2015
*/

-- 10. 2015 film genres/themes based on titles
SELECT 
    CASE 
        WHEN Title LIKE '%Man%' OR Title LIKE '%Men%' THEN 'Male-centric'
        WHEN Title LIKE '%Woman%' OR Title LIKE '%Women%' OR Title LIKE '%Girl%' THEN 'Female-centric'
        WHEN Title LIKE '%Love%' OR Title LIKE '%Heart%' THEN 'Romance'
        WHEN Title LIKE '%Action%' OR Title LIKE '%War%' OR Title LIKE '%Battle%' THEN 'Action'
        WHEN Title LIKE '%Comedy%' OR Title LIKE '%Funny%' THEN 'Comedy'
        WHEN Title LIKE '%Drama%' OR Title LIKE '%Story%' THEN 'Drama'
        WHEN Title LIKE '%Science%' OR Title LIKE '%Space%' OR Title LIKE '%Future%' THEN 'Sci-Fi'
        WHEN Title LIKE '%Crime%' OR Title LIKE '%Murder%' OR Title LIKE '%Mystery%' THEN 'Crime'
        ELSE 'Other'
    END as InferredGenre,
    GROUP_CONCAT(DISTINCT Title ORDER BY Title) as Films,
    COUNT(DISTINCT Title) as FilmCount
FROM FilmLocations 
WHERE ReleaseYear = 2015
GROUP BY 
    CASE 
        WHEN Title LIKE '%Man%' OR Title LIKE '%Men%' THEN 'Male-centric'
        WHEN Title LIKE '%Woman%' OR Title LIKE '%Women%' OR Title LIKE '%Girl%' THEN 'Female-centric'
        WHEN Title LIKE '%Love%' OR Title LIKE '%Heart%' THEN 'Romance'
        WHEN Title LIKE '%Action%' OR Title LIKE '%War%' OR Title LIKE '%Battle%' THEN 'Action'
        WHEN Title LIKE '%Comedy%' OR Title LIKE '%Funny%' THEN 'Comedy'
        WHEN Title LIKE '%Drama%' OR Title LIKE '%Story%' THEN 'Drama'
        WHEN Title LIKE '%Science%' OR Title LIKE '%Space%' OR Title LIKE '%Future%' THEN 'Sci-Fi'
        WHEN Title LIKE '%Crime%' OR Title LIKE '%Murder%' OR Title LIKE '%Mystery%' THEN 'Crime'
        ELSE 'Other'
    END
ORDER BY FilmCount DESC;
/*
Attempts to categorize 2015 films by genre based on title keywords
*/

-- 11. 2015 films by distributor
SELECT 
    Distributor,
    COUNT(DISTINCT Title) as FilmCount,
    GROUP_CONCAT(DISTINCT Title ORDER BY Title) as Films
FROM FilmLocations 
WHERE ReleaseYear = 2015 
  AND Distributor != ''
GROUP BY Distributor
ORDER BY FilmCount DESC;
/*
Shows which distributors handled 2015 San Francisco films
*/

-- 12. 2015 directors and their films
SELECT 
    Director,
    COUNT(DISTINCT Title) as FilmCount,
    GROUP_CONCAT(DISTINCT Title ORDER BY Title) as Films
FROM FilmLocations 
WHERE ReleaseYear = 2015 
  AND Director != ''
GROUP BY Director
ORDER BY FilmCount DESC;
/*
Shows directors who worked in San Francisco in 2015
*/

-- 13. Complete 2015 film timeline
SELECT 
    Title,
    MIN(ReleaseYear) as ReleaseYear,
    GROUP_CONCAT(DISTINCT Locations ORDER BY Locations) as FilmingLocations,
    COUNT(*) as TotalLocations
FROM FilmLocations 
WHERE ReleaseYear = 2015
GROUP BY Title
ORDER BY Title;
/*
Creates comprehensive overview of 2015 films
*/

-- 14. 2015 vs overall statistics
SELECT 
    '2015 Films' as Category,
    COUNT(DISTINCT Title) as FilmCount,
    AVG(LocationCount) as AvgLocationsPerFilm
FROM (
    SELECT Title, COUNT(*) as LocationCount
    FROM FilmLocations 
    WHERE ReleaseYear = 2015
    GROUP BY Title
) as FilmStats
UNION ALL
SELECT 
    'All Films' as Category,
    COUNT(DISTINCT Title) as FilmCount,
    AVG(LocationCount) as AvgLocationsPerFilm
FROM (
    SELECT Title, COUNT(*) as LocationCount
    FROM FilmLocations 
    GROUP BY Title
) as AllFilmStats;
/*
Compares 2015 films with overall averages
*/

-- 15. Export 2015 film data for visualization
/*
This query structure could be used for data export:
*/
SELECT 
    Title,
    ReleaseYear,
    Director,
    ProductionCompany,
    Distributor,
    GROUP_CONCAT(DISTINCT Locations ORDER BY Locations) as AllLocations,
    COUNT(*) as LocationCount,
    GROUP_CONCAT(DISTINCT Actor1, Actor2, Actor3) as Cast
FROM FilmLocations 
WHERE ReleaseYear = 2015
GROUP BY Title, ReleaseYear, Director, ProductionCompany, Distributor
ORDER BY Title;