-- Practice SQL
-- Database: SanFranciscoFilmLocations

-- Query: Count distinct release years for films produced by Warner Bros. Pictures
SELECT COUNT(DISTINCT ReleaseYear) FROM FilmLocations WHERE ProductionCompany = "Warner Bros. Pictures";

/*
Expected Output:
+------------------------------+
| COUNT(DISTINCT ReleaseYear) |
+------------------------------+
|                           14 |
+------------------------------+

Interpretation:
- Warner Bros. Pictures has produced films that were shot in San Francisco across 14 different years
- DISTINCT ReleaseYear counts each year only once, regardless of how many films were made that year
- This shows Warner Bros.'s filming activity in SF spans across multiple years/decades
*/

-- File name: count_warner_bros_release_years.sql

-- Follow-up analysis queries:

-- 1. Get the specific years Warner Bros. filmed in San Francisco
SELECT DISTINCT ReleaseYear 
FROM FilmLocations 
WHERE ProductionCompany = "Warner Bros. Pictures" 
ORDER BY ReleaseYear;
/*
This shows exactly which years Warner Bros. was active in San Francisco
*/

-- 2. Count total Warner Bros. film entries (including duplicates)
SELECT COUNT(*) as TotalRecords 
FROM FilmLocations 
WHERE ProductionCompany = "Warner Bros. Pictures";
/*
This shows the total number of location records for Warner Bros. films
*/

-- 3. Warner Bros. films with details
SELECT DISTINCT Title, ReleaseYear, Director, Locations 
FROM FilmLocations 
WHERE ProductionCompany = "Warner Bros. Pictures" 
ORDER BY ReleaseYear, Title;
/*
This lists all Warner Bros. films in the database with their details
*/

-- 4. Warner Bros. filming activity by decade
SELECT 
    FLOOR(ReleaseYear/10)*10 as Decade,
    COUNT(DISTINCT Title) as FilmCount,
    COUNT(*) as LocationRecords
FROM FilmLocations 
WHERE ProductionCompany = "Warner Bros. Pictures" 
GROUP BY FLOOR(ReleaseYear/10)*10 
ORDER BY Decade;
/*
This shows Warner Bros.'s San Francisco filming activity by decade
*/

-- 5. Compare with other major studios
SELECT 
    ProductionCompany,
    COUNT(DISTINCT ReleaseYear) as YearsActive,
    COUNT(DISTINCT Title) as FilmCount,
    MIN(ReleaseYear) as FirstYear,
    MAX(ReleaseYear) as LastYear
FROM FilmLocations 
WHERE ProductionCompany IN (
    'Warner Bros. Pictures',
    'Paramount Pictures',
    'Walt Disney Studios Motion Pictures',
    'Metro-Goldwyn Mayer',
    'Universal Pictures'
) AND ProductionCompany != ''
GROUP BY ProductionCompany 
ORDER BY YearsActive DESC;
/*
This compares Warner Bros. with other major film studios
*/

-- 6. Warner Bros. films per year
SELECT 
    ReleaseYear,
    COUNT(DISTINCT Title) as FilmCount,
    GROUP_CONCAT(DISTINCT Title) as Films
FROM FilmLocations 
WHERE ProductionCompany = "Warner Bros. Pictures" 
GROUP BY ReleaseYear 
ORDER BY ReleaseYear;
/*
This shows how many Warner Bros. films were made each year in SF
*/

-- 7. Most active years for Warner Bros.
SELECT 
    ReleaseYear,
    COUNT(*) as LocationCount
FROM FilmLocations 
WHERE ProductionCompany = "Warner Bros. Pictures" 
GROUP BY ReleaseYear 
ORDER BY LocationCount DESC 
LIMIT 5;
/*
This shows the years when Warner Bros. filmed the most locations in SF
*/

-- 8. Warner Bros. vs. overall industry trend
SELECT 
    'Warner Bros.' as Studio,
    COUNT(DISTINCT ReleaseYear) as YearsActive,
    ROUND(
        COUNT(DISTINCT ReleaseYear) * 100.0 / 
        (SELECT COUNT(DISTINCT ReleaseYear) FROM FilmLocations), 
        2
    ) as PercentageOfAllYears
FROM FilmLocations 
WHERE ProductionCompany = "Warner Bros. Pictures"
UNION ALL
SELECT 
    'All Studios' as Studio,
    (SELECT COUNT(DISTINCT ReleaseYear) FROM FilmLocations) as YearsActive,
    100.00 as Percentage;
/*
This compares Warner Bros.'s years of activity with the total range of years in the database
*/

-- 9. Warner Bros. directors
SELECT 
    Director,
    COUNT(DISTINCT Title) as FilmCount,
    MIN(ReleaseYear) as FirstFilm,
    MAX(ReleaseYear) as LastFilm
FROM FilmLocations 
WHERE ProductionCompany = "Warner Bros. Pictures" 
  AND Director != ''
GROUP BY Director 
ORDER BY FilmCount DESC;
/*
This shows which directors worked with Warner Bros. in San Francisco
*/

-- 10. Warner Bros. location analysis
SELECT 
    Locations,
    COUNT(*) as TimesUsed
FROM FilmLocations 
WHERE ProductionCompany = "Warner Bros. Pictures" 
  AND Locations != ''
GROUP BY Locations 
ORDER BY TimesUsed DESC 
LIMIT 10;
/*
This shows the most popular San Francisco locations used by Warner Bros.
*/

-- 11. Historical timeline of Warner Bros. in SF
SELECT 
    ReleaseYear,
    GROUP_CONCAT(DISTINCT Title ORDER BY Title) as Films
FROM FilmLocations 
WHERE ProductionCompany = "Warner Bros. Pictures" 
GROUP BY ReleaseYear 
ORDER BY ReleaseYear;
/*
This creates a timeline of Warner Bros.'s San Francisco filming history
*/