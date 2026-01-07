-- Practice SQL
-- Database: SanFranciscoFilmLocations

-- Query: Count total number of records in FilmLocations table
SELECT COUNT(*) FROM FilmLocations;

/*
Expected Output:
+----------+
| COUNT(*) |
+----------+
|     3414 |
+----------+

Interpretation:
- The FilmLocations table contains 3,414 total records
- Each record represents a filming location entry for a film
- Since films can have multiple locations, this count is NOT the number of unique films
- This is the total number of location entries in the database
*/

-- File name: count_total_records.sql

-- Alternative counting queries for more detailed analysis:

-- 1. Count unique film titles
SELECT COUNT(DISTINCT Title) as UniqueFilms FROM FilmLocations;
/*
Expected output would show the number of distinct films in the database
This would be less than 3414 since films have multiple locations
*/

-- 2. Count films with locations vs. without locations
SELECT 
    COUNT(CASE WHEN Locations = '' THEN 1 END) as FilmsWithoutLocations,
    COUNT(CASE WHEN Locations != '' THEN 1 END) as FilmsWithLocations
FROM FilmLocations;
/*
This would show how many records have empty location fields vs. filled location fields
*/

-- 3. Count by release year
SELECT ReleaseYear, COUNT(*) as LocationCount 
FROM FilmLocations 
GROUP BY ReleaseYear 
ORDER BY ReleaseYear;
/*
This would show the distribution of filming locations by year
*/

-- 4. Count by specific conditions
SELECT COUNT(*) as RecentFilms 
FROM FilmLocations 
WHERE ReleaseYear >= 2000;
/*
This would count films from the 21st century
*/

-- 5. Count with multiple conditions
SELECT COUNT(*) as SpecificCondition 
FROM FilmLocations 
WHERE ReleaseYear >= 2010 
  AND Locations != '' 
  AND FunFacts != '';
/*
This would count recent films with both locations and fun facts
*/