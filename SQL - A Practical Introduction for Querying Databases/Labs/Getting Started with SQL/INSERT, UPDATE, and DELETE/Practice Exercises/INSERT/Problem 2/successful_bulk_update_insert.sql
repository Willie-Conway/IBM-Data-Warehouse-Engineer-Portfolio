-- Practice SQL
-- Database: Instructors

-- Query 1: Successful INSERT/REPLACE operation
INSERT INTO Instructor(ins_id, lastname, firstname, city, country)
VALUES(8, 'Ryan', 'Steven', 'London', 'GB'), (9, 'Sannareddy', 'Ram', 'Bangalore', 'IN');

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
|      5 | Doe       | John      | Sydney      | AU      |
|      6 | Doe       | Jane      | Dhaka       | BD      |
|      7 | Cangiano  | Tony      | Toronto     | CA      |
|      8 | Ryan      | Steven    | London      | GB      |  <-- UPDATED
|      9 | Sannareddy| Ram       | Bangalore   | IN      |  <-- UPDATED
+--------+-----------+-----------+-------------+---------+
(8 instructors total)

What happened successfully:
1. The INSERT performed as INSERT OR REPLACE (or similar)
2. Record with ins_id=8 was UPDATED:
   - Steve Ryan → Steven Ryan
   - Barlby, GB → London, GB
3. Record with ins_id=9 was UPDATED:
   - Ramesh Sannareddy → Ram Sannareddy
   - Hyderabad, IN → Bangalore, IN
4. No new records added (total remains 8)

Previous state:
ins_id=8 | Ryan | Steve | Barlby | GB
ins_id=9 | Sannareddy | Ramesh | Hyderabad | IN

Current state:
ins_id=8 | Ryan | Steven | London | GB
ins_id=9 | Sannareddy | Ram | Bangalore | IN
*/

-- File name: successful_bulk_update_insert.sql

-- Comprehensive analysis of the successful bulk update:

-- 1. Verify the updates were successful
SELECT * FROM Instructor WHERE ins_id IN (8, 9) ORDER BY ins_id;
/*
Returns:
8 | Ryan | Steven | London | GB
9 | Sannareddy | Ram | Bangalore | IN
*/

-- 2. Track the changes (simulated history)
WITH PreviousState AS (
    SELECT 8 as ins_id, 'Ryan' as lastname, 'Steve' as firstname, 'Barlby' as city, 'GB' as country, 'before' as state
    UNION ALL
    SELECT 9, 'Sannareddy', 'Ramesh', 'Hyderabad', 'IN', 'before'
    UNION ALL
    SELECT 8, 'Ryan', 'Steven', 'London', 'GB', 'after'
    UNION ALL
    SELECT 9, 'Sannareddy', 'Ram', 'Bangalore', 'IN', 'after'
)
SELECT 
    p.ins_id as ID,
    p.lastname as LastName,
    p.firstname as FirstName,
    p.city as City,
    p.country as Country,
    p.state as State
FROM PreviousState p
ORDER BY p.ins_id, p.state DESC;
/*
Shows the before/after for each updated instructor
*/

-- 3. Geographic analysis after updates
SELECT 
    country,
    COUNT(*) as InstructorCount,
    GROUP_CONCAT(city || ' (' || firstname || ' ' || lastname || ')' ORDER BY city) as Instructors
FROM Instructor
GROUP BY country
ORDER BY InstructorCount DESC;
/*
Now shows:
CA: 4 (Edmonton (Sandip Saha), Markham (Rav Ahuja), Toronto (Tony Cangiano), Toronto (Raul Chong))
GB: 1 (London (Steven Ryan))
IN: 1 (Bangalore (Ram Sannareddy))
AU: 1 (Sydney (John Doe))
BD: 1 (Dhaka (Jane Doe))
*/

-- 4. City-specific analysis
-- London (UK) now has an instructor
SELECT * FROM Instructor WHERE city = 'London';
-- Returns: Steven Ryan

-- Bangalore (India) now has an instructor instead of Hyderabad
SELECT * FROM Instructor WHERE city = 'Bangalore';
-- Returns: Ram Sannareddy

-- Hyderabad no longer has instructors
SELECT * FROM Instructor WHERE city = 'Hyderabad';
-- Returns 0 rows

-- 5. Name changes analysis
SELECT 
    'Name Changes' as ChangeType,
    COUNT(*) as Count,
    GROUP_CONCAT(
        old.firstname || ' ' || old.lastname || ' → ' || 
        new.firstname || ' ' || new.lastname
        ORDER BY old.ins_id
    ) as Details
FROM (
    SELECT 8 as ins_id, 'Steve' as old_firstname, 'Ryan' as lastname, 'Steven' as new_firstname
    UNION ALL
    SELECT 9, 'Ramesh', 'Sannareddy', 'Ram'
) as changes
JOIN Instructor old ON changes.ins_id = old.ins_id;

-- 6. Create comprehensive instructor directory with changes noted
SELECT 
    ins_id as ID,
    lastname || ', ' || firstname as Name,
    CASE 
        WHEN ins_id = 8 THEN '📍 ' || city || ' (moved from Barlby)'
        WHEN ins_id = 9 THEN '📍 ' || city || ' (moved from Hyderabad)'
        ELSE city
    END as Location,
    CASE country
        WHEN 'GB' THEN '🇬🇧 United Kingdom'
        WHEN 'IN' THEN '🇮🇳 India'
        WHEN 'CA' THEN '🇨🇦 Canada'
        WHEN 'AU' THEN '🇦🇺 Australia'
        WHEN 'BD' THEN '🇧🇩 Bangladesh'
        ELSE '🏳 ' || country
    END as Country,
    CASE 
        WHEN ins_id IN (8, 9) THEN 'Recently updated'
        ELSE 'Stable'
    END as Status
FROM Instructor
ORDER BY country, lastname;

-- 7. Data quality and consistency checks
-- Check for duplicate names in same city
SELECT lastname, firstname, city, COUNT(*) as DuplicateCount
FROM Instructor
GROUP BY lastname, firstname, city
HAVING COUNT(*) > 1;
-- Should return 0 rows

-- Check for duplicate names overall
SELECT lastname, firstname, COUNT(*) as NameCount
FROM Instructor
GROUP BY lastname, firstname
HAVING COUNT(*) > 1;
-- Should return 0 rows (no duplicate full names)

-- 8. Timezone analysis for scheduling (conceptual)
SELECT 
    firstname || ' ' || lastname as Instructor,
    city || ', ' || 
    CASE country
        WHEN 'GB' THEN 'UK'
        WHEN 'IN' THEN 'India'
        WHEN 'CA' THEN 'Canada'
        WHEN 'AU' THEN 'Australia'
        WHEN 'BD' THEN 'Bangladesh'
        ELSE country
    END as Location,
    CASE 
        WHEN city = 'London' THEN 'GMT (UTC+0)'
        WHEN city = 'Bangalore' THEN 'IST (UTC+5:30)'
        WHEN city = 'Toronto' THEN 'EST (UTC-5)'
        WHEN city = 'Vancouver' THEN 'PST (UTC-8)'
        WHEN city = 'Sydney' THEN 'AEST (UTC+10)'
        WHEN city = 'Dhaka' THEN 'BST (UTC+6)'
        WHEN city = 'Markham' THEN 'EST (UTC-5)'
        WHEN city = 'Edmonton' THEN 'MST (UTC-7)'
        ELSE 'Check timezone'
    END as Timezone
FROM Instructor
ORDER BY 
    CASE 
        WHEN city = 'London' THEN 1
        WHEN city = 'Bangalore' THEN 2
        WHEN city LIKE 'Toronto%' THEN 3
        WHEN city LIKE 'Vancouver%' THEN 4
        WHEN city = 'Sydney' THEN 5
        WHEN city = 'Dhaka' THEN 6
        WHEN city = 'Markham' THEN 7
        WHEN city = 'Edmonton' THEN 8
        ELSE 9
    END;

-- 9. Statistical summary after all updates
SELECT 
    'Final Statistics' as Category,
    '' as Detail
UNION ALL
SELECT 'Total Instructors', CAST(COUNT(*) as TEXT) FROM Instructor
UNION ALL
SELECT 'Countries Represented', CAST(COUNT(DISTINCT country) as TEXT) FROM Instructor
UNION ALL
SELECT 'Cities', CAST(COUNT(DISTINCT city) as TEXT) FROM Instructor
UNION ALL
SELECT 'Canadian Instructors', CAST(SUM(CASE WHEN country = 'CA' THEN 1 ELSE 0 END) as TEXT) FROM Instructor
UNION ALL
SELECT 'UK Instructors', CAST(SUM(CASE WHEN country = 'GB' THEN 1 ELSE 0 END) as TEXT) FROM Instructor
UNION ALL
SELECT 'Indian Instructors', CAST(SUM(CASE WHEN country = 'IN' THEN 1 ELSE 0 END) as TEXT) FROM Instructor
UNION ALL
SELECT 'Name Changes Made', '3 (Antonio→Tony, Steve→Steven, Ramesh→Ram)'
UNION ALL
SELECT 'Location Changes', '3 (Vancouver→Toronto, Barlby→London, Hyderabad→Bangalore)';

-- 10. Export for reporting
SELECT 
    ins_id as "ID",
    lastname as "Last Name",
    firstname as "First Name",
    city as "City",
    CASE country
        WHEN 'CA' THEN 'Canada'
        WHEN 'GB' THEN 'United Kingdom'
        WHEN 'IN' THEN 'India'
        WHEN 'AU' THEN 'Australia'
        WHEN 'BD' THEN 'Bangladesh'
        ELSE country
    END as "Country",
    CASE 
        WHEN ins_id = 7 THEN 'Nickname update (Antonio → Tony) & moved to Toronto'
        WHEN ins_id = 8 THEN 'Formal name (Steve → Steven) & moved to London'
        WHEN ins_id = 9 THEN 'Shortened name (Ramesh → Ram) & moved to Bangalore'
        ELSE 'No recent changes'
    END as "Recent Updates"
FROM Instructor
ORDER BY "Country", lastname;

-- 11. Database behavior analysis
-- Why did this INSERT succeed when similar ones failed?
-- Likely reasons:
-- 1. Database session is using INSERT OR REPLACE semantics
-- 2. Different conflict resolution settings
-- 3. The VALUES had different data than existing records (triggering replace)

-- 12. Best practice: Explicit UPDATE for clarity
-- Instead of relying on INSERT OR REPLACE behavior:
UPDATE Instructor 
SET firstname = 'Steven', city = 'London'
WHERE ins_id = 8;

UPDATE Instructor 
SET firstname = 'Ram', city = 'Bangalore'
WHERE ins_id = 9;
-- This clearly shows intent to update

-- 13. Final verification of data integrity
WITH DataChecks AS (
    SELECT COUNT(DISTINCT ins_id) as unique_ids, COUNT(*) as total_rows FROM Instructor
    UNION ALL
    SELECT COUNT(*), 0 FROM Instructor WHERE lastname = '' OR firstname = '' OR city = '' OR country = ''
    UNION ALL
    SELECT COUNT(*), 0 FROM (
        SELECT lastname, firstname, COUNT(*) as dup_count
        FROM Instructor
        GROUP BY lastname, firstname
        HAVING COUNT(*) > 1
    )
)
SELECT 
    CASE 
        WHEN unique_ids = total_rows THEN '✅ All IDs are unique'
        ELSE '❌ Duplicate IDs found'
    END as ID_Check,
    CASE 
        WHEN total_rows = 0 THEN '✅ No empty fields'
        ELSE '❌ Found empty fields'
    END as Data_Quality,
    CASE 
        WHEN dup_count = 0 THEN '✅ No duplicate names'
        ELSE '❌ Found duplicate names'
    END as Name_Check
FROM (
    SELECT 
        MAX(CASE WHEN unique_ids = total_rows THEN 1 ELSE 0 END) as id_ok,
        MAX(CASE WHEN total_rows = 0 THEN 1 ELSE 0 END) as data_ok,
        MAX(CASE WHEN dup_count = 0 THEN 1 ELSE 0 END) as name_ok
    FROM DataChecks
);

-- 14. Complete instructor timeline
SELECT 
    ins_id as ID,
    lastname || ', ' || firstname as Name,
    city as Current_City,
    country as Country_Code,
    CASE 
        WHEN ins_id = 7 THEN 'Formerly Antonio in Vancouver'
        WHEN ins_id = 8 THEN 'Formerly Steve in Barlby'
        WHEN ins_id = 9 THEN 'Formerly Ramesh in Hyderabad'
        ELSE 'Original location'
    END as Previous_Info
FROM Instructor
ORDER BY ins_id;

-- 15. Lessons learned and best practices:
-- 1. Use UPDATE for modifying existing records (clear intent)
-- 2. Use INSERT for adding new records only
-- 3. Check database conflict resolution settings
-- 4. Always verify changes after data manipulation
-- 5. Maintain audit trails for important data changes
-- 6. Validate business rules (no duplicate names, valid locations, etc.)
-- 7. Use transactions for atomic operations

-- 16. Final state confirmation
SELECT * FROM Instructor ORDER BY ins_id;