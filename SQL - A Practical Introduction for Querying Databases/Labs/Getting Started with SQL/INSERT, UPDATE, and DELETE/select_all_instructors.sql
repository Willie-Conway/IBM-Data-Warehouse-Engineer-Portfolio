-- Practice SQL
-- Database: Instructors

-- Query: Select all records from Instructor table
SELECT * FROM Instructor;

/*
Expected Output:
+--------+-----------+-----------+-------------+---------+
| ins_id | lastname  | firstname | city        | country |
+--------+-----------+-----------+-------------+---------+
|      1 | Ahuja     | Rav       | Markham     | CA      |
|      2 | Chong     | Raul      | Toronto     | CA      |
|      4 | Saha      | Sandip    | Dhaka       | BD      |
|      5 | Doe       | John      | Dubai       | AE      |
|      7 | Cangiano  | Antonio   | Vancouver   | CA      |
|      8 | Ryan      | Steve     | Barlby      | GB      |
|      9 | Sannareddy| Ramesh    | Hyderabad   | IN      |
+--------+-----------+-----------+-------------+---------+
(7 instructors total)

Table Schema:
- ins_id: Instructor ID (primary key, appears to have gaps: missing 3, 6)
- lastname: Instructor's last name
- firstname: Instructor's first name  
- city: City where instructor is located
- country: Country code where instructor is located

Observations:
1. 7 instructors total in the database
2. Instructors are located in various countries
3. Country codes: CA (Canada), BD (Bangladesh), AE (United Arab Emirates), GB (UK), IN (India)
4. Multiple instructors from Canada (3 out of 7)
5. ID sequence has gaps (missing 3, 6) - possibly deleted records or reserved IDs
*/

-- File name: select_all_instructors.sql

-- Basic analysis queries for the Instructor table:

-- 1. Count total instructors
SELECT COUNT(*) as TotalInstructors FROM Instructor;

-- 2. Count instructors by country
SELECT 
    country,
    COUNT(*) as InstructorCount,
    GROUP_CONCAT(firstname || ' ' || lastname ORDER BY lastname) as Instructors
FROM Instructor
GROUP BY country
ORDER BY InstructorCount DESC;

-- 3. List all instructors with full names
SELECT 
    ins_id,
    firstname || ' ' || lastname as FullName,
    city,
    country
FROM Instructor
ORDER BY lastname, firstname;

-- 4. Find instructors from specific countries
SELECT * FROM Instructor WHERE country = 'CA';  -- Canada
SELECT * FROM Instructor WHERE country = 'IN';  -- India
SELECT * FROM Instructor WHERE country IN ('CA', 'US', 'GB');  -- Multiple countries

-- 5. Search for instructors by name
SELECT * FROM Instructor WHERE lastname LIKE 'A%';  -- Last names starting with A
SELECT * FROM Instructor WHERE firstname LIKE '%a%';  -- First names containing 'a'

-- 6. Get instructor by ID
SELECT * FROM Instructor WHERE ins_id = 1;  -- Instructor with ID 1

-- 7. Check for missing/sequential IDs
SELECT 
    MIN(ins_id) as MinID,
    MAX(ins_id) as MaxID,
    COUNT(*) as TotalRecords,
    MAX(ins_id) - MIN(ins_id) + 1 as ExpectedSequence,
    (MAX(ins_id) - MIN(ins_id) + 1) - COUNT(*) as MissingIDs
FROM Instructor;

-- 8. List missing instructor IDs
WITH RECURSIVE id_sequence AS (
    SELECT MIN(ins_id) as id FROM Instructor
    UNION ALL
    SELECT id + 1 FROM id_sequence WHERE id < (SELECT MAX(ins_id) FROM Instructor)
)
SELECT s.id as MissingID
FROM id_sequence s
LEFT JOIN Instructor i ON s.id = i.ins_id
WHERE i.ins_id IS NULL;

-- 9. Geographic distribution analysis
SELECT 
    country,
    COUNT(*) as InstructorCount,
    GROUP_CONCAT(DISTINCT city ORDER BY city) as Cities
FROM Instructor
GROUP BY country
ORDER BY InstructorCount DESC;

-- 10. Instructor name patterns
SELECT 
    CASE 
        WHEN LENGTH(lastname) <= 4 THEN 'Short Last Name'
        WHEN LENGTH(lastname) BETWEEN 5 AND 6 THEN 'Medium Last Name'
        ELSE 'Long Last Name'
    END as LastNameLength,
    COUNT(*) as Count
FROM Instructor
GROUP BY 
    CASE 
        WHEN LENGTH(lastname) <= 4 THEN 'Short Last Name'
        WHEN LENGTH(lastname) BETWEEN 5 AND 6 THEN 'Medium Last Name'
        ELSE 'Long Last Name'
    END
ORDER BY Count DESC;

-- 11. Create a complete instructor directory
SELECT 
    ins_id as ID,
    UPPER(lastname) || ', ' || INITCAP(firstname) as Name,
    INITCAP(city) || ', ' || 
    CASE 
        WHEN country = 'CA' THEN 'Canada'
        WHEN country = 'BD' THEN 'Bangladesh'
        WHEN country = 'AE' THEN 'United Arab Emirates'
        WHEN country = 'GB' THEN 'United Kingdom'
        WHEN country = 'IN' THEN 'India'
        ELSE country
    END as Location
FROM Instructor
ORDER BY lastname;

-- 12. Statistical summary
SELECT 
    'Instructors' as Metric,
    COUNT(*) as Value
FROM Instructor
UNION ALL
SELECT 
    'Countries',
    COUNT(DISTINCT country)
FROM Instructor
UNION ALL
SELECT 
    'Cities',
    COUNT(DISTINCT city)
FROM Instructor
UNION ALL
SELECT 
    'Avg Name Length',
    ROUND(AVG(LENGTH(firstname || lastname)), 2)
FROM Instructor;

-- 13. Export format for external use
SELECT 
    ins_id as "Instructor ID",
    lastname as "Last Name",
    firstname as "First Name",
    city as "City",
    CASE 
        WHEN country = 'CA' THEN 'Canada'
        WHEN country = 'BD' THEN 'Bangladesh'
        WHEN country = 'AE' THEN 'UAE'
        WHEN country = 'GB' THEN 'UK'
        WHEN country = 'IN' THEN 'India'
        ELSE country
    END as "Country"
FROM Instructor
ORDER BY country, lastname;

-- 14. Instructor proximity analysis (conceptual - would need coordinates)
-- Assuming we had latitude/longitude data:
/*
SELECT 
    i1.firstname || ' ' || i1.lastname as Instructor1,
    i1.city as City1,
    i2.firstname || ' ' || i2.lastname as Instructor2,
    i2.city as City2,
    CASE 
        WHEN i1.country = i2.country THEN 'Same Country'
        ELSE 'Different Countries'
    END as LocationRelation
FROM Instructor i1
JOIN Instructor i2 ON i1.ins_id < i2.ins_id
ORDER BY i1.country, i2.country;
*/

-- 15. Template for adding new instructor
/*
INSERT INTO Instructor (ins_id, lastname, firstname, city, country)
VALUES (10, 'Smith', 'Jane', 'New York', 'US');
*/

-- 16. Update example
/*
UPDATE Instructor 
SET city = 'Toronto', country = 'CA'
WHERE ins_id = 5;
*/

-- 17. Delete example
/*
DELETE FROM Instructor WHERE ins_id = 9;
*/

-- Note: This is a clean, well-structured instructor table
-- Consider adding additional fields like:
-- email, phone, hire_date, specialization, etc.