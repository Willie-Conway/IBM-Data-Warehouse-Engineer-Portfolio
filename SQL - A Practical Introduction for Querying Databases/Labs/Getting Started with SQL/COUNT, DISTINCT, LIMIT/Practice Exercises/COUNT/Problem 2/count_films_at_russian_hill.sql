-- Practice SQL
-- Database: SanFranciscoFilmLocations

-- Query: Count films filmed at "Russian Hill" location
SELECT Count(Title) FROM FilmLocations WHERE Locations = "Russian Hill";

/*
Expected Output:
+--------------+
| Count(Title) |
+--------------+
|            1 |
+--------------+

Interpretation:
- Only 1 film in the database was filmed at the exact location "Russian Hill"
- This is a specific count of film titles at this exact location
- Note: This might not include films filmed in Russian Hill area but with more specific addresses
*/

-- File name: count_films_at_russian_hill.sql

-- Follow-up analysis queries:

-- 1. Identify which film was shot at Russian Hill
SELECT Title, ReleaseYear, Director, Writer 
FROM FilmLocations 
WHERE Locations = "Russian Hill";

/*
This shows the specific film that used Russian Hill as a filming location
*/

-- 2. Search for films in Russian Hill area with different location descriptions
SELECT Title, Locations, ReleaseYear 
FROM FilmLocations 
WHERE Locations LIKE '%Russian Hill%' 
   OR Locations LIKE '%Russian%Hill%';

/*
This broader search might find more films in the Russian Hill area
with slightly different location descriptions
*/


-- 3. Compare with other popular San Francisco neighborhoods
SELECT 
    'Russian Hill' as Neighborhood,
    COUNT(Title) as FilmCount
FROM FilmLocations 
WHERE Locations = "Russian Hill"
UNION ALL
SELECT 
    'Chinatown' as Neighborhood,
    COUNT(Title) as FilmCount
FROM FilmLocations 
WHERE Locations = "Chinatown"
UNION ALL
SELECT 
    'Fisherman\'s Wharf' as Neighborhood,
    COUNT(Title) as FilmCount
FROM FilmLocations 
WHERE Locations = "Fisherman's Wharf"
UNION ALL
SELECT 
    'North Beach' as Neighborhood,
    COUNT(Title) as FilmCount
FROM FilmLocations 
WHERE Locations = "North Beach";


/*
This compares Russian Hill with other well-known San Francisco neighborhoods
*/

-- 4. Top 10 most filmed locations
SELECT Locations, COUNT(Title) as FilmCount 
FROM FilmLocations 
WHERE Locations != ''
GROUP BY Locations 
ORDER BY FilmCount DESC 
LIMIT 10;

/*
This shows the most popular filming locations overall
Russian Hill with only 1 film would be far down this list
*/

-- 5. Films near Russian Hill (using nearby streets/landmarks)
SELECT Title, Locations, ReleaseYear 
FROM FilmLocations 
WHERE Locations LIKE '%Hyde%' 
   OR Locations LIKE '%Polk%'
   OR Locations LIKE '%Lombard%'
   OR Locations LIKE '%Washington%'
   OR Locations LIKE '%Pacific%'
ORDER BY Title;
/*
This searches for films on streets in or near Russian Hill
*/

-- 6. Analyze films by neighborhood popularity
SELECT 
    CASE 
        WHEN Locations LIKE '%Russian Hill%' THEN 'Russian Hill'
        WHEN Locations LIKE '%Chinatown%' THEN 'Chinatown'
        WHEN Locations LIKE '%Financial District%' THEN 'Financial District'
        WHEN Locations LIKE '%Mission District%' THEN 'Mission District'
        WHEN Locations LIKE '%North Beach%' THEN 'North Beach'
        WHEN Locations LIKE '%Fisherman%Wharf%' THEN 'Fisherman\'s Wharf'
        WHEN Locations LIKE '%Haight%Ashbury%' THEN 'Haight-Ashbury'
        WHEN Locations LIKE '%Marina%' THEN 'Marina District'
        WHEN Locations LIKE '%Castro%' THEN 'Castro District'
        WHEN Locations LIKE '%Sunset%' THEN 'Sunset District'
        ELSE 'Other'
    END as Neighborhood,
    COUNT(*) as FilmCount
FROM FilmLocations 
WHERE Locations != ''
GROUP BY 
    CASE 
        WHEN Locations LIKE '%Russian Hill%' THEN 'Russian Hill'
        WHEN Locations LIKE '%Chinatown%' THEN 'Chinatown'
        WHEN Locations LIKE '%Financial District%' THEN 'Financial District'
        WHEN Locations LIKE '%Mission District%' THEN 'Mission District'
        WHEN Locations LIKE '%North Beach%' THEN 'North Beach'
        WHEN Locations LIKE '%Fisherman%Wharf%' THEN 'Fisherman\'s Wharf'
        WHEN Locations LIKE '%Haight%Ashbury%' THEN 'Haight-Ashbury'
        WHEN Locations LIKE '%Marina%' THEN 'Marina District'
        WHEN Locations LIKE '%Castro%' THEN 'Castro District'
        WHEN Locations LIKE '%Sunset%' THEN 'Sunset District'
        ELSE 'Other'
    END
ORDER BY FilmCount DESC;

/*
This analyzes film counts by San Francisco neighborhood
*/

-- 7. Historical trend of Russian Hill filming
SELECT ReleaseYear, COUNT(*) as FilmCount
FROM FilmLocations 
WHERE Locations = "Russian Hill"
GROUP BY ReleaseYear
ORDER BY ReleaseYear;

/*
Shows when Russian Hill was used for filming (just 1 year in this case)
*/
