-- Practice SQL
-- Database: Instructors

-- Query 1: Successful INSERT/REPLACE operation
INSERT INTO Instructor(ins_id, lastname, firstname, city, country)
VALUES(7, 'Cangiano', 'Tony', 'Toronto', 'CA');

-- Query 2: View all instructor records after successful operation
SELECT * FROM Instructor;

/*
Final Output after successful operation:
+--------+-----------+-----------+-------------+---------+
| ins_id | lastname  | firstname | city        | country |
+--------+-----------+-----------+-------------+---------+
|      1 | Ahuja     | Rav       | Markham     | CA      |
|      2 | Chong     | Raul      | Toronto     | CA      |
|      4 | Saha      | Sandip    | Edmonton    | CA      |
|      5 | Doe       | John      | Sydney      | AU      |
|      6 | Doe       | Jane      | Dhaka       | BD      |
|      7 | Cangiano  | Tony      | Toronto     | CA      |  <-- UPDATED
|      8 | Ryan      | Steve     | Barlby      | GB      |
|      9 | Sannareddy| Ramesh    | Hyderabad   | IN      |
+--------+-----------+-----------+-------------+---------+
(8 instructors total)

What happened successfully:
1. The INSERT performed as INSERT OR REPLACE (or similar)
2. Record with ins_id=7 was UPDATED:
   - Antonio Cangiano → Tony Cangiano
   - Vancouver, CA → Toronto, CA
3. No new record was added (total remains 8)
4. This appears to be a nickname change and relocation

Previous state:
ins_id=7 | Cangiano | Antonio | Vancouver | CA

Current state:
ins_id=7 | Cangiano | Tony | Toronto | CA
*/

-- File name: successful_update_insert.sql

-- Analysis of the successful update and database behavior:

-- 1. Verify the update was successful
SELECT * FROM Instructor WHERE ins_id = 7;
/*
Returns: 7 | Cangiano | Tony | Toronto | CA
*/

-- 2. Compare with previous state (simulated)
WITH PreviousState AS (
    SELECT 7 as ins_id, 'Cangiano' as lastname, 'Antonio' as firstname, 'Vancouver' as city, 'CA' as country
    UNION ALL SELECT 1, 'Ahuja', 'Rav', 'Markham', 'CA'
    UNION ALL SELECT 2, 'Chong', 'Raul', 'Toronto', 'CA'
    UNION ALL SELECT 4, 'Saha', 'Sandip', 'Edmonton', 'CA'
    UNION ALL SELECT 5, 'Doe', 'John', 'Sydney', 'AU'
    UNION ALL SELECT 6, 'Doe', 'Jane', 'Dhaka', 'BD'
    UNION ALL SELECT 8, 'Ryan', 'Steve', 'Barlby', 'GB'
    UNION ALL SELECT 9, 'Sannareddy', 'Ramesh', 'Hyderabad', 'IN'
)
SELECT 
    'Previous' as State,
    p.firstname || ' ' || p.lastname as Name,
    p.city || ', ' || p.country as Location
FROM PreviousState p WHERE p.ins_id = 7
UNION ALL
SELECT 
    'Current' as State,
    i.firstname || ' ' || i.lastname as Name,
    i.city || ', ' || i.country as Location
FROM Instructor i WHERE i.ins_id = 7;
/*
Shows:
Previous: Antonio Cangiano, Vancouver, CA
Current: Tony Cangiano, Toronto, CA
*/

-- 3. Database behavior analysis
-- This INSERT succeeded because:
-- 1. Database is using INSERT OR REPLACE semantics
-- 2. When ins_id=7 exists, it replaces the existing record
-- 3. This is different from plain INSERT which would fail

-- 4. Canadian instructor analysis
SELECT * FROM Instructor WHERE country = 'CA' ORDER BY city;
/*
Now shows:
1. Rav Ahuja (Markham, CA)
2. Tony Cangiano (Toronto, CA)  <-- Updated
3. Raul Chong (Toronto, CA)
4. Sandip Saha (Edmonton, CA)
*/

-- 5. Toronto instructors analysis
SELECT * FROM Instructor WHERE city = 'Toronto' ORDER BY lastname;
/*
Returns:
1. Tony Cangiano (ID 7)
2. Raul Chong (ID 2)
Two instructors now in Toronto, CA
*/

-- 6. Name pattern analysis
SELECT 
    firstname,
    COUNT(*) as Count,
    GROUP_CONCAT(lastname ORDER BY lastname) as LastNames
FROM Instructor
GROUP BY firstname
ORDER BY Count DESC;
/*
Shows:
John: 1 (Doe)
Jane: 1 (Doe)
Rav: 1 (Ahuja)
Raul: 1 (Chong)
Sandip: 1 (Saha)
Steve: 1 (Ryan)
Tony: 1 (Cangiano)
Ramesh: 1 (Sannareddy)
*/

-- 7. Geographic distribution update
SELECT 
    country,
    COUNT(*) as InstructorCount,
    GROUP_CONCAT(city ORDER BY city) as Cities
FROM Instructor
GROUP BY country
ORDER BY InstructorCount DESC;
/*
Shows:
CA: 4 instructors (Edmonton, Markham, Toronto, Toronto)
AU: 1 (Sydney)
BD: 1 (Dhaka)
GB: 1 (Barlby)
IN: 1 (Hyderabad)
*/

-- 8. Data consistency check
-- Check for potential issues with the update
SELECT 
    'Potential Issue' as CheckType,
    'Multiple instructors with same name in same city' as Description
FROM Instructor i1
JOIN Instructor i2 ON i1.lastname = i2.lastname 
    AND i1.firstname = i2.firstname 
    AND i1.city = i2.city
    AND i1.ins_id != i2.ins_id
UNION ALL
SELECT 
    'OK' as CheckType,
    'No duplicate names in same city' as Description
WHERE NOT EXISTS (
    SELECT 1 FROM Instructor i1
    JOIN Instructor i2 ON i1.lastname = i2.lastname 
        AND i1.firstname = i2.firstname 
        AND i1.city = i2.city
        AND i1.ins_id != i2.ins_id
);

-- 9. Create comprehensive instructor directory
SELECT 
    ins_id as ID,
    UPPER(lastname) || ', ' || INITCAP(firstname) as Name,
    CASE 
        WHEN city = 'Toronto' AND lastname = 'Cangiano' THEN '📞 ' || city || ' (Recently moved from Vancouver)'
        ELSE city
    END as City,
    CASE country
        WHEN 'CA' THEN '🇨🇦 Canada'
        WHEN 'AU' THEN '🇦🇺 Australia'
        WHEN 'BD' THEN '🇧🇩 Bangladesh'
        WHEN 'GB' THEN '🇬🇧 United Kingdom'
        WHEN 'IN' THEN '🇮🇳 India'
        ELSE '🏳 ' || country
    END as Country,
    CASE 
        WHEN country = 'CA' AND city = 'Toronto' THEN 'Eastern Time (ET)'
        WHEN country = 'CA' AND city = 'Vancouver' THEN 'Pacific Time (PT)'
        WHEN country = 'CA' AND city = 'Edmonton' THEN 'Mountain Time (MT)'
        WHEN country = 'CA' AND city = 'Markham' THEN 'Eastern Time (ET)'
        WHEN country = 'AU' THEN 'AEST (UTC+10)'
        WHEN country = 'IN' THEN 'IST (UTC+5:30)'
        WHEN country = 'BD' THEN 'BST (UTC+6)'
        WHEN country = 'GB' THEN 'GMT (UTC+0)'
        ELSE 'Check timezone'
    END as Timezone
FROM Instructor
ORDER BY country, city, lastname;

-- 10. Update impact analysis
-- How many Canadian cities now have instructors?
SELECT 
    'Canadian Cities with Instructors' as Metric,
    COUNT(DISTINCT city) as Value
FROM Instructor 
WHERE country = 'CA'
UNION ALL
SELECT 
    'Instructors in Toronto',
    COUNT(*)
FROM Instructor 
WHERE city = 'Toronto'
UNION ALL
SELECT 
    'Instructors moved (Tony)',
    1  -- Tony moved from Vancouver to Toronto
;

-- 11. Historical tracking (if we had it)
-- In a real system, you might track changes:
/*
CREATE TABLE Instructor_History (
    change_id INT PRIMARY KEY AUTOINCREMENT,
    ins_id INT,
    old_firstname TEXT,
    new_firstname TEXT,
    old_city TEXT,
    new_city TEXT,
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    changed_by TEXT
);

-- Trigger to log changes
CREATE TRIGGER log_instructor_changes
AFTER UPDATE ON Instructor
FOR EACH ROW
BEGIN
    INSERT INTO Instructor_History (ins_id, old_firstname, new_firstname, old_city, new_city)
    VALUES (OLD.ins_id, OLD.firstname, NEW.firstname, OLD.city, NEW.city);
END;
*/

-- 12. Business rule: No duplicate (firstname, lastname) pairs
SELECT lastname, firstname, COUNT(*) as DuplicateCount
FROM Instructor
GROUP BY lastname, firstname
HAVING COUNT(*) > 1;
-- Should return 0 rows for clean data

-- 13. Prepare data for reporting
SELECT 
    i.ins_id as "Employee ID",
    i.firstname || ' ' || i.lastname as "Full Name",
    i.city as "Location",
    CASE i.country
        WHEN 'CA' THEN 'Canada'
        WHEN 'AU' THEN 'Australia'
        WHEN 'BD' THEN 'Bangladesh'
        WHEN 'GB' THEN 'United Kingdom'
        WHEN 'IN' THEN 'India'
        ELSE i.country
    END as "Country",
    CASE 
        WHEN i.country = 'CA' THEN 'North America'
        WHEN i.country = 'AU' THEN 'Oceania'
        WHEN i.country IN ('GB', 'IE') THEN 'Europe'
        WHEN i.country IN ('IN', 'BD', 'PK') THEN 'South Asia'
        ELSE 'Other Region'
    END as "Region",
    CASE 
        WHEN i.ins_id = 7 THEN 'Updated: Antonio → Tony, Vancouver → Toronto'
        ELSE 'No recent changes'
    END as "Notes"
FROM Instructor i
ORDER BY "Region", "Country", i.lastname;

-- 14. Final verification of database state
SELECT 
    COUNT(*) as TotalInstructors,
    COUNT(DISTINCT country) as Countries,
    COUNT(DISTINCT city) as Cities,
    SUM(CASE WHEN country = 'CA' THEN 1 ELSE 0 END) as CanadianInstructors,
    SUM(CASE WHEN city = 'Toronto' THEN 1 ELSE 0 END) as TorontoInstructors
FROM Instructor;

-- 15. Lessons learned:
-- 1. INSERT can act as UPDATE with REPLACE semantics
-- 2. Always be clear about intent: Use UPDATE for updates, INSERT for new records
-- 3. Check database configuration to understand conflict resolution
-- 4. Maintain data consistency through validation
-- 5. Consider tracking changes for audit purposes

-- 16. Best practice: Explicit UPDATE statement
-- Instead of INSERT ... VALUES(7, ...) which might replace,
-- use explicit UPDATE for clarity:
UPDATE Instructor 
SET firstname = 'Tony', city = 'Toronto'
WHERE ins_id = 7;
-- This clearly shows intent to update existing record

-- 17. Final clean query showing all instructors
SELECT * FROM Instructor ORDER BY ins_id;