-- Practice SQL
-- Database: SanFranciscoFilmLocations

-- Query: Select Locations and FunFacts columns from FilmLocations table
SELECT Locations, FunFacts FROM FilmLocations;

/*
Expected Output Structure (first 50 rows shown):
+---------------------------------------------------+------------------------------------------------------------------------------------------------------+
| Locations                                         | FunFacts                                                                                             |
+---------------------------------------------------+------------------------------------------------------------------------------------------------------+
| Epic Roasthouse (399 Embarcadero)                 |                                                                                                      |
| Mason & California Streets (Nob Hill)             |                                                                                                      |
| Justin Herman Plaza                               |                                                                                                      |
| 200 block Market Street                           |                                                                                                      |
| City Hall                                         |                                                                                                      |
| Polk & Larkin Streets                             |                                                                                                      |
| Randall Museum                                    |                                                                                                      |
| 555 Market St.                                    |                                                                                                      |
|                                                   |                                                                                                      |
| Embarcadero Freeway                               | Embarcadero Freeway, which was featured in the film was demolished in 1989 because of structural damage from the 1989 Loma Prieta Earthquake) |
| Fairmont Hotel (950 Mason Street, Nob Hill)       | In 1945 the Fairmont hosted the United Nations Conference on International Organization as delegates arrived to draft a charter for the organization. The U.S. Secretary of State, Edward Stettinius drafted the charter in the hotel's Garden Room. |
| San Francisco Chronicle (901 Mission Street at 15th Street) | The San Francisco Zodiac Killer of the late 1960s sent his notes and letters to the Chronicle's offices. |
| Broadway (North Beach)                            |                                                                                                      |
| Broderick from Fulton to McAlister                |                                                                                                      |
| Crissy Field                                      |                                                                                                      |
| Powell from Bush and Sutter                       |                                                                                                      |
| Pier 50- end of the pier                          |                                                                                                      |
| California @ Montgomery                           |                                                                                                      |
| Montgomery/Green                                  |                                                                                                      |
| Driving various SF Streets                        |                                                                                                      |
| Plate Shots SF streets various                    |                                                                                                      |
| Coit Tower                                        | The Tower was funded by a gift bequeathed by Lillie Hitchcock Coit, a socialite who reportedly liked to chase fires. Though the tower resembles a firehose nozzle, it was not designed this way. |
| California between Kearney and Davis              | Driving shots                                                                                        |
| St. Francis Episcopal Church (399 San Fernando Way) |                                                                                                      |
| Romolo Place @ Fresno St.                         |                                                                                                      |
| Palace of Fine Arts                               |                                                                                                      |
| John Shelley Drive John McLaren Park              |                                                                                                      |
| Treasure Island                                   |                                                                                                      |
| The San Francisco School (300 Gavin St.)          |                                                                                                      |
| 33 Spruce St                                      |                                                                                                      |
| Coi Restaurant (373 Broadway)                     |                                                                                                      |
| Foreign Cinema (2534 Mission)                     |                                                                                                      |
| Bernal Heights Park                               |                                                                                                      |
| Jackson St. at Spruce                             |                                                                                                      |
| 679 Madrid St                                     |                                                                                                      |
| Roxie Theater (3117 16th St.)                     |                                                                                                      |
| Variety Preview Room (582 Market St.)             |                                                                                                      |
| Laguna Honda Hospital; 375 Laguna Honda Blvd.     |                                                                                                      |
| 3232 Jackson Ave.                                 |                                                                                                      |
| 20th St and Illinois/Faxon St. and Kenwood/Glenbrook at Mt. Springs |                                                                                                      |
| Conzelman Rd at McCollough Rd and down Conzelman Rd. | Aerial shots                                                                                     |
| Lombard at Hyde                                   |                                                                                                      |
| 601 Buena Vista Ave West at Java St.              |                                                                                                      |
| 420 Jones St. at Ellis St.                        |                                                                                                      |
| Broadway between Powell and Davis                 | Driving shots                                                                                        |
| Columbus between Bay and Washington               | Driving shots                                                                                        |
| Pine between Kearney and Davis                    | Driving shots                                                                                        |
| Market between Stuart and Van Ness                | Driving shots                                                                                        |
| Grant between Bush and Broadway                   | Driving shots                                                                                        |
+---------------------------------------------------+------------------------------------------------------------------------------------------------------+
(3414 total rows, 3364 rows hidden in truncated output)

Notes:
- This query returns only the Locations and FunFacts columns
- Many FunFacts fields are empty (blank)
- Some interesting FunFacts include historical information about SF landmarks
- Locations with multiple entries (like Coit Tower, Embarcadero Freeway) have associated FunFacts
- Some FunFacts describe filming techniques (e.g., "Driving shots", "Aerial shots")
*/

-- File name: select_locations_funfacts.sql

-- Practice variations:
-- 1. Only locations with FunFacts
-- SELECT Locations, FunFacts FROM FilmLocations WHERE FunFacts != '';

-- 2. Count how many locations have FunFacts vs. empty
-- SELECT 
--   COUNT(CASE WHEN FunFacts = '' THEN 1 END) as EmptyFunFacts,
--   COUNT(CASE WHEN FunFacts != '' THEN 1 END) as WithFunFacts
-- FROM FilmLocations;

-- 3. Locations with the longest FunFacts
-- SELECT Locations, LENGTH(FunFacts) as FunFactLength, FunFacts 
-- FROM FilmLocations 
-- WHERE FunFacts != '' 
-- ORDER BY LENGTH(FunFacts) DESC 
-- LIMIT 10;