-- Practice SQL
-- Database: SanFranciscoFilmLocations

-- Query: Select specific columns (Title, Director, Writer) from FilmLocations table
SELECT Title, Director, Writer FROM FilmLocations;

/*
Expected Output Structure (first 50 rows shown):
+------------------------------+-----------------------+----------------------------------------------+
| Title                        | Director              | Writer                                       |
+------------------------------+-----------------------+----------------------------------------------+
| 180                          | Jayendra              | Umarji Anuradha, Jayendra, Aarthi Sriram, & Suba |
| 180                          | Jayendra              | Umarji Anuradha, Jayendra, Aarthi Sriram, & Suba |
| 180                          | Jayendra              | Umarji Anuradha, Jayendra, Aarthi Sriram, & Suba |
| 180                          | Jayendra              | Umarji Anuradha, Jayendra, Aarthi Sriram, & Suba |
| 180                          | Jayendra              | Umarji Anuradha, Jayendra, Aarthi Sriram, & Suba |
| 180                          | Jayendra              | Umarji Anuradha, Jayendra, Aarthi Sriram, & Suba |
| 180                          | Jayendra              | Umarji Anuradha, Jayendra, Aarthi Sriram, & Suba |
| 180                          | Jayendra              | Umarji Anuradha, Jayendra, Aarthi Sriram, & Suba |
| 24 Hours on Craigslist       | Michael Ferris Gibson | N/A                                          |
| A Night Full of Rain         | Lina Wertmuller       | Lina Wertmuller                              |
| A Night Full of Rain         | Lina Wertmuller       | Lina Wertmuller                              |
| A Night Full of Rain         | Lina Wertmuller       | Lina Wertmuller                              |
| A Night Full of Rain         | Lina Wertmuller       | Lina Wertmuller                              |
| About a Boy                  | Mark J. Kunerth       | Jason Katims                                 |
| About a Boy                  | Mark J. Kunerth       | Jason Katims                                 |
| About a Boy                  | Mark J. Kunerth       | Jason Katims                                 |
| Age of Adaline               | Lee Toland Krieger    | J. Mills Goodloe                             |
| Age of Adaline               | Lee Toland Krieger    | J. Mills Goodloe                             |
| Age of Adaline               | Lee Toland Krieger    | J. Mills Goodloe                             |
| Age of Adaline               | Lee Toland Krieger    | J. Mills Goodloe                             |
| Age of Adaline               | Lee Toland Krieger    | J. Mills Goodloe                             |
| After the Thin Man           | W.S. Van Dyke         | Frances Goodrich                             |
| Ant-Man                      | Peyton Reed           | Gabriel Ferrari                              |
| Americana                    | Zachary Shedd         | Zachary Shedd                                |
| Americana                    | Zachary Shedd         | Zachary Shedd                                |
| Americana                    | Zachary Shedd         | Zachary Shedd                                |
| Americana                    | Zachary Shedd         | Zachary Shedd                                |
| Americana                    | Zachary Shedd         | Zachary Shedd                                |
| Americana                    | Zachary Shedd         | Zachary Shedd                                |
| Americana                    | Zachary Shedd         | Zachary Shedd                                |
| Americana                    | Zachary Shedd         | Zachary Shedd                                |
| Americana                    | Zachary Shedd         | Zachary Shedd                                |
| Americana                    | Zachary Shedd         | Zachary Shedd                                |
| Americana                    | Zachary Shedd         | Zachary Shedd                                |
| Americana                    | Zachary Shedd         | Zachary Shedd                                |
| Americana                    | Zachary Shedd         | Zachary Shedd                                |
| Americana                    | Zachary Shedd         | Zachary Shedd                                |
| Americana                    | Zachary Shedd         | Zachary Shedd                                |
| Americana                    | Zachary Shedd         | Zachary Shedd                                |
| Americana                    | Zachary Shedd         | Zachary Shedd                                |
| Another 48 Hours             | Walter Hill           | Walter Hill                                  |
| Ant-Man                      | Peyton Reed           | Gabriel Ferrari                              |
| Ant-Man                      | Peyton Reed           | Gabriel Ferrari                              |
| Ant-Man                      | Peyton Reed           | Gabriel Ferrari                              |
| Ant-Man                      | Peyton Reed           | Gabriel Ferrari                              |
| Ant-Man                      | Peyton Reed           | Gabriel Ferrari                              |
| Ant-Man                      | Peyton Reed           | Gabriel Ferrari                              |
| Ant-Man                      | Peyton Reed           | Gabriel Ferrari                              |
| Ant-Man                      | Peyton Reed           | Gabriel Ferrari                              |
| Ant-Man                      | Peyton Reed           | Gabriel Ferrari                              |
+------------------------------+-----------------------+----------------------------------------------+
(3414 total rows, 3364 rows hidden in truncated output)

Notes:
- This query returns only 3 columns instead of all columns in the table
- Multiple rows may have the same Title, Director, and Writer values
- Some Writers are listed as "N/A" indicating no writer information
- Some Directors also wrote their own films (e.g., Zachary Shedd, Walter Hill)
*/

-- Practice variations of this query:
-- SELECT DISTINCT Title, Director, Writer FROM FilmLocations; -- Get unique combinations
-- SELECT Title, Director, Writer FROM FilmLocations WHERE Writer != 'N/A'; -- Exclude N/A writers
-- SELECT Title, Director, Writer FROM FilmLocations ORDER BY Director, Title; -- Sort results
-- SELECT Title, Director, Writer FROM FilmLocations LIMIT 100; -- Get first 100 rows only