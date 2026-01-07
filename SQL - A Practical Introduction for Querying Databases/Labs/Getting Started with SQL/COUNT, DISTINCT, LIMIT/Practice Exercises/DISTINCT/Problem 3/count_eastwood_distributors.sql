-- Practice SQL
-- Database: SanFranciscoFilmLocations

-- Query: Count distinct distributors for films starring Clint Eastwood as Actor1
SELECT COUNT(DISTINCT Distributor) FROM FilmLocations WHERE Actor1 = "Clint Eastwood";

/*
Expected Output:
+------------------------------+
| COUNT(DISTINCT Distributor) |
+------------------------------+
|                            3 |
+------------------------------+

Interpretation:
- Films starring Clint Eastwood as the primary actor (Actor1) were distributed by 3 different distributors
- This shows that Clint Eastwood's San Francisco films were handled by multiple distribution companies
- DISTINCT ensures each distributor is counted only once, even if they distributed multiple Eastwood films
*/

-- File name: count_eastwood_distributors.sql

-- Follow-up analysis queries:

-- 1. Identify the specific distributors for Clint Eastwood films
SELECT DISTINCT Distributor 
FROM FilmLocations 
WHERE Actor1 = "Clint Eastwood" 
ORDER BY Distributor;
/*
This shows exactly which 3 distributors handled Clint Eastwood's San Francisco films
*/

-- 2. Get all Clint Eastwood films in the database with details
SELECT DISTINCT 
    Title, 
    ReleaseYear, 
    Distributor,
    Director,
    Locations
FROM FilmLocations 
WHERE Actor1 = "Clint Eastwood" 
ORDER BY ReleaseYear;
/*
This shows which specific Clint Eastwood films were shot in San Francisco
*/

-- 3. Count total Clint Eastwood film entries
SELECT COUNT(*) as TotalRecords 
FROM FilmLocations 
WHERE Actor1 = "Clint Eastwood";
/*
This shows how many location records exist for Clint Eastwood films
*/

-- 4. Clint Eastwood films as director vs. actor
SELECT 
    CASE 
        WHEN Director = "Clint Eastwood" THEN 'Director'
        WHEN Actor1 = "Clint Eastwood" THEN 'Lead Actor'
        WHEN Actor2 = "Clint Eastwood" THEN 'Supporting Actor'
        WHEN Actor3 = "Clint Eastwood" THEN 'Third Actor'
    END as Role,
    COUNT(DISTINCT Title) as FilmCount
FROM FilmLocations 
WHERE "Clint Eastwood" IN (Director, Actor1, Actor2, Actor3)
GROUP BY 
    CASE 
        WHEN Director = "Clint Eastwood" THEN 'Director'
        WHEN Actor1 = "Clint Eastwood" THEN 'Lead Actor'
        WHEN Actor2 = "Clint Eastwood" THEN 'Supporting Actor'
        WHEN Actor3 = "Clint Eastwood" THEN 'Third Actor'
    END;
/*
This analyzes Clint Eastwood's different roles in San Francisco films
*/

-- 5. Distributor analysis for Eastwood films
SELECT 
    Distributor,
    COUNT(DISTINCT Title) as FilmCount,
    GROUP_CONCAT(DISTINCT Title ORDER BY ReleaseYear) as Films,
    MIN(ReleaseYear) as FirstFilm,
    MAX(ReleaseYear) as LastFilm
FROM FilmLocations 
WHERE Actor1 = "Clint Eastwood" 
  AND Distributor != ''
GROUP BY Distributor 
ORDER BY FilmCount DESC;
/*
This provides detailed analysis of each distributor's work with Clint Eastwood
*/

-- 6. Compare with other major actors
SELECT 
    Actor1,
    COUNT(DISTINCT Distributor) as DistributorCount,
    COUNT(DISTINCT Title) as FilmCount
FROM FilmLocations 
WHERE Actor1 != ''
GROUP BY Actor1 
HAVING COUNT(DISTINCT Title) >= 2
ORDER BY DistributorCount DESC 
LIMIT 10;
/*
This shows actors who worked with the most distributors
Clint Eastwood with 3 distributors would likely appear in this list
*/

-- 7. Eastwood films by release year with distributors
SELECT 
    ReleaseYear,
    Title,
    Distributor,
    Director,
    Locations
FROM FilmLocations 
WHERE Actor1 = "Clint Eastwood" 
GROUP BY ReleaseYear, Title, Distributor, Director, Locations
ORDER BY ReleaseYear;
/*
This creates a timeline of Clint Eastwood's San Francisco film career
*/

-- 8. Percentage of all distributors represented by Eastwood films
SELECT 
    (SELECT COUNT(DISTINCT Distributor) FROM FilmLocations WHERE Actor1 = "Clint Eastwood") as EastwoodDistributors,
    (SELECT COUNT(DISTINCT Distributor) FROM FilmLocations WHERE Distributor != '') as TotalDistributors,
    ROUND(
        (SELECT COUNT(DISTINCT Distributor) FROM FilmLocations WHERE Actor1 = "Clint Eastwood") * 100.0 / 
        (SELECT COUNT(DISTINCT Distributor) FROM FilmLocations WHERE Distributor != ''), 
        2
    ) as Percentage;
/*
Calculates what percentage of all distributors in the database distributed Clint Eastwood films
*/

-- 9. Most common filming locations for Eastwood films
SELECT 
    Locations,
    COUNT(*) as TimesUsed
FROM FilmLocations 
WHERE Actor1 = "Clint Eastwood" 
  AND Locations != ''
GROUP BY Locations 
ORDER BY TimesUsed DESC;
/*
This shows which San Francisco locations Clint Eastwood filmed at most frequently
*/

-- 10. Eastwood's collaborators
SELECT 
    Director,
    COUNT(DISTINCT Title) as FilmCount
FROM FilmLocations 
WHERE Actor1 = "Clint Eastwood" 
  AND Director != ''
GROUP BY Director 
ORDER BY FilmCount DESC;
/*
This shows which directors worked with Clint Eastwood in San Francisco
*/

-- 11. Complete distributor analysis
SELECT 
    'Clint Eastwood Films' as Category,
    COUNT(DISTINCT Distributor) as UniqueDistributors,
    COUNT(DISTINCT Title) as FilmCount,
    AVG(ReleaseYear) as AvgReleaseYear
FROM FilmLocations 
WHERE Actor1 = "Clint Eastwood"
UNION ALL
SELECT 
    'All Films' as Category,
    COUNT(DISTINCT Distributor) as UniqueDistributors,
    COUNT(DISTINCT Title) as FilmCount,
    AVG(ReleaseYear) as AvgReleaseYear
FROM FilmLocations 
WHERE Distributor != '';
/*
This compares Clint Eastwood's distribution patterns with overall patterns
*/