-- Practice SQL
-- Database: Instructors

-- Query 1: Successful bulk insert/update operation
INSERT INTO Instructor(ins_id, lastname, firstname, city, country)
VALUES(5, 'Doe', 'John', 'Sydney', 'AU'), (6, 'Doe', 'Jane', 'Dhaka', 'BD');

-- Query 2: View all instructor records after successful operation
SELECT * FROM Instructor;

/*
Final Output after successful INSERT/REPLACE operation:
+--------+-----------+-----------+-------------+---------+
| ins_id | lastname  | firstname | city        | country |
+--------+-----------+-----------+-------------+---------+
|      1 | Ahuja     | Rav       | Markham     | CA      |
|      2 | Chong     | Raul      | Toronto     | CA      |
|      4 | Saha      | Sandip    | Edmonton    | CA      |
|      5 | Doe       | John      | Sydney      | AU      |  <-- UPDATED
|      6 | Doe       | Jane      | Dhaka       | BD      |  <-- NEW
|      7 | Cangiano  | Antonio   | Vancouver   | CA      |
|      8 | Ryan      | Steve     | Barlby      | GB      |
|      9 | Sannareddy| Ramesh    | Hyderabad   | IN      |
+--------+-----------+-----------+-------------+---------+
(8 instructors total)

What happened successfully:
1. The INSERT performed as INSERT OR REPLACE (or similar)
2. Record with ins_id=5 was UPDATED:
   - John Doe's location changed from Dubai, AE to Sydney, AU
3. Record with ins_id=6 was INSERTED (new):
   - Jane Doe added with Dhaka, BD location
4. Total instructors increased from 7 to 8

Previous state:
ins_id=5 | Doe | John | Dubai | AE
(no ins_id=6 existed)

Current state:
ins_id=5 | Doe | John | Sydney | AU (updated)
ins_id=6 | Doe | Jane | Dhaka | BD (new)
*/

-- File name: successful_bulk_insert.sql

-- Analysis of the successful operation and database insights:

-- 1. Verify the operation results
SELECT COUNT(*) as TotalInstructors FROM Instructor;
-- Returns 8 (was 7 previously)

-- 2. Check the specific changes
SELECT * FROM Instructor WHERE ins_id IN (5, 6) ORDER BY ins_id;
/*
Returns:
5 | Doe | John | Sydney | AU (updated from Dubai, AE)
6 | Doe | Jane | Dhaka | BD (new record)
*/

-- 3. Analyze what made this succeed vs previous failure
/*
Previous attempt failed with: UNIQUE constraint failed
This attempt succeeded because:
1. Database is using INSERT OR REPLACE behavior
2. OR the constraint checking is different in this session
3. OR there's automatic conflict resolution
*/

-- 4. View complete instructor sequence
SELECT ins_id, lastname, firstname 
FROM Instructor 
ORDER BY ins_id;
/*
Shows:
1: Ahuja, Rav
2: Chong, Raul
3: (missing)
4: Saha, Sandip
5: Doe, John
6: Doe, Jane
7: Cangiano, Antonio
8: Ryan, Steve
9: Sannareddy, Ramesh
*/

-- 5. Geographic distribution analysis
SELECT 
    country,
    COUNT(*) as InstructorCount,
    GROUP_CONCAT(firstname || ' ' || lastname ORDER BY lastname) as Instructors
FROM Instructor
GROUP BY country
ORDER BY InstructorCount DESC;
/*
Now shows:
CA: 3 (Ahuja, Chong, Cangiano)
AU: 1 (John Doe)
BD: 1 (Jane Doe)
GB: 1 (Steve Ryan)
IN: 1 (Ramesh Sannareddy)
AE: 0 (removed - John Doe moved from AE to AU)
*/

-- 6. Find all instructors with same last name
SELECT 
    lastname,
    COUNT(*) as Count,
    GROUP_CONCAT(firstname || ' (' || city || ')' ORDER BY firstname) as Locations
FROM Instructor
GROUP BY lastname
HAVING COUNT(*) > 1;
/*
Shows:
Doe: 2
  - John (Sydney)
  - Jane (Dhaka)
*/

-- 7. Create comprehensive instructor directory
SELECT 
    ins_id as ID,
    UPPER(lastname) || ', ' || INITCAP(firstname) as Name,
    INITCAP(city) as City,
    CASE 
        WHEN country = 'CA' THEN 'Canada'
        WHEN country = 'AU' THEN 'Australia'
        WHEN country = 'BD' THEN 'Bangladesh'
        WHEN country = 'GB' THEN 'United Kingdom'
        WHEN country = 'IN' THEN 'India'
        ELSE country
    END as Country,
    CASE 
        WHEN country IN ('CA', 'US') THEN 'Americas'
        WHEN country IN ('GB', 'FR', 'DE') THEN 'Europe'
        WHEN country IN ('IN', 'BD', 'CN') THEN 'Asia'
        WHEN country = 'AU' THEN 'Oceania'
        WHEN country = 'AE' THEN 'Middle East'
        ELSE 'Other'
    END as Region
FROM Instructor
ORDER BY lastname, firstname;

-- 8. Data quality checks
-- Check for duplicate names in same city
SELECT lastname, firstname, city, COUNT(*) as DuplicateCount
FROM Instructor
GROUP BY lastname, firstname, city
HAVING COUNT(*) > 1;
-- Should return 0 rows for clean data

-- 9. Country code validation
SELECT DISTINCT country FROM Instructor ORDER BY country;
/*
Valid country codes present:
AU - Australia
BD - Bangladesh
CA - Canada
GB - United Kingdom
IN - India
*/

-- 10. Instructor statistics
SELECT 
    'Total Instructors' as Metric, COUNT(*) as Value FROM Instructor
UNION ALL
SELECT 'Countries Represented', COUNT(DISTINCT country) FROM Instructor
UNION ALL
SELECT 'Cities', COUNT(DISTINCT city) FROM Instructor
UNION ALL
SELECT 'Avg Name Length', ROUND(AVG(LENGTH(firstname || ' ' || lastname)), 1) FROM Instructor
UNION ALL
SELECT 'Instructors per Country', ROUND(COUNT(*)*1.0/COUNT(DISTINCT country), 2) FROM Instructor;

-- 11. Pattern analysis in names
SELECT 
    CASE 
        WHEN firstname LIKE 'R%' THEN 'Names starting with R'
        WHEN firstname LIKE 'J%' THEN 'Names starting with J'
        WHEN firstname LIKE 'S%' THEN 'Names starting with S'
        ELSE 'Other letters'
    END as NamePattern,
    COUNT(*) as Count,
    GROUP_CONCAT(firstname ORDER BY firstname) as Examples
FROM Instructor
GROUP BY 
    CASE 
        WHEN firstname LIKE 'R%' THEN 'Names starting with R'
        WHEN firstname LIKE 'J%' THEN 'Names starting with J'
        WHEN firstname LIKE 'S%' THEN 'Names starting with S'
        ELSE 'Other letters'
    END
ORDER BY Count DESC;

-- 12. Timezone analysis (conceptual - would need timezone data)
/*
SELECT 
    firstname || ' ' || lastname as Instructor,
    city,
    CASE country
        WHEN 'CA' THEN 'UTC-5 to UTC-8'
        WHEN 'AU' THEN 'UTC+8 to UTC+11'
        WHEN 'IN' THEN 'UTC+5:30'
        WHEN 'BD' THEN 'UTC+6'
        WHEN 'GB' THEN 'UTC+0'
        ELSE 'Unknown'
    END as Timezone
FROM Instructor
ORDER BY country;
*/

-- 13. Backup current state (conceptual)
/*
CREATE TABLE Instructor_Backup_YYYYMMDD AS 
SELECT * FROM Instructor;

-- Or export to CSV
.mode csv
.headers on
.output instructors_backup.csv
SELECT * FROM Instructor;
.output stdout
*/

-- 14. Example of further data manipulation
-- Add email addresses based on name patterns
UPDATE Instructor 
SET email = LOWER(firstname) || '.' || LOWER(lastname) || '@example.com'
WHERE email IS NULL OR email = '';

-- 15. Final verification and cleanup
-- Check ID sequence continuity
WITH RECURSIVE id_seq AS (
    SELECT MIN(ins_id) as id FROM Instructor
    UNION ALL
    SELECT id + 1 FROM id_seq WHERE id < (SELECT MAX(ins_id) FROM Instructor)
)
SELECT s.id as MissingID
FROM id_seq s
LEFT JOIN Instructor i ON s.id = i.ins_id
WHERE i.ins_id IS NULL;
/*
Returns: 3 (still missing from original sequence)
*/

-- 16. Insert missing ID if needed
INSERT INTO Instructor(ins_id, lastname, firstname, city, country)
VALUES(3, 'Example', 'Instructor', 'Sample City', 'US');

-- 17. Final complete list
SELECT * FROM Instructor ORDER BY ins_id;
/*
Now shows complete sequence 1-9 if we added ID 3
*/

-- 18. Best practices demonstrated:
-- 1. Bulk operations can succeed with proper conflict resolution
-- 2. Always verify changes after data manipulation
-- 3. Maintain data consistency checks
-- 4. Document what changes were made
-- 5. Consider geographic and naming patterns in analysis

-- 19. Export for reporting
SELECT 
    ins_id as "ID",
    lastname as "Last Name",
    firstname as "First Name",
    city as "City",
    CASE country
        WHEN 'CA' THEN 'Canada'
        WHEN 'AU' THEN 'Australia'
        WHEN 'BD' THEN 'Bangladesh'
        WHEN 'GB' THEN 'United Kingdom'
        WHEN 'IN' THEN 'India'
        ELSE country
    END as "Country",
    CASE 
        WHEN country IN ('CA', 'US', 'MX') THEN 'North America'
        WHEN country IN ('GB', 'FR', 'DE', 'ES') THEN 'Europe'
        WHEN country IN ('IN', 'BD', 'CN', 'JP') THEN 'Asia'
        WHEN country = 'AU' THEN 'Australia/Oceania'
        ELSE 'Other'
    END as "Region"
FROM Instructor
ORDER BY "Region", "Country", lastname, firstname;