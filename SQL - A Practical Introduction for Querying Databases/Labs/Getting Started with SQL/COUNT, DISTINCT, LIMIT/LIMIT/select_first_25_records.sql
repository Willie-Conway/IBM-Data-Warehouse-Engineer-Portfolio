-- Practice SQL
-- Database: SanFranciscoFilmLocations

-- Query: Get first 25 records from FilmLocations table
SELECT * FROM FilmLocations LIMIT 25;

/*
Expected Output (first 25 rows):
+------------------------------+-------------+---------------------------------------------------+------------------------------------------------------------------------------------------------------+---------------------------------------------------+-----------------------------+------------------------+----------------------------------------------------+----------------+------------------+----------------+
| Title                        | ReleaseYear | Locations                                         | FunFacts                                                                                             | ProductionCompany                                 | Distributor                 | Director               | Writer                                             | Actor1         | Actor2           | Actor3         |
+------------------------------+-------------+---------------------------------------------------+------------------------------------------------------------------------------------------------------+---------------------------------------------------+-----------------------------+------------------------+----------------------------------------------------+----------------+------------------+----------------+
| 180                          | 2011        | Epic Roasthouse (399 Embarcadero)                 |                                                                                                      | SPI Cinemas                                       |                             | Jayendra               | Umarji Anuradha, Jayendra, Aarthi Sriram, & Suba   | Siddarth       | Nithya Menon     | Priya Anand    |
| 180                          | 2011        | Mason & California Streets (Nob Hill)             |                                                                                                      | SPI Cinemas                                       |                             | Jayendra               | Umarji Anuradha, Jayendra, Aarthi Sriram, & Suba   | Siddarth       | Nithya Menon     | Priya Anand    |
| 180                          | 2011        | Justin Herman Plaza                               |                                                                                                      | SPI Cinemas                                       |                             | Jayendra               | Umarji Anuradha, Jayendra, Aarthi Sriram, & Suba   | Siddarth       | Nithya Menon     | Priya Anand    |
| 180                          | 2011        | 200 block Market Street                           |                                                                                                      | SPI Cinemas                                       |                             | Jayendra               | Umarji Anuradha, Jayendra, Aarthi Sriram, & Suba   | Siddarth       | Nithya Menon     | Priya Anand    |
| 180                          | 2011        | City Hall                                         |                                                                                                      | SPI Cinemas                                       |                             | Jayendra               | Umarji Anuradha, Jayendra, Aarthi Sriram, & Suba   | Siddarth       | Nithya Menon     | Priya Anand    |
| 180                          | 2011        | Polk & Larkin Streets                             |                                                                                                      | SPI Cinemas                                       |                             | Jayendra               | Umarji Anuradha, Jayendra, Aarthi Sriram, & Suba   | Siddarth       | Nithya Menon     | Priya Anand    |
| 180                          | 2011        | Randall Museum                                    |                                                                                                      | SPI Cinemas                                       |                             | Jayendra               | Umarji Anuradha, Jayendra, Aarthi Sriram, & Suba   | Siddarth       | Nithya Menon     | Priya Anand    |
| 180                          | 2011        | 555 Market St.                                    |                                                                                                      | SPI Cinemas                                       |                             | Jayendra               | Umarji Anuradha, Jayendra, Aarthi Sriram, & Suba   | Siddarth       | Nithya Menon     | Priya Anand    |
| 24 Hours on Craigslist       | 2005        |                                                   |                                                                                                      | Yerba Buena Productions                           | Zealot Pictures             | Michael Ferris Gibson  | N/A                                                | Craig Newmark  |                  |                |
| A Night Full of Rain         | 1978        | Embarcadero Freeway                               | Embarcadero Freeway, which was featured in the film was demolished in 1989 because of structural damage from the 1989 Loma Prieta Earthquake) | Liberty Film                                      | Warner Bros. Pictures       | Lina Wertmuller        | Lina Wertmuller                                     | Candice Bergen | Giancarlo Gianni |                |
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

Observations from first 25 rows:
1. Film "180" (2011) has 8 different filming locations in the first 8 rows
2. Some films have detailed FunFacts (A Night Full of Rain, After the Thin Man)
3. Production companies vary from major studios to independent producers
4. Some distributors are missing (empty fields)
5. Multiple films from 2015 appear in this sample
6. Some locations are very specific (street intersections, buildings) while others are general areas
*/

-- File name: select_first_25_records.sql

-- Additional pagination and sampling queries:

-- 1. Get next 25 records (rows 26-50)
SELECT * FROM FilmLocations LIMIT 25 OFFSET 25;

-- 2. Get a random sample of 25 records
SELECT * FROM FilmLocations ORDER BY RANDOM() LIMIT 25;

-- 3. Get first 25 records ordered by ReleaseYear (oldest first)
SELECT * FROM FilmLocations ORDER BY ReleaseYear LIMIT 25;

-- 4. Get first 25 records ordered by ReleaseYear (newest first)
SELECT * FROM FilmLocations ORDER BY ReleaseYear DESC LIMIT 25;

-- 5. Get first 25 records with non-empty locations
SELECT * FROM FilmLocations WHERE Locations != '' LIMIT 25;

-- 6. Get first 25 records with fun facts
SELECT * FROM FilmLocations WHERE FunFacts != '' LIMIT 25;

-- 7. Pagination example: Page 3 (rows 51-75)
SELECT * FROM FilmLocations LIMIT 25 OFFSET 50;

-- 8. First 25 records from a specific year
SELECT * FROM FilmLocations WHERE ReleaseYear = 2015 LIMIT 25;

-- 9. First 25 records with specific columns only
SELECT Title, ReleaseYear, Locations FROM FilmLocations LIMIT 25;

-- 10. Calculate total pages for pagination (25 records per page)
SELECT 
    CEIL(COUNT(*) / 25.0) as TotalPages,
    COUNT(*) as TotalRecords
FROM FilmLocations;

-- 11. Get records with ranking (first 25 with row numbers)
SELECT 
    ROW_NUMBER() OVER (ORDER BY Title) as RowNum,
    Title,
    ReleaseYear,
    Locations
FROM FilmLocations 
LIMIT 25;

-- 12. First 25 films with their location count
SELECT 
    Title,
    ReleaseYear,
    COUNT(*) as LocationCount
FROM FilmLocations 
GROUP BY Title, ReleaseYear
ORDER BY Title
LIMIT 25;