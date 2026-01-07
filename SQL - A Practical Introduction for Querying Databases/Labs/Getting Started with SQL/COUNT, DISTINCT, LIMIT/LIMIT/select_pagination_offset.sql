-- Practice SQL
-- Database: SanFranciscoFilmLocations

-- Query: Get records 11-25 from FilmLocations table (pagination example)
SELECT * FROM FilmLocations LIMIT 15 OFFSET 10;

/*
Expected Output (rows 11-25):
+------------------------------+-------------+---------------------------------------------------+------------------------------------------------------------------------------------------------------+---------------------------------------------------+-----------------------------+------------------------+----------------------------------------------------+----------------+------------------+----------------+
| Title                        | ReleaseYear | Locations                                         | FunFacts                                                                                             | ProductionCompany                                 | Distributor                 | Director               | Writer                                             | Actor1         | Actor2           | Actor3         |
+------------------------------+-------------+---------------------------------------------------+------------------------------------------------------------------------------------------------------+---------------------------------------------------+-----------------------------+------------------------+----------------------------------------------------+----------------+------------------+----------------+
| A Night Full of Rain         | 1978        | Fairmont Hotel (950 Mason Street, Nob Hill)       | In 1945 the Fairmont hosted the United Nations Conference on International Organization as delegates arrived to draft a charter for the organization. The U.S. Secretary of State, Edward Stettinius drafted the charter in the hotel's Garden Room. | Liberty Film | Warner Bros. Pictures | Lina Wertmuller | Lina Wertmuller                                  | Candice Bergen | Giancarlo Gianni |                |
| A Night Full of Rain         | 1978        | San Francisco Chronicle (901 Mission Street at 15th Street) | The San Francisco Zodiac Killer of the late 1960s sent his notes and letters to the Chronicle's offices. | Liberty Film                                      | Warner Bros. Pictures       | Lina Wertmuller        | Lina Wertmuller                                     | Candice Bergen | Giancarlo Gianni |                |
| A Night Full of Rain         | 1978        | Broadway (North Beach)                            |                                                                                                      | Liberty Film                                      | Warner Bros. Pictures       | Lina Wertmuller        | Lina Wertmuller                                     | Candice Bergen | Giancarlo Gianni |                |
| About a Boy                  | 2014        | Broderick from Fulton to McAlister                |                                                                                                      | NBC Studios                                       | National Broadcasting Company | Mark J. Kunerth        | Jason Katims                                        | David Walton   | Minnie Driver    |                |
| About a Boy                  | 2014        | Crissy Field                                      |                                                                                                      | NBC Studios                                       | National Broadcasting Company | Mark J. Kunerth        | Jason Katims                                        | David Walton   | Minnie Driver    |                |
| About a Boy                  | 2014        | Powell from Bush and Sutter                       |                                                                                                      | NBC Studios                                       | National Broadcasting Company | Mark J. Kunerth        | Jason Katims                                        | David Walton   | Minnie Driver    |                |
| Age of Adaline               | 2015        | Pier 50- end of the pier                          |                                                                                                      | Lionsgate / Sidney Kimmel Entertainment / Lakeshore Entertainment |                         | Lee Toland Krieger      | J. Mills Goodloe                                     | Blake Lively   | Harrison Ford    | Ellen Burstyn  |
| Age of Adaline               | 2015        | California @ Montgomery                           |                                                                                                      | Lionsgate / Sidney Kimmel Entertainment / Lakeshore Entertainment |                         | Lee Toland Krieger      | J. Mills Goodloe                                     | Blake Lively   | Harrison Ford    | Ellen Burstyn  |
| Age of Adaline               | 2015        | Montgomery/Green                                  |                                                                                                      | Lionsgate / Sidney Kimmel Entertainment / Lakeshore Entertainment |                         | Lee Toland Krieger      | J. Mills Goodloe                                     | Blake Lively   | Harrison Ford    | Ellen Burstyn  |
| Age of Adaline               | 2015        | Driving various SF Streets                        |                                                                                                      | Lionsgate / Sidney Kimmel Entertainment / Lakeshore Entertainment |                         | Lee Toland Krieger      | J. Mills Goodloe                                     | Blake Lively   | Harrison Ford    | Ellen Burstyn  |
| Age of Adaline               | 2015        | Plate Shots SF streets various                    |                                                                                                      | Lionsgate / Sidney Kimmel Entertainment / Lakeshore Entertainment |                         | Lee Toland Krieger      | J. Mills Goodloe                                     | Blake Lively   | Harrison Ford    | Ellen Burstyn  |
| After the Thin Man           | 1936        | Coit Tower                                        | The Tower was funded by a gift bequeathed by Lillie Hitchcock Coit, a socialite who reportedly liked to chase fires. Though the tower resembles a firehose nozzle, it was not designed this way. | Metro-Goldwyn Mayer                               | Metro-Goldwyn Mayer          | W.S. Van Dyke          | Frances Goodrich                                     | William Powell | Myrna Loy        | James Stewart  |
| Ant-Man                      | 2015        | California between Kearney and Davis              | Driving shots                                                                                        | PYM Particles Productions, LLC                    | Walt Disney Studios Motion Pictures | Peyton Reed            | Gabriel Ferrari                                     | Michael Douglas | Paul Rudd        |                |
| Americana                    | 2015        | St. Francis Episcopal Church (399 San Fernando Way) |                                                                                                      | Sutro Films LLC                                   |                             | Zachary Shedd          | Zachary Shedd                                        | Kelli Garner   | Jack Davenport   | Peter Coyote   |
| Americana                    | 2015        | Romolo Place @ Fresno St.                         |                                                                                                      | Sutro Films LLC                                   |                             | Zachary Shedd          | Zachary Shedd                                        | Kelli Garner   | Jack Davenport   | Peter Coyote   |
+------------------------------+-------------+---------------------------------------------------+------------------------------------------------------------------------------------------------------+---------------------------------------------------+-----------------------------+------------------------+----------------------------------------------------+----------------+------------------+----------------+

Pagination Details:
- LIMIT 15: Returns maximum 15 records
- OFFSET 10: Skips the first 10 records
- This returns records 11 through 25 (15 records total)
- Useful for implementing pagination in applications

Observations from this page:
1. Continuation of "A Night Full of Rain" (1978) locations
2. "About a Boy" (2014) with 3 location entries
3. "Age of Adaline" (2015) with 5 location entries
4. Historic film "After the Thin Man" (1936) with detailed FunFact about Coit Tower
5. Start of "Ant-Man" (2015) and "Americana" (2015) records
*/

-- File name: select_pagination_offset.sql

-- Advanced pagination and data sampling queries:

-- 1. Pagination formula for page numbers
-- To get page N with page size P: LIMIT P OFFSET (N-1)*P
-- Example: Page 3 with 15 records per page: LIMIT 15 OFFSET 30

-- 2. Dynamic pagination with variables (conceptual)
/*
SET @page_size = 15;
SET @page_number = 2;
SET @offset = (@page_number - 1) * @page_size;
SELECT * FROM FilmLocations LIMIT @page_size OFFSET @offset;
*/

-- 3. Get middle section of data (records 100-124)
SELECT * FROM FilmLocations LIMIT 25 OFFSET 100;

-- 4. Last 15 records in the table
SELECT * FROM FilmLocations ORDER BY rowid DESC LIMIT 15;
-- or using OFFSET with total count
SELECT * FROM FilmLocations LIMIT 15 OFFSET (SELECT COUNT(*) - 15 FROM FilmLocations);

-- 5. Get every 10th record (sampling)
SELECT * FROM FilmLocations WHERE rowid % 10 = 0 LIMIT 15;

-- 6. Pagination with ordering
SELECT * FROM FilmLocations ORDER BY ReleaseYear DESC LIMIT 15 OFFSET 10;

-- 7. Pagination with filtering
SELECT * FROM FilmLocations 
WHERE ReleaseYear >= 2000 
ORDER BY Title 
LIMIT 15 OFFSET 10;

-- 8. Calculate total pages for 15 records per page
SELECT 
    CEIL(COUNT(*) / 15.0) as TotalPages,
    COUNT(*) as TotalRecords
FROM FilmLocations;

-- 9. Pagination with row numbers
SELECT 
    ROW_NUMBER() OVER (ORDER BY Title) as RowNum,
    Title,
    ReleaseYear,
    Locations
FROM FilmLocations 
LIMIT 15 OFFSET 10;

-- 10. Get records with their position in sorted order
SELECT 
    *,
    RANK() OVER (ORDER BY ReleaseYear DESC) as YearRank
FROM FilmLocations 
LIMIT 15 OFFSET 10;

-- 11. Pagination for specific film's locations
SELECT * FROM FilmLocations 
WHERE Title = 'Age of Adaline' 
LIMIT 5 OFFSET 2;

-- 12. Advanced pagination with window functions
WITH NumberedRows AS (
    SELECT 
        *,
        ROW_NUMBER() OVER (ORDER BY ReleaseYear, Title) as RowNumber
    FROM FilmLocations
)
SELECT * FROM NumberedRows 
WHERE RowNumber BETWEEN 11 AND 25;

-- 13. Pagination performance optimization (using indexes)
-- Assuming there's an index on the ordering column
SELECT * FROM FilmLocations 
ORDER BY ReleaseYear 
LIMIT 15 OFFSET 10;

-- 14. Pagination with distinct films only
SELECT DISTINCT Title, ReleaseYear, Director 
FROM FilmLocations 
ORDER BY Title 
LIMIT 15 OFFSET 10;

-- 15. Pagination helper: Get page ranges
SELECT 
    @page := 2 as PageNumber,
    @size := 15 as PageSize,
    (@page - 1) * @size + 1 as StartRecord,
    @page * @size as EndRecord;