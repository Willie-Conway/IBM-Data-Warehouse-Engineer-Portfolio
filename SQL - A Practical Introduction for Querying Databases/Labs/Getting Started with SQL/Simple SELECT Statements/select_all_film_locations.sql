-- Practice SQL
-- Database: SanFranciscoFilmLocations

-- Query 1: Select all records from FilmLocations table
SELECT * FROM FilmLocations;

-- Expected Results (first 50 rows shown as example):
-- The actual query would return 3414 rows total
/*
Title                  | ReleaseYear | Locations                                    | FunFacts                                                                                           | ProductionCompany                                     | Distributor                 | Director        | Writer                                              | Actor1         | Actor2           | Actor3
----------------------|-------------|----------------------------------------------|----------------------------------------------------------------------------------------------------|------------------------------------------------------|-----------------------------|-----------------|----------------------------------------------------|----------------|------------------|---------------
180                   | 2011        | Epic Roasthouse (399 Embarcadero)             |                                                                                                    | SPI Cinemas                                          |                             | Jayendra         | Umarji Anuradha, Jayendra, Aarthi Sriram, & Suba   | Siddarth       | Nithya Menon     | Priya Anand
180                   | 2011        | Mason & California Streets (Nob Hill)         |                                                                                                    | SPI Cinemas                                          |                             | Jayendra         | Umarji Anuradha, Jayendra, Aarthi Sriram, & Suba   | Siddarth       | Nithya Menon     | Priya Anand
180                   | 2011        | Justin Herman Plaza                           |                                                                                                    | SPI Cinemas                                          |                             | Jayendra         | Umarji Anuradha, Jayendra, Aarthi Sriram, & Suba   | Siddarth       | Nithya Menon     | Priya Anand
180                   | 2011        | 200 block Market Street                       |                                                                                                    | SPI Cinemas                                          |                             | Jayendra         | Umarji Anuradha, Jayendra, Aarthi Sriram, & Suba   | Siddarth       | Nithya Menon     | Priya Anand
180                   | 2011        | City Hall                                     |                                                                                                    | SPI Cinemas                                          |                             | Jayendra         | Umarji Anuradha, Jayendra, Aarthi Sriram, & Suba   | Siddarth       | Nithya Menon     | Priya Anand
180                   | 2011        | Polk & Larkin Streets                         |                                                                                                    | SPI Cinemas                                          |                             | Jayendra         | Umarji Anuradha, Jayendra, Aarthi Sriram, & Suba   | Siddarth       | Nithya Menon     | Priya Anand
180                   | 2011        | Randall Museum                                |                                                                                                    | SPI Cinemas                                          |                             | Jayendra         | Umarji Anuradha, Jayendra, Aarthi Sriram, & Suba   | Siddarth       | Nithya Menon     | Priya Anand
180                   | 2011        | 555 Market St.                                |                                                                                                    | SPI Cinemas                                          |                             | Jayendra         | Umarji Anuradha, Jayendra, Aarthi Sriram, & Suba   | Siddarth       | Nithya Menon     | Priya Anand
24 Hours on Craigslist| 2005        |                                              |                                                                                                    | Yerba Buena Productions                              | Zealot Pictures             | Michael Ferris Gibson | N/A                                               | Craig Newmark  |                  |
A Night Full of Rain  | 1978        | Embarcadero Freeway                           | Embarcadero Freeway, which was featured in the film was demolished in 1989 because of structural damage from the 1989 Loma Prieta Earthquake) | Liberty Film | Warner Bros. Pictures | Lina Wertmuller | Lina Wertmuller                                  | Candice Bergen | Giancarlo Gianni |
... (3414 total rows, 3364 rows truncated in output)
*/

-- Additional practice queries can be added below:
-- Example: SELECT Title, ReleaseYear, Locations FROM FilmLocations WHERE ReleaseYear > 2000 LIMIT 10;
-- Example: SELECT COUNT(*) as TotalFilms FROM FilmLocations;
-- Example: SELECT DISTINCT Director FROM FilmLocations ORDER BY Director;