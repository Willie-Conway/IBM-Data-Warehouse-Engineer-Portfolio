-- Practice SQL
-- Database: SanFranciscoFilmLocations

-- Query: Select films where the Writer is NOT "James Cameron"
SELECT Title, ProductionCompany, Locations, ReleaseYear 
FROM FilmLocations 
WHERE Writer <> "James Cameron";

/*
Expected Output Structure (first 50 rows shown):
+------------------------------+---------------------------------------------------+---------------------------------------------------+-------------+
| Title                        | ProductionCompany                                 | Locations                                         | ReleaseYear |
+------------------------------+---------------------------------------------------+---------------------------------------------------+-------------+
| 180                          | SPI Cinemas                                       | Epic Roasthouse (399 Embarcadero)                 | 2011        |
| 180                          | SPI Cinemas                                       | Mason & California Streets (Nob Hill)             | 2011        |
| 180                          | SPI Cinemas                                       | Justin Herman Plaza                               | 2011        |
| 180                          | SPI Cinemas                                       | 200 block Market Street                           | 2011        |
| 180                          | SPI Cinemas                                       | City Hall                                         | 2011        |
| 180                          | SPI Cinemas                                       | Polk & Larkin Streets                             | 2011        |
| 180                          | SPI Cinemas                                       | Randall Museum                                    | 2011        |
| 180                          | SPI Cinemas                                       | 555 Market St.                                    | 2011        |
| 24 Hours on Craigslist       | Yerba Buena Productions                           |                                                   | 2005        |
| A Night Full of Rain         | Liberty Film                                      | Embarcadero Freeway                               | 1978        |
| A Night Full of Rain         | Liberty Film                                      | Fairmont Hotel (950 Mason Street, Nob Hill)       | 1978        |
| A Night Full of Rain         | Liberty Film                                      | San Francisco Chronicle (901 Mission Street at 15th Street) | 1978 |
| A Night Full of Rain         | Liberty Film                                      | Broadway (North Beach)                            | 1978        |
| About a Boy                  | NBC Studios                                       | Broderick from Fulton to McAlister                | 2014        |
| About a Boy                  | NBC Studios                                       | Crissy Field                                      | 2014        |
| About a Boy                  | NBC Studios                                       | Powell from Bush and Sutter                       | 2014        |
| Age of Adaline               | Lionsgate / Sidney Kimmel Entertainment / Lakeshore Entertainment | Pier 50- end of the pier                  | 2015        |
| Age of Adaline               | Lionsgate / Sidney Kimmel Entertainment / Lakeshore Entertainment | California @ Montgomery                     | 2015        |
| Age of Adaline               | Lionsgate / Sidney Kimmel Entertainment / Lakeshore Entertainment | Montgomery/Green                            | 2015        |
| Age of Adaline               | Lionsgate / Sidney Kimmel Entertainment / Lakeshore Entertainment | Driving various SF Streets                  | 2015        |
| Age of Adaline               | Lionsgate / Sidney Kimmel Entertainment / Lakeshore Entertainment | Plate Shots SF streets various              | 2015        |
| After the Thin Man           | Metro-Goldwyn Mayer                               | Coit Tower                                        | 1936        |
| Ant-Man                      | PYM Particles Productions, LLC                    | California between Kearney and Davis              | 2015        |
| Americana                    | Sutro Films LLC                                   | St. Francis Episcopal Church (399 San Fernando Way) | 2015    |
| Americana                    | Sutro Films LLC                                   | Romolo Place @ Fresno St.                         | 2015        |
| Americana                    | Sutro Films LLC                                   | Palace of Fine Arts                               | 2015        |
| Americana                    | Sutro Films LLC                                   | John Shelley Drive John McLaren Park              | 2015        |
| Americana                    | Sutro Films LLC                                   | Treasure Island                                   | 2015        |
| Americana                    | Sutro Films LLC                                   | The San Francisco School (300 Gavin St.)          | 2015        |
| Americana                    | Sutro Films LLC                                   | 33 Spruce St                                      | 2015        |
| Americana                    | Sutro Films LLC                                   | Coi Restaurant (373 Broadway)                     | 2015        |
| Americana                    | Sutro Films LLC                                   | Foreign Cinema (2534 Mission)                     | 2015        |
| Americana                    | Sutro Films LLC                                   | Bernal Heights Park                               | 2015        |
| Americana                    | Sutro Films LLC                                   | Jackson St. at Spruce                             | 2015        |
| Americana                    | Sutro Films LLC                                   | 679 Madrid St                                     | 2015        |
| Americana                    | Sutro Films LLC                                   | Roxie Theater (3117 16th St.)                     | 2015        |
| Americana                    | Sutro Films LLC                                   | Variety Preview Room (582 Market St.)             | 2015        |
| Americana                    | Sutro Films LLC                                   | Laguna Honda Hospital; 375 Laguna Honda Blvd.     | 2015        |
| Americana                    | Sutro Films LLC                                   | 3232 Jackson Ave.                                 | 2015        |
| Americana                    | Sutro Films LLC                                   | 20th St and Illinois/Faxon St. and Kenwood/Glenbrook at Mt. Springs | 2015 |
| Another 48 Hours             | Eddie Murphy Productions                          |                                                   | 1990        |
| Ant-Man                      | PYM Particles Productions, LLC                    | Conzelman Rd at McCollough Rd and down Conzelman Rd. | 2015    |
| Ant-Man                      | PYM Particles Productions, LLC                    | Lombard at Hyde                                   | 2015        |
| Ant-Man                      | PYM Particles Productions, LLC                    | 601 Buena Vista Ave West at Java St.              | 2015        |
| Ant-Man                      | PYM Particles Productions, LLC                    | 420 Jones St. at Ellis St.                        | 2015        |
| Ant-Man                      | PYM Particles Productions, LLC                    | Broadway between Powell and Davis                 | 2015        |
| Ant-Man                      | PYM Particles Productions, LLC                    | Columbus between Bay and Washington               | 2015        |
| Ant-Man                      | PYM Particles Productions, LLC                    | Pine between Kearney and Davis                    | 2015        |
| Ant-Man                      | PYM Particles Productions, LLC                    | Market between Stuart and Van Ness                | 2015        |
| Ant-Man                      | PYM Particles Productions, LLC                    | Grant between Bush and Broadway                   | 2015        |
+------------------------------+---------------------------------------------------+---------------------------------------------------+-------------+
(3366 total rows matching the condition, 3316 rows hidden in truncated output)

Notes:
- This query excludes films where Writer = "James Cameron" using WHERE Writer <> "James Cameron"
- 3366 rows match the condition (this suggests 3414 total rows - 3366 = 48 rows with James Cameron as writer)
- The query returns films from various years and production companies
- Some ProductionCompany values are complex strings with multiple companies separated by slashes
- Some locations are empty strings
- The same film title appears multiple times with different locations
*/

-- File name: select_films_not_by_james_cameron.sql

-- Alternative query variations:
-- 1. Films actually written by James Cameron (the excluded ones)
-- SELECT Title, ProductionCompany, Locations, ReleaseYear, Writer 
-- FROM FilmLocations 
-- WHERE Writer = "James Cameron";

-- 2. Films where Writer is not James Cameron AND has a production company
-- SELECT Title, ProductionCompany, Locations, ReleaseYear 
-- FROM FilmLocations 
-- WHERE Writer <> "James Cameron" AND ProductionCompany != '';

-- 3. Count of films by different writers (excluding James Cameron)
-- SELECT Writer, COUNT(*) as FilmCount 
-- FROM FilmLocations 
-- WHERE Writer <> "James Cameron" AND Writer != 'N/A' AND Writer != ''
-- GROUP BY Writer 
-- ORDER BY FilmCount DESC 
-- LIMIT 10;

-- 4. Films not written by James Cameron, ordered by ReleaseYear
-- SELECT Title, ProductionCompany, Locations, ReleaseYear 
-- FROM FilmLocations 
-- WHERE Writer <> "James Cameron" 
-- ORDER BY ReleaseYear DESC;

-- 5. Films with specific writers other than James Cameron
-- SELECT Title, ProductionCompany, Locations, ReleaseYear 
-- FROM FilmLocations 
-- WHERE Writer IN ("Francis Ford Coppola", "George Lucas", "Steven Spielberg");