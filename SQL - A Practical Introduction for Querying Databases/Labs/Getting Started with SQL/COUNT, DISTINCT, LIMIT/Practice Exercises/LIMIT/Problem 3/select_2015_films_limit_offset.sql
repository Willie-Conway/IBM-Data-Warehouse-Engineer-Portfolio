-- Practice SQL
-- Database: SanFranciscoFilmLocations

-- Query: Get 3 distinct films from 2015, starting from the 6th result
SELECT DISTINCT Title FROM FilmLocations WHERE ReleaseYear = 2015 LIMIT 3 OFFSET 5;

/*
Expected Output:
+-----------------+
| Title           |
+-----------------+
| I Am Michael    |
| Steve Jobs      |
| Quitters        |
+-----------------+
(3 films from 2015, positions 6-8 in the result set)

Interpretation:
- LIMIT 3: Returns maximum 3 records
- OFFSET 5: Skips the first 5 records
- Returns films in positions 6, 7, and 8 from the 2015 film list
- Films appear to be in alphabetical order (based on previous query)
*/

-- File name: select_2015_films_limit_offset.sql

-- Comprehensive pagination and data analysis for 2015 films:

-- 1. Map the complete 2015 film list with positions
WITH Numbered2015Films AS (
    SELECT 
        ROW_NUMBER() OVER (ORDER BY Title) as Position,
        Title
    FROM (
        SELECT DISTINCT Title 
        FROM FilmLocations 
        WHERE ReleaseYear = 2015
    ) AS Unique2015Films
)
SELECT * FROM Numbered2015Films ORDER BY Position;
/*
Shows all 2015 films with their positions for reference
Based on previous query showing 10 films, we know:
1. Age of Adaline
2. Ant-Man
3. Americana
4. Summertime
5. Cardinal X
6. I Am Michael (our OFFSET 5 starts here)
7. Steve Jobs
8. Quitters
9. San Andreas
10. Sense8
*/

-- 2. Verify total 2015 film count
SELECT COUNT(DISTINCT Title) as Total2015Films 
FROM FilmLocations 
WHERE ReleaseYear = 2015;
/*
Shows how many total 2015 films exist for pagination context
*/

-- 3. Dynamic pagination formula
-- For page P with size S: LIMIT S OFFSET (P-1)*S
-- Example: Page 3 with 3 films per page = LIMIT 3 OFFSET 6

-- 4. Get previous page (films 3-5)
SELECT DISTINCT Title 
FROM FilmLocations 
WHERE ReleaseYear = 2015 
LIMIT 3 OFFSET 2;
/*
Returns: Americana, Summertime, Cardinal X
*/

-- 5. Get next page (films 9-11 if they exist)
SELECT DISTINCT Title 
FROM FilmLocations 
WHERE ReleaseYear = 2015 
LIMIT 3 OFFSET 8;
/*
Returns: San Andreas, Sense8, and possibly more if they exist
*/

-- 6. Calculate pagination metadata
SELECT 
    COUNT(DISTINCT Title) as TotalFilms,
    CEIL(COUNT(DISTINCT Title) / 3.0) as TotalPages,
    3 as PageSize,
    3 as CurrentPage,  -- Assuming this is page 3 (OFFSET 5 = page 3 with 3 films per page)
    (3-1)*3 as CurrentOffset
FROM FilmLocations 
WHERE ReleaseYear = 2015;
/*
Provides pagination metadata for a web interface
*/

-- 7. Enhanced pagination with film details
SELECT 
    f.Title,
    f.ReleaseYear,
    f.Director,
    COUNT(fl.Locations) as LocationCount
FROM (
    SELECT DISTINCT Title, ReleaseYear, Director
    FROM FilmLocations 
    WHERE ReleaseYear = 2015
    ORDER BY Title
    LIMIT 3 OFFSET 5
) AS f
JOIN FilmLocations fl ON f.Title = fl.Title
GROUP BY f.Title, f.ReleaseYear, f.Director
ORDER BY f.Title;
/*
Returns the 3 films with additional details and location counts
*/

-- 8. Pagination with window functions
SELECT 
    Position,
    Title,
    ReleaseYear
FROM (
    SELECT 
        ROW_NUMBER() OVER (ORDER BY Title) as Position,
        Title,
        ReleaseYear
    FROM (
        SELECT DISTINCT Title, ReleaseYear
        FROM FilmLocations 
        WHERE ReleaseYear = 2015
    ) AS UniqueFilms
) AS NumberedFilms
WHERE Position BETWEEN 6 AND 8;
/*
Alternative method using window functions
*/

-- 9. Analysis of the 3 returned films
SELECT 
    Title,
    Director,
    ProductionCompany,
    Locations,
    FunFacts
FROM FilmLocations 
WHERE ReleaseYear = 2015 
  AND Title IN ('I Am Michael', 'Steve Jobs', 'Quitters')
ORDER BY Title, Locations;
/*
Shows complete details for the 3 films in our paginated result
*/

-- 10. Compare with other years' pagination
SELECT 
    2015 as Year,
    COUNT(DISTINCT Title) as TotalFilms,
    CEIL(COUNT(DISTINCT Title) / 3.0) as PagesNeeded
FROM FilmLocations 
WHERE ReleaseYear = 2015
UNION ALL
SELECT 
    2014 as Year,
    COUNT(DISTINCT Title) as TotalFilms,
    CEIL(COUNT(DISTINCT Title) / 3.0) as PagesNeeded
FROM FilmLocations 
WHERE ReleaseYear = 2014
UNION ALL
SELECT 
    2013 as Year,
    COUNT(DISTINCT Title) as TotalFilms,
    CEIL(COUNT(DISTINCT Title) / 3.0) as PagesNeeded
FROM FilmLocations 
WHERE ReleaseYear = 2013
ORDER BY Year DESC;
/*
Compares pagination needs across recent years
*/

-- 11. Pagination helper function (conceptual)
/*
CREATE FUNCTION get_films_by_year_page(
    year INT,
    page INT,
    page_size INT
)
RETURNS TABLE (
    Title TEXT,
    ReleaseYear INT,
    Director TEXT,
    LocationCount INT
)
BEGIN
    SET @offset = (page - 1) * page_size;
    
    RETURN QUERY
    WITH FilmData AS (
        SELECT DISTINCT 
            f.Title,
            f.ReleaseYear,
            f.Director
        FROM FilmLocations f
        WHERE f.ReleaseYear = year
        ORDER BY f.Title
        LIMIT page_size OFFSET @offset
    )
    SELECT 
        fd.Title,
        fd.ReleaseYear,
        fd.Director,
        COUNT(fl.Locations) as LocationCount
    FROM FilmData fd
    JOIN FilmLocations fl ON fd.Title = fl.Title
    GROUP BY fd.Title, fd.ReleaseYear, fd.Director
    ORDER BY fd.Title;
END;
*/

-- 12. Sample usage of pagination in application context
-- Web app might use: page=3, page_size=3, year=2015
-- Which translates to: LIMIT 3 OFFSET 6

-- 13. Edge case: What if OFFSET exceeds available records?
SELECT DISTINCT Title 
FROM FilmLocations 
WHERE ReleaseYear = 2015 
LIMIT 3 OFFSET 100;
/*
Returns empty result if OFFSET is beyond available records
*/

-- 14. Pagination with filtering by multiple criteria
SELECT DISTINCT Title 
FROM FilmLocations 
WHERE ReleaseYear = 2015 
  AND Locations LIKE '%Street%'
ORDER BY Title
LIMIT 3 OFFSET 0;
/*
Shows how to combine pagination with additional filters
*/

-- 15. Export paginated data with context
SELECT 
    'Page 3 (films 6-8 of 2015)' as Description,
    GROUP_CONCAT(Title ORDER BY Title) as FilmsOnPage,
    COUNT(*) as FilmCount
FROM (
    SELECT DISTINCT Title 
    FROM FilmLocations 
    WHERE ReleaseYear = 2015 
    ORDER BY Title
    LIMIT 3 OFFSET 5
) AS CurrentPage;