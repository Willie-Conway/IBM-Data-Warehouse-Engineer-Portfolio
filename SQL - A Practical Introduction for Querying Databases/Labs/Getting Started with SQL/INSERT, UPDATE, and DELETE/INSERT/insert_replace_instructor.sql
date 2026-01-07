-- Practice SQL
-- Database: Instructors

-- Query 1: Insert/Update instructor record (appears to be REPLACE operation)
INSERT INTO Instructor(ins_id, lastname, firstname, city, country)
VALUES(4, 'Saha', 'Sandip', 'Edmonton', 'CA');

-- Query 2: View all instructor records after the operation
SELECT * FROM Instructor;

/*
Final Output after INSERT/REPLACE operation:
+--------+-----------+-----------+-------------+---------+
| ins_id | lastname  | firstname | city        | country |
+--------+-----------+-----------+-------------+---------+
|      1 | Ahuja     | Rav       | Markham     | CA      |
|      2 | Chong     | Raul      | Toronto     | CA      |
|      4 | Saha      | Sandip    | Edmonton    | CA      |  <-- UPDATED
|      5 | Doe       | John      | Dubai       | AE      |
|      7 | Cangiano  | Antonio   | Vancouver   | CA      |
|      8 | Ryan      | Steve     | Barlby      | GB      |
|      9 | Sannareddy| Ramesh    | Hyderabad   | IN      |
+--------+-----------+-----------+-------------+---------+
(7 instructors total)

What happened:
1. The INSERT statement actually performed a REPLACE operation
2. Instructor with ins_id=4 was updated from Dhaka, BD to Edmonton, CA
3. This suggests the database is using INSERT OR REPLACE behavior
4. The number of records remains 7 (no new record added)
5. Sandip Saha's location was changed from Bangladesh to Canada

Previous state (from earlier query):
ins_id=4 | Saha | Sandip | Dhaka | BD

Current state:
ins_id=4 | Saha | Sandip | Edmonton | CA
*/

-- File name: insert_replace_instructor.sql

-- Analysis of what occurred and best practices:

-- 1. Verify the operation was a REPLACE, not a duplicate INSERT
SELECT COUNT(*) as TotalInstructors FROM Instructor;
-- Returns 7 (same as before, confirming REPLACE not INSERT)

-- 2. Check the specific changed record
SELECT * FROM Instructor WHERE ins_id = 4;
/*
Returns: 4, Saha, Sandip, Edmonton, CA
*/

-- 3. View change history (if audit log existed)
-- In a real system, you might have:
/*
SELECT * FROM Instructor_Audit 
WHERE ins_id = 4 
ORDER BY change_date DESC;
-- Would show: Dhaka, BD → Edmonton, CA
*/

-- 4. Better practice: Use explicit UPDATE for modifications
UPDATE Instructor 
SET city = 'Edmonton', country = 'CA'
WHERE ins_id = 4;
-- This is clearer than INSERT for updating existing records

-- 5. To add a new instructor (not update), use a new ID
-- Find next available ID
SELECT MAX(ins_id) + 1 as NextAvailableID FROM Instructor;
-- Returns 10

-- Add new instructor with new ID
INSERT INTO Instructor(ins_id, lastname, firstname, city, country)
VALUES(10, 'Saha', 'Sandip', 'Edmonton', 'CA');

-- 6. Check for potential duplicates by name/location
SELECT * FROM Instructor 
WHERE lastname = 'Saha' 
  AND firstname = 'Sandip';
/*
Returns: Both the updated record (ID 4) and possibly new one (ID 10)
This could create confusion - having two Sandip Sahas
*/

-- 7. Safe insertion with duplicate prevention
INSERT INTO Instructor(ins_id, lastname, firstname, city, country)
SELECT 
    (SELECT MAX(ins_id) + 1 FROM Instructor),
    'Saha',
    'Sandip',
    'Edmonton',
    'CA'
WHERE NOT EXISTS (
    SELECT 1 FROM Instructor 
    WHERE lastname = 'Saha' 
      AND firstname = 'Sandip' 
      AND city = 'Edmonton'
);

-- 8. Geographic analysis after the change
SELECT 
    country,
    COUNT(*) as InstructorCount,
    GROUP_CONCAT(firstname || ' ' || lastname ORDER BY lastname) as Instructors
FROM Instructor
GROUP BY country
ORDER BY InstructorCount DESC;
/*
Now shows:
CA: 4 instructors (Ahuja, Chong, Saha, Cangiano)
Previously CA had 3, BD had 1
Now CA has 4, BD has 0
*/

-- 9. Update all Canadian instructors with proper province
UPDATE Instructor 
SET city = city || ', ON'
WHERE country = 'CA' AND city NOT LIKE '%,%';
-- Adds province abbreviation to Canadian cities

-- 10. Create a backup before major changes (conceptual)
/*
CREATE TABLE Instructor_Backup AS SELECT * FROM Instructor;
-- Or use transaction for rollback capability
BEGIN TRANSACTION;
-- Perform changes
UPDATE Instructor SET city = 'Test' WHERE ins_id = 4;
-- Check results
SELECT * FROM Instructor WHERE ins_id = 4;
-- If good: COMMIT;
-- If bad: ROLLBACK;
*/

-- 11. Instructor distribution by first letter
SELECT 
    UPPER(LEFT(lastname, 1)) as FirstLetter,
    COUNT(*) as Count,
    GROUP_CONCAT(lastname ORDER BY lastname) as LastNames
FROM Instructor
GROUP BY UPPER(LEFT(lastname, 1))
ORDER BY FirstLetter;
/*
Shows alphabetical distribution of instructors
*/

-- 12. Complete instructor directory with formatting
SELECT 
    ins_id as ID,
    lastname || ', ' || firstname as FullName,
    CASE 
        WHEN country = 'CA' THEN city || ', Canada'
        WHEN country = 'AE' THEN city || ', United Arab Emirates'
        WHEN country = 'GB' THEN city || ', United Kingdom'
        WHEN country = 'IN' THEN city || ', India'
        ELSE city || ', ' || country
    END as Location,
    CASE 
        WHEN country = 'CA' THEN 'North America'
        WHEN country = 'US' THEN 'North America'
        WHEN country = 'GB' THEN 'Europe'
        WHEN country = 'IN' THEN 'Asia'
        WHEN country = 'BD' THEN 'Asia'
        WHEN country = 'AE' THEN 'Middle East'
        ELSE 'Other'
    END as Region
FROM Instructor
ORDER BY lastname, firstname;

-- 13. Validate data integrity
SELECT 
    'Total Instructors' as Metric,
    COUNT(*) as Value
FROM Instructor
UNION ALL
SELECT 
    'Unique Countries',
    COUNT(DISTINCT country)
FROM Instructor
UNION ALL
SELECT 
    'Instructors in Canada',
    COUNT(*) 
FROM Instructor 
WHERE country = 'CA'
UNION ALL
SELECT 
    'Duplicate Names',
    COUNT(*) - COUNT(DISTINCT lastname || firstname)
FROM Instructor;

-- 14. Example of proper INSERT for new instructor
-- Assuming we want to add a NEW instructor (not update existing)
INSERT INTO Instructor(ins_id, lastname, firstname, city, country)
VALUES(
    (SELECT COALESCE(MAX(ins_id), 0) + 1 FROM Instructor),
    'Smith',
    'Jane',
    'Calgary',
    'CA'
);

-- 15. Final state verification
SELECT * FROM Instructor ORDER BY ins_id;
/*
Should show clean, properly updated instructor list
With clear understanding of which operations were performed
*/

-- Key Lessons:
-- 1. INSERT with existing primary key may REPLACE (not always error)
-- 2. Use UPDATE for modifying existing records (clearer intent)
-- 3. Use new IDs for adding new records
-- 4. Check for duplicates before inserting
-- 5. Understand your database's conflict resolution behavior
-- 6. Always verify changes after data manipulation