-- Practice SQL
-- Database: SanFranciscoFilmLocations

-- Query: Count films released before 1950
SELECT Count(*) FROM FilmLocations WHERE ReleaseYear < 1950;

/*
Expected Output:
+----------+
| Count(*) |
+----------+
|       62 |
+----------+

Interpretation:
- There are 62 filming location records for films released before 1950
- This represents the "Golden Age of Hollywood" and earlier periods
- Each record is a location entry, so this could represent multiple films with multiple locations
- This is about 1.82% of the total 3414 records (62/3414)
*/

-- File name: count_films_before_1950.sql

-- Follow-up analysis queries:

-- 1. Get detailed breakdown of pre-1950 films
SELECT 
    COUNT(DISTINCT Title) as UniqueFilmCount,
    COUNT(*) as TotalLocationRecords,
    MIN(ReleaseYear) as OldestFilmYear,
    MAX(ReleaseYear) as NewestPre1950Year
FROM FilmLocations 
WHERE ReleaseYear < 1950;
/*
This provides a more complete picture of pre-1950 filming activity
*/

-- 2. List all pre-1950 films
SELECT DISTINCT Title, ReleaseYear, Director 
FROM FilmLocations 
WHERE ReleaseYear < 1950 
ORDER BY ReleaseYear;
/*
This shows which specific films from before 1950 are in the database
*/

-- 3. Pre-1950 films with their locations
SELECT Title, Locations, ReleaseYear, Director 
FROM FilmLocations 
WHERE ReleaseYear < 1950 
  AND Locations != ''
ORDER BY ReleaseYear, Title;
/*
This shows the actual filming locations for early 20th century films
*/

-- 4. Distribution by decade before 1950
SELECT 
    FLOOR(ReleaseYear/10)*10 as Decade,
    COUNT(*) as FilmCount,
    COUNT(DISTINCT Title) as UniqueFilms
FROM FilmLocations 
WHERE ReleaseYear < 1950 
GROUP BY FLOOR(ReleaseYear/10)*10 
ORDER BY Decade;
/*
This shows filming activity by decade in the first half of the 20th century
*/

-- 5. Compare with post-1950 activity
SELECT 
    'Pre-1950' as Period,
    COUNT(*) as LocationRecords,
    COUNT(DISTINCT Title) as UniqueFilms
FROM FilmLocations 
WHERE ReleaseYear < 1950
UNION ALL
SELECT 
    '1950-1999' as Period,
    COUNT(*) as LocationRecords,
    COUNT(DISTINCT Title) as UniqueFilms
FROM FilmLocations 
WHERE ReleaseYear BETWEEN 1950 AND 1999
UNION ALL
SELECT 
    '2000-Present' as Period,
    COUNT(*) as LocationRecords,
    COUNT(DISTINCT Title) as UniqueFilms
FROM FilmLocations 
WHERE ReleaseYear >= 2000;
/*
This compares filming activity across different historical periods
*/

-- 6. Most popular locations in pre-1950 films
SELECT Locations, COUNT(*) as TimesFilmed 
FROM FilmLocations 
WHERE ReleaseYear < 1950 
  AND Locations != ''
GROUP BY Locations 
ORDER BY TimesFilmed DESC 
LIMIT 10;
/*
This shows which locations were most popular in early Hollywood films
*/

-- 7. Directors who worked before 1950
SELECT Director, COUNT(DISTINCT Title) as FilmCount, MIN(ReleaseYear) as FirstFilm
FROM FilmLocations 
WHERE ReleaseYear < 1950 
  AND Director != ''
GROUP BY Director 
ORDER BY FilmCount DESC;
/*
This shows which directors were active in San Francisco before 1950
*/

-- 8. Percentage analysis
SELECT 
    (SELECT COUNT(*) FROM FilmLocations WHERE ReleaseYear < 1950) as Pre1950Count,
    (SELECT COUNT(*) FROM FilmLocations) as TotalCount,
    ROUND(
        (SELECT COUNT(*) FROM FilmLocations WHERE ReleaseYear < 1950) * 100.0 / 
        (SELECT COUNT(*) FROM FilmLocations), 
        2
    ) as Percentage;
/*
Calculates that pre-1950 films represent about 1.82% of total records
*/

-- 9. Year-by-year count of pre-1950 films
SELECT ReleaseYear, COUNT(*) as LocationCount 
FROM FilmLocations 
WHERE ReleaseYear < 1950 
GROUP BY ReleaseYear 
ORDER BY ReleaseYear;
/*
Shows filming activity year by year before 1950
*/

-- 10. Oldest films in the database
SELECT Title, ReleaseYear, Locations, Director 
FROM FilmLocations 
ORDER BY ReleaseYear 
LIMIT 20;
/*
Shows the 20 oldest films in the database
*/