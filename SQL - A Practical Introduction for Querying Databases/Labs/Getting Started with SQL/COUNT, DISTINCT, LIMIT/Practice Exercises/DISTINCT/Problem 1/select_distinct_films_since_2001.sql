-- Practice SQL
-- Database: SanFranciscoFilmLocations

-- Query: Get distinct films released in 2001 or later
SELECT DISTINCT Title, ReleaseYear FROM FilmLocations WHERE ReleaseYear >= 2001;

/*
Expected Output Structure (first 50 rows shown):
+----------------------------------------+-------------+
| Title                                  | ReleaseYear |
+----------------------------------------+-------------+
| 180                                    | 2011        |
| 24 Hours on Craigslist                | 2005        |
| About a Boy                           | 2014        |
| Age of Adaline                        | 2015        |
| Ant-Man                               | 2015        |
| Americana                             | 2015        |
| Blue Jasmine                          | 2013        |
| Bee Season                            | 2005        |
| Big Eyes                              | 2014        |
| Big Sur                               | 2013        |
| Summertime                            | 2015        |
| Broken-A Modern Love Story            | 2010        |
| Cardinal X                            | 2015        |
| Confessions of a Burning Man          | 2003        |
| Dawn of the Planet of the Apes        | 2014        |
| Dopamine                              | 2003        |
| Dr. Dolittle 2                        | 2001        |
| Fandom                                | 2004        |
| 40 Days and 40 Nights                 | 2002        |
| God is a Communist?* (show me heart universe) | 2010 |
| Godzilla                              | 2014        |
| I Am Michael                          | 2015        |
| Haiku Tunnel                          | 2001        |
| Just Like Heaven                      | 2005        |
| Hereafter                             | 2010        |
| High Crimes                           | 2002        |
| House of Sand and Fog                 | 2003        |
| Hulk                                  | 2003        |
| I's                                   | 2011        |
| Steve Jobs                            | 2015        |
| Julie and Jack                        | 2003        |
| Looking                               | 2014        |
| Milk                                  | 2008        |
| Need For Speed                        | 2014        |
| Night of Henna                        | 2005        |
| On the Road                           | 2012        |
| Parks and Recreation                  | 2014        |
| Quitters                              | 2015        |
| Red Diaper Baby                       | 2004        |
| Red Widow                             | 2013        |
| Rent                                  | 2005        |
| Rollerball                            | 2002        |
| San Andreas                           | 2015        |
| Sense8                                | 2015        |
| Serendipity                           | 2001        |
| Smile Again, Jenny Lee                | 2015        |
| Sweet November                        | 2001        |
| Swing                                 | 2003        |
| Terminator - Genisys                  | 2015        |
| The Assassination of Richard Nixon    | 2004        |
+----------------------------------------+-------------+
(124 total distinct films released 2001+, 74 films hidden in truncated output)

Interpretation:
- There are 124 distinct films released in 2001 or later in the database
- DISTINCT eliminates duplicates that occur when films have multiple locations
- 2015 appears to be a particularly active year (multiple films from that year shown)
- The 21st century films represent modern San Francisco filmmaking
*/

-- File name: select_distinct_films_since_2001.sql

-- Follow-up analysis queries:

-- 1. Count total distinct films since 2001
SELECT COUNT(DISTINCT Title) as FilmsSince2001 
FROM FilmLocations 
WHERE ReleaseYear >= 2001;
/*
Expected: 124 films (50 shown + 74 hidden)
*/

-- 2. Compare with pre-2001 films
SELECT 
    '2001-Present' as Period,
    COUNT(DISTINCT Title) as FilmCount
FROM FilmLocations 
WHERE ReleaseYear >= 2001
UNION ALL
SELECT 
    'Pre-2001' as Period,
    COUNT(DISTINCT Title) as FilmCount
FROM FilmLocations 
WHERE ReleaseYear < 2001;
/*
This shows the distribution between 21st century and older films
Total films: 316
2001+: 124 films
Pre-2001: 192 films (316 - 124)
*/

-- 3. Films by year since 2001
SELECT 
    ReleaseYear,
    COUNT(DISTINCT Title) as FilmCount,
    GROUP_CONCAT(DISTINCT Title ORDER BY Title) as Films
FROM FilmLocations 
WHERE ReleaseYear >= 2001 
GROUP BY ReleaseYear 
ORDER BY ReleaseYear DESC;
/*
This shows filming activity year by year in the 21st century
*/

-- 4. Most active years since 2001
SELECT 
    ReleaseYear,
    COUNT(DISTINCT Title) as FilmCount
FROM FilmLocations 
WHERE ReleaseYear >= 2001 
GROUP BY ReleaseYear 
ORDER BY FilmCount DESC 
LIMIT 5;
/*
This shows which years had the most filming activity since 2001
*/

-- 5. Films with release year range
SELECT 
    MIN(ReleaseYear) as First21stCenturyFilmYear,
    MAX(ReleaseYear) as LatestFilmYear,
    MAX(ReleaseYear) - MIN(ReleaseYear) + 1 as YearSpan
FROM FilmLocations 
WHERE ReleaseYear >= 2001;
/*
This shows the range of years covered by 21st century films
*/

-- 6. Get full details for 21st century films
SELECT DISTINCT 
    Title, 
    ReleaseYear, 
    Director,
    ProductionCompany
FROM FilmLocations 
WHERE ReleaseYear >= 2001 
ORDER BY ReleaseYear DESC, Title;
/*
This shows 21st century films with director and production company
*/

-- 7. Films missing from the DISTINCT list
-- Check if any films appear to be missing by comparing with all films
SELECT Title 
FROM (
    SELECT DISTINCT Title FROM FilmLocations WHERE ReleaseYear >= 2001
) as RecentFilms
WHERE Title NOT IN (
    '180', '24 Hours on Craigslist', 'About a Boy', 'Age of Adaline',
    'Ant-Man', 'Americana', 'Blue Jasmine', 'Bee Season', 'Big Eyes',
    'Big Sur', 'Summertime', 'Broken-A Modern Love Story', 'Cardinal X'
    -- Add more titles from the complete list
);
/*
This helps verify the completeness of the DISTINCT query
*/

-- 8. Percentage analysis
SELECT 
    (SELECT COUNT(DISTINCT Title) FROM FilmLocations WHERE ReleaseYear >= 2001) as Films21stCentury,
    (SELECT COUNT(DISTINCT Title) FROM FilmLocations) as TotalFilms,
    ROUND(
        (SELECT COUNT(DISTINCT Title) FROM FilmLocations WHERE ReleaseYear >= 2001) * 100.0 / 
        (SELECT COUNT(DISTINCT Title) FROM FilmLocations), 
        2
    ) as Percentage;
/*
Calculates that 21st century films represent about 39.24% of all films (124/316)
*/

-- 9. Recent films with locations count
SELECT 
    Title,
    ReleaseYear,
    COUNT(*) as LocationCount
FROM FilmLocations 
WHERE ReleaseYear >= 2001 
GROUP BY Title, ReleaseYear 
ORDER BY ReleaseYear DESC, LocationCount DESC;
/*
This shows recent films with how many San Francisco locations they used
*/

-- 10. Timeline visualization query
SELECT 
    ReleaseYear,
    COUNT(DISTINCT Title) as FilmCount,
    REPEAT('█', COUNT(DISTINCT Title)) as Chart
FROM FilmLocations 
WHERE ReleaseYear >= 2001 
GROUP BY ReleaseYear 
ORDER BY ReleaseYear;
/*
Creates a simple ASCII chart of filming activity by year
*/