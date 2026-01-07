-- Practice SQL
-- Database: SanFranciscoFilmLocations

-- Query: Count locations for films written by James Cameron
SELECT COUNT(Locations) FROM FilmLocations WHERE Writer = "James Cameron";

/*
Expected Output:
+------------------+
| COUNT(Locations) |
+------------------+
|               48 |
+------------------+

Interpretation:
- There are 48 filming location records where James Cameron is listed as the writer
- COUNT(Locations) counts only non-NULL location values
- If there were any records with Writer="James Cameron" but Locations field was empty,
  those would NOT be counted
*/

-- File name: count_james_cameron_locations.sql

-- Follow-up queries for deeper analysis:

-- 1. Count all records (including empty locations) for James Cameron
SELECT COUNT(*) as TotalRecords 
FROM FilmLocations 
WHERE Writer = "James Cameron";
/*
This would show the total number of James Cameron records regardless of location data
*/

-- 2. See the actual film titles written by James Cameron
SELECT DISTINCT Title, ReleaseYear 
FROM FilmLocations 
WHERE Writer = "James Cameron" 
ORDER BY ReleaseYear;
/*
This would list the specific films James Cameron wrote
*/

-- 3. Count locations with details for James Cameron films
SELECT 
    COUNT(Locations) as LocationsWithData,
    COUNT(CASE WHEN Locations = '' THEN 1 END) as EmptyLocations,
    COUNT(*) as TotalRecords
FROM FilmLocations 
WHERE Writer = "James Cameron";
/*
This provides a breakdown of location data completeness
*/

-- 4. See James Cameron films with their locations
SELECT Title, Locations, ReleaseYear 
FROM FilmLocations 
WHERE Writer = "James Cameron" 
  AND Locations != ''
ORDER BY Title, ReleaseYear;
/*
This shows the actual filming locations for James Cameron's films
*/

-- 5. Compare James Cameron with other top writers
SELECT Writer, COUNT(Locations) as LocationCount 
FROM FilmLocations 
WHERE Writer != '' AND Writer != 'N/A'
GROUP BY Writer 
ORDER BY LocationCount DESC 
LIMIT 10;
/*
This shows the top 10 writers by number of filming locations
*/

-- 6. Calculate percentage of total locations
SELECT 
    (SELECT COUNT(Locations) FROM FilmLocations WHERE Writer = "James Cameron") as CameronLocations,
    COUNT(Locations) as TotalLocations,
    ROUND(
        (SELECT COUNT(Locations) FROM FilmLocations WHERE Writer = "James Cameron") * 100.0 / COUNT(Locations), 
        2
    ) as Percentage
FROM FilmLocations;
/*
This calculates what percentage of all locations belong to James Cameron films
Result: 48/3414 ≈ 1.41%
*/