-- Practice SQL
-- Database: SanFranciscoFilmLocations

-- Query: Get distinct films and their directors filmed at San Francisco City Hall
SELECT DISTINCT Title, Director FROM FilmLocations WHERE Locations = "City Hall";

/*
Expected Output:
+----------------------------------------+----------------------+
| Title                                  | Director             |
+----------------------------------------+----------------------+
| 180                                    | Jayendra             |
| Bedazzled                              | Harold Ramis         |
| Bicentennial Man                       | Chris Columbus       |
| Boys and Girls                         | Robert Iscove        |
| Class Action                           | Michael Apted        |
| Dawn of the Planet of the Apes         | Matt Reeves          |
| Final Analysis                         | Phil Joanou          |
| The Rock                               | Michael Bay          |
| The Wedding Planner                    | Adam Shankman        |
| When We Rise                           | Gus Van Sant         |
| The Right Stuff                        | Philip Kaufman       |
| Jagged Edge                            | Richard Marquand     |
| Invasion of the Body Snatchers         | Philip Kaufman       |
| A View to a Kill                       | John Glen            |
| Tucker: The Man and His Dream          | Francis Ford Coppola |
| Knife Fight                            | Bill Guttentag       |
| Foul Play                              | Colin Higgins        |
| Magnum Force                           | Ted Post             |
| San Francisco                          | W.S. Van Dyke        |
| Milk                                   | Gus Van Sant         |
| The Enforcer                           | James Fargo          |
| Smile Again, Jenny Lee                 | Carlo Caldana        |
+----------------------------------------+----------------------+
(22 distinct films)

Interpretation:
- 22 different films have used San Francisco City Hall as a filming location
- Directors range from legendary filmmakers (Francis Ford Coppola, Gus Van Sant) to contemporary directors
- City Hall has been a popular filming location across multiple decades
- Some directors appear multiple times (Gus Van Sant, Philip Kaufman)
*/

-- File name: select_films_at_city_hall.sql

-- Follow-up analysis queries:

-- 1. Count total films at City Hall
SELECT COUNT(DISTINCT Title) as FilmsAtCityHall 
FROM FilmLocations 
WHERE Locations = "City Hall";
/*
Expected: 22 films
*/

-- 2. Get complete details for City Hall films
SELECT DISTINCT 
    Title, 
    Director, 
    ReleaseYear,
    Writer,
    ProductionCompany
FROM FilmLocations 
WHERE Locations = "City Hall" 
ORDER BY ReleaseYear DESC;
/*
This shows City Hall films with additional details including release year
*/

-- 3. City Hall films by release year
SELECT 
    ReleaseYear,
    COUNT(DISTINCT Title) as FilmCount,
    GROUP_CONCAT(DISTINCT Title ORDER BY Title) as Films
FROM FilmLocations 
WHERE Locations = "City Hall" 
GROUP BY ReleaseYear 
ORDER BY ReleaseYear DESC;
/*
This shows when City Hall was most popular for filming
*/

-- 4. Most frequent directors at City Hall
SELECT 
    Director,
    COUNT(DISTINCT Title) as FilmCount,
    GROUP_CONCAT(DISTINCT Title ORDER BY ReleaseYear) as Films
FROM FilmLocations 
WHERE Locations = "City Hall" 
  AND Director != ''
GROUP BY Director 
ORDER BY FilmCount DESC;
/*
This shows which directors have used City Hall most frequently
Gus Van Sant appears twice (Milk, When We Rise)
Philip Kaufman appears twice (The Right Stuff, Invasion of the Body Snatchers)
*/

-- 5. Compare City Hall with other popular landmarks
SELECT 
    Locations,
    COUNT(DISTINCT Title) as FilmCount
FROM FilmLocations 
WHERE Locations IN (
    'City Hall',
    'Coit Tower',
    'Golden Gate Bridge',
    'Fisherman\'s Wharf',
    'Alcatraz Island'
) AND Locations != ''
GROUP BY Locations 
ORDER BY FilmCount DESC;
/*
This compares City Hall's popularity with other SF landmarks
*/

-- 6. City Hall films by decade
SELECT 
    FLOOR(ReleaseYear/10)*10 as Decade,
    COUNT(DISTINCT Title) as FilmCount,
    GROUP_CONCAT(DISTINCT Title ORDER BY ReleaseYear) as Films
FROM FilmLocations 
WHERE Locations = "City Hall" 
GROUP BY FLOOR(ReleaseYear/10)*10 
ORDER BY Decade;
/*
This shows the historical use of City Hall for filming by decade
*/

-- 7. Films that used City Hall and other locations
SELECT 
    f.Title,
    f.Director,
    f.ReleaseYear,
    COUNT(*) as TotalLocations,
    SUM(CASE WHEN fl.Locations = 'City Hall' THEN 1 ELSE 0 END) as CityHallFlag
FROM FilmLocations f
JOIN FilmLocations fl ON f.Title = fl.Title
WHERE f.Locations = 'City Hall'
GROUP BY f.Title, f.Director, f.ReleaseYear
ORDER BY TotalLocations DESC;
/*
This shows films that used City Hall and how many total locations they used
*/

-- 8. City Hall films with fun facts
SELECT 
    Title,
    Director,
    ReleaseYear,
    FunFacts
FROM FilmLocations 
WHERE Locations = "City Hall" 
  AND FunFacts != ''
ORDER BY ReleaseYear;
/*
This shows if there are any interesting facts about filming at City Hall
*/

-- 9. Percentage of all films that used City Hall
SELECT 
    (SELECT COUNT(DISTINCT Title) FROM FilmLocations WHERE Locations = "City Hall") as CityHallFilms,
    (SELECT COUNT(DISTINCT Title) FROM FilmLocations) as TotalFilms,
    ROUND(
        (SELECT COUNT(DISTINCT Title) FROM FilmLocations WHERE Locations = "City Hall") * 100.0 / 
        (SELECT COUNT(DISTINCT Title) FROM FilmLocations), 
        2
    ) as Percentage;
/*
Calculates that about 6.96% of all films (22/316) used City Hall as a location
*/

-- 10. Notable directors who filmed at City Hall
SELECT 
    Director,
    COUNT(DISTINCT Title) as FilmCount,
    MIN(ReleaseYear) as FirstFilm,
    MAX(ReleaseYear) as LastFilm
FROM FilmLocations 
WHERE Locations = "City Hall" 
  AND Director IN (
    'Francis Ford Coppola',
    'Gus Van Sant',
    'Michael Bay',
    'Harold Ramis',
    'Chris Columbus'
  )
GROUP BY Director 
ORDER BY Director;
/*
Highlights notable directors who have filmed at City Hall
*/

-- 11. Complete timeline of City Hall filming
SELECT 
    Title,
    ReleaseYear,
    Director,
    ProductionCompany
FROM FilmLocations 
WHERE Locations = "City Hall" 
GROUP BY Title, ReleaseYear, Director, ProductionCompany
ORDER BY ReleaseYear;
/*
Creates a complete historical timeline of City Hall filming
*/