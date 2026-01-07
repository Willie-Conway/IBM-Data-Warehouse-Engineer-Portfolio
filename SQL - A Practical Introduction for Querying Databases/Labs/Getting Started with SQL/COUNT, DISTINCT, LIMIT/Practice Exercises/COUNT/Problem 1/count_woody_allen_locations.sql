-- Practice SQL
-- Database: SanFranciscoFilmLocations

-- Query: Count filming locations for films directed by Woody Allen
SELECT COUNT(Locations) FROM FilmLocations WHERE Director = "Woody Allen";

/*
Expected Output:
+------------------+
| COUNT(Locations) |
+------------------+
|               62 |
+------------------+

Interpretation:
- There are 62 filming location records for films directed by Woody Allen
- COUNT(Locations) counts only records where the Locations field is not empty
- This means Woody Allen directed films that were shot in at least 62 different San Francisco locations
- Since films typically have multiple locations, this represents multiple films or multiple locations per film
*/

-- File name: count_woody_allen_locations.sql

-- Follow-up analysis queries:

-- 1. Get all records for Woody Allen films (including those without locations)
SELECT COUNT(*) as TotalRecords 
FROM FilmLocations 
WHERE Director = "Woody Allen";
/*
This shows the total number of Woody Allen film entries regardless of location data
*/

-- 2. List the specific Woody Allen films in the database
SELECT DISTINCT Title, ReleaseYear, Writer 
FROM FilmLocations 
WHERE Director = "Woody Allen" 
ORDER BY ReleaseYear;
/*
This would show which Woody Allen films are represented in the database
*/

-- 3. See Woody Allen films with their locations
SELECT Title, Locations, ReleaseYear 
FROM FilmLocations 
WHERE Director = "Woody Allen" 
  AND Locations != ''
ORDER BY Title, ReleaseYear;
/*
This shows the actual filming locations for Woody Allen's films
*/

-- 4. Count how many unique locations Woody Allen used
SELECT COUNT(DISTINCT Locations) as UniqueLocations 
FROM FilmLocations 
WHERE Director = "Woody Allen" 
  AND Locations != '';
/*
This counts distinct locations (removing duplicates)
*/

-- 5. Compare Woody Allen with other directors
SELECT Director, COUNT(Locations) as LocationCount 
FROM FilmLocations 
WHERE Director != ''
GROUP BY Director 
ORDER BY LocationCount DESC 
LIMIT 10;
/*
This shows top 10 directors by number of filming locations
Woody Allen appears to have 62 locations
*/

-- 6. Get detailed statistics for Woody Allen films
SELECT 
    COUNT(DISTINCT Title) as FilmCount,
    COUNT(Locations) as LocationRecords,
    COUNT(DISTINCT Locations) as UniqueLocations,
    MIN(ReleaseYear) as FirstFilmYear,
    MAX(ReleaseYear) as LastFilmYear
FROM FilmLocations 
WHERE Director = "Woody Allen";
/*
This provides a comprehensive overview of Woody Allen's films in the database
*/

-- 7. Woody Allen's most used locations
SELECT Locations, COUNT(*) as TimesUsed 
FROM FilmLocations 
WHERE Director = "Woody Allen" 
  AND Locations != ''
GROUP BY Locations 
ORDER BY TimesUsed DESC 
LIMIT 10;
/*
This shows which locations Woody Allen used most frequently
*/

-- 8. Percentage of total database
SELECT 
    62 as WoodyAllenLocations,
    (SELECT COUNT(Locations) FROM FilmLocations) as TotalLocations,
    ROUND(62 * 100.0 / (SELECT COUNT(Locations) FROM FilmLocations), 2) as Percentage;
/*
Calculates what percentage of all locations belong to Woody Allen films
Assuming total locations from previous query: 3414
62/3414 ≈ 1.82%
*/