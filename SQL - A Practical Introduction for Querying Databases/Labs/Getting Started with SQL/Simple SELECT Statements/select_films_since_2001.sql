-- Practice SQL
-- Database: SanFranciscoFilmLocations

-- Query: Select films released in 2001 or later with Title, ReleaseYear, and Locations
SELECT Title, ReleaseYear, Locations 
FROM FilmLocations 
WHERE ReleaseYear >= 2001;

/*
Expected Output Structure (first 50 rows shown):
+------------------------------+-------------+---------------------------------------------------+
| Title                        | ReleaseYear | Locations                                         |
+------------------------------+-------------+---------------------------------------------------+
| 180                          | 2011        | Epic Roasthouse (399 Embarcadero)                 |
| 180                          | 2011        | Mason & California Streets (Nob Hill)             |
| 180                          | 2011        | Justin Herman Plaza                               |
| 180                          | 2011        | 200 block Market Street                           |
| 180                          | 2011        | City Hall                                         |
| 180                          | 2011        | Polk & Larkin Streets                             |
| 180                          | 2011        | Randall Museum                                    |
| 180                          | 2011        | 555 Market St.                                    |
| 24 Hours on Craigslist       | 2005        |                                                   |
| About a Boy                  | 2014        | Broderick from Fulton to McAlister                |
| About a Boy                  | 2014        | Crissy Field                                      |
| About a Boy                  | 2014        | Powell from Bush and Sutter                       |
| Age of Adaline               | 2015        | Pier 50- end of the pier                          |
| Age of Adaline               | 2015        | California @ Montgomery                           |
| Age of Adaline               | 2015        | Montgomery/Green                                  |
| Age of Adaline               | 2015        | Driving various SF Streets                        |
| Age of Adaline               | 2015        | Plate Shots SF streets various                    |
| Ant-Man                      | 2015        | California between Kearney and Davis              |
| Americana                    | 2015        | St. Francis Episcopal Church (399 San Fernando Way) |
| Americana                    | 2015        | Romolo Place @ Fresno St.                         |
| Americana                    | 2015        | Palace of Fine Arts                               |
| Americana                    | 2015        | John Shelley Drive John McLaren Park              |
| Americana                    | 2015        | Treasure Island                                   |
| Americana                    | 2015        | The San Francisco School (300 Gavin St.)          |
| Americana                    | 2015        | 33 Spruce St                                      |
| Americana                    | 2015        | Coi Restaurant (373 Broadway)                     |
| Americana                    | 2015        | Foreign Cinema (2534 Mission)                     |
| Americana                    | 2015        | Bernal Heights Park                               |
| Americana                    | 2015        | Jackson St. at Spruce                             |
| Americana                    | 2015        | 679 Madrid St                                     |
| Americana                    | 2015        | Roxie Theater (3117 16th St.)                     |
| Americana                    | 2015        | Variety Preview Room (582 Market St.)             |
| Americana                    | 2015        | Laguna Honda Hospital; 375 Laguna Honda Blvd.     |
| Americana                    | 2015        | 3232 Jackson Ave.                                 |
| Americana                    | 2015        | 20th St and Illinois/Faxon St. and Kenwood/Glenbrook at Mt. Springs |
| Ant-Man                      | 2015        | Conzelman Rd at McCollough Rd and down Conzelman Rd. |
| Ant-Man                      | 2015        | Lombard at Hyde                                   |
| Ant-Man                      | 2015        | 601 Buena Vista Ave West at Java St.              |
| Ant-Man                      | 2015        | 420 Jones St. at Ellis St.                        |
| Ant-Man                      | 2015        | Broadway between Powell and Davis                 |
| Ant-Man                      | 2015        | Columbus between Bay and Washington               |
| Ant-Man                      | 2015        | Pine between Kearney and Davis                    |
| Ant-Man                      | 2015        | Market between Stuart and Van Ness                |
| Ant-Man                      | 2015        | Grant between Bush and Broadway                   |
| Ant-Man                      | 2015        | Intersection of Broadway at Kearney               |
| Ant-Man                      | 2015        | Intersection of California at Polk                |
| Ant-Man                      | 2015        | Treasure Island, Building #1, Ave of the Palms    |
| Blue Jasmine                 | 2013        | 5546 Geary Ave                                    |
| Bee Season                   | 2005        |                                                   |
| Big Eyes                     | 2014        | Nobles Alley                                      |
+------------------------------+-------------+---------------------------------------------------+
(1926 total rows matching the condition, 1876 rows hidden in truncated output)

Notes:
- This query filters films released in 2001 or later using the WHERE clause
- 1926 rows match the condition ReleaseYear >= 2001
- Some Locations fields are empty (e.g., "24 Hours on Craigslist", "Bee Season")
- The same film title appears multiple times with different locations
- 2015 appears to be a well-represented year in the sample
*/

-- Alternative query variations to practice:
-- 1. Films released exactly in 2015
-- SELECT Title, ReleaseYear, Locations FROM FilmLocations WHERE ReleaseYear = 2015;

-- 2. Films released between 2010 and 2015 inclusive
-- SELECT Title, ReleaseYear, Locations FROM FilmLocations WHERE ReleaseYear BETWEEN 2010 AND 2015;

-- 3. Films released in 2001 or later, ordered by ReleaseYear
-- SELECT Title, ReleaseYear, Locations FROM FilmLocations WHERE ReleaseYear >= 2001 ORDER BY ReleaseYear;

-- 4. Count of films per year since 2001
-- SELECT ReleaseYear, COUNT(*) as FilmCount FROM FilmLocations WHERE ReleaseYear >= 2001 GROUP BY ReleaseYear ORDER BY ReleaseYear;

-- 5. Films from 2001 or later with non-empty locations
-- SELECT Title, ReleaseYear, Locations FROM FilmLocations WHERE ReleaseYear >= 2001 AND Locations != '' ORDER BY ReleaseYear DESC;