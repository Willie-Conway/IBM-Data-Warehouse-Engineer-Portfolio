-- Practice SQL
-- Database: SanFranciscoFilmLocations

-- Query: Select films released in 2000 or earlier with Title, ReleaseYear, and Locations
SELECT Title, ReleaseYear, Locations 
FROM FilmLocations 
WHERE ReleaseYear <= 2000;

/*
Expected Output Structure (first 50 rows shown):
+------------------------------+-------------+---------------------------------------------------+
| Title                        | ReleaseYear | Locations                                         |
+------------------------------+-------------+---------------------------------------------------+
| A Night Full of Rain         | 1978        | Embarcadero Freeway                               |
| A Night Full of Rain         | 1978        | Fairmont Hotel (950 Mason Street, Nob Hill)       |
| A Night Full of Rain         | 1978        | San Francisco Chronicle (901 Mission Street at 15th Street) |
| A Night Full of Rain         | 1978        | Broadway (North Beach)                            |
| After the Thin Man           | 1936        | Coit Tower                                        |
| Another 48 Hours             | 1990        |                                                   |
| Around the Fire              | 1998        | Ocean Beach                                       |
| Attack of the Killer Tomatoes | 1978       | Hyde Street Cable Car                             |
| Basic Instinct               | 1992        | Yerba Buena Center for the Arts                   |
| Basic Instinct               | 1992        | Transbay Terminal (Mission Street at 1st Street)  |
| Basic Instinct               | 1992        | Tosca Café (242 Columbus Avenue)                  |
| Basic Instinct               | 1992        | Steinhart Aquarium (California Academy of Sciences, Golden Gate Park) |
| Basic Instinct               | 1992        | Raw Hide II (280 Seventh Street)                  |
| Basic Instinct               | 1992        | Pier 7 (The Embarcadero)                          |
| Basic Instinct               | 1992        | Kearney Street (Telegraph Hill)                   |
| Basic Instinct               | 1992        | Hall of Justice (850 Bryant Street)               |
| Basic Instinct               | 1992        | 2930 Vallejo Street                               |
| Basic Instinct               | 1992        | Chinatown                                         |
| Basic Instinct               | 1992        | Gibb Street (Chinatown)                           |
| Basic Instinct               | 1992        | 1158-70 Montgomery Street                         |
| Basic Instinct               | 1992        | 2104 Broadway                                     |
| Bedazzled                    | 2000        | 1155 Filbert Street at Hyde                       |
| Bedazzled                    | 2000        | Washington Square Park (Filbert, between Stockton and Powell) |
| Bedazzled                    | 2000        | Vaillancourt Fountain (Justin Herman Plaza)       |
| Bedazzled                    | 2000        | Montgomery & Market Streets                       |
| Bedazzled                    | 2000        | City Hall                                         |
| Bicentennial Man             | 1999        | City Hall                                         |
| Bicentennial Man             | 1999        | Golden Gate Bridge                                |
| Bicentennial Man             | 1999        | Treasure Island                                   |
| Bicentennial Man             | 1999        | Postcard Row, Alamo Square, Hayes Valley          |
| Bicentennial Man             | 1999        | Grace Cathedral Episcopal Church (1100 California Street) |
| Boys and Girls               | 2000        | 1122 Folsom Street                                |
| Boys and Girls               | 2000        | St. Peter & Paul's Church (666 Filbert Street, Washington Square) |
| Boys and Girls               | 2000        | Golden Gate Bridge                                |
| Boys and Girls               | 2000        | Fisherman's Wharf                                 |
| Boys and Girls               | 2000        | Ferry Building                                    |
| Boys and Girls               | 2000        | Coit Tower                                        |
| Boys and Girls               | 2000        | City Hall                                         |
| Boys and Girls               | 2000        | Lombard Street                                    |
| Boys and Girls               | 2000        | Chinatown                                         |
| Boys and Girls               | 2000        | Aquatic Park (Jefferson Street)                   |
| Boys and Girls               | 2000        | Alcatraz Island                                   |
| Boys and Girls               | 2000        | 628 Cole Street                                   |
| Casualties of War            | 1989        | Mission Dolores Park (Mission District) via J-Church MUNI Train |
| Class Action                 | 1991        | Mission Dolores (3321 16th Street, Mission District) |
| Class Action                 | 1991        | City Hall                                         |
| Class Action                 | 1991        | Bix Restaurant (56 Gold Street)                   |
| Common Threads: Stories From the Quilt | 1989 | The Castro                                    |
| Copycat                      | 1995        | Treasure Island                                   |
| Copycat                      | 1995        | Twin Peaks                                        |
+------------------------------+-------------+---------------------------------------------------+
(1488 total rows matching the condition, 1438 rows hidden in truncated output)

Notes:
- This query filters films released in 2000 or earlier using WHERE ReleaseYear <= 2000
- 1488 rows match the condition (compared to 1926 rows for ReleaseYear >= 2001)
- Oldest film in this sample: "After the Thin Man" from 1936
- Some films from 2000 are included (e.g., "Bedazzled", "Boys and Girls")
- Some locations appear multiple times (e.g., City Hall, Coit Tower, Treasure Island)
- Some films have empty Locations fields
*/

-- File name: select_films_up_to_2000.sql

-- Alternative query variations:
-- 1. Films from 20th century only (1901-2000)
-- SELECT Title, ReleaseYear, Locations FROM FilmLocations WHERE ReleaseYear BETWEEN 1901 AND 2000;

-- 2. Films from specific decades
-- SELECT Title, ReleaseYear, Locations FROM FilmLocations WHERE ReleaseYear BETWEEN 1990 AND 1999 ORDER BY ReleaseYear;

-- 3. Films with no locations from 2000 or earlier
-- SELECT Title, ReleaseYear, Locations FROM FilmLocations WHERE ReleaseYear <= 2000 AND Locations = '';

-- 4. Count of films per decade
-- SELECT 
--   FLOOR(ReleaseYear/10)*10 as Decade,
--   COUNT(*) as FilmCount 
-- FROM FilmLocations 
-- WHERE ReleaseYear <= 2000 
-- GROUP BY FLOOR(ReleaseYear/10)*10 
-- ORDER BY Decade;

-- 5. Oldest films in the database
-- SELECT Title, ReleaseYear, Locations FROM FilmLocations ORDER BY ReleaseYear ASC LIMIT 20;