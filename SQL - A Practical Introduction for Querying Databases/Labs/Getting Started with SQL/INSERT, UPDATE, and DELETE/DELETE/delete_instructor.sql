-- Practice SQL
-- Database: Instructors

-- Query 1: Delete an instructor record using primary key
DELETE FROM instructor
WHERE ins_id = 6;

-- Query 2: View all instructor records after the deletion
SELECT * FROM Instructor;

/*
Final Output after DELETE operation:
+--------+-----------+-----------+-------------+---------+
| ins_id | lastname  | firstname | city        | country |
+--------+-----------+-----------+-------------+---------+
|      1 | Ahuja     | Rav       | Markham     | CA      |
|      2 | Chong     | Raul      | Toronto     | CA      |
|      4 | Saha      | Sandip    | Dhaka       | BD      |
|      5 | Doe       | John      | Dubai       | AE      |
|      7 | Cangiano  | Tony      | Toronto     | CA      |
|      8 | Ryan      | Steven    | London      | GB      |
|      9 | Sannareddy| Ram       | Bangalore   | IN      |
+--------+-----------+-----------+-------------+---------+
(7 instructors total - was 8)

What happened:
1. DELETE statement removed the record WHERE ins_id = 6
2. Only one instructor matches: Jane Doe (ins_id=6)
3. Record permanently deleted from the database
4. Total instructors reduced from 8 to 7
5. All other records unchanged

Deleted record was:
ins_id=6 | Doe | Jane | Dhaka | BD
*/

-- File name: delete_instructor.sql

-- Comprehensive analysis of the DELETE operation:

-- 1. Verify the deletion was successful
SELECT * FROM Instructor WHERE ins_id = 6;
/*
Returns: 0 rows (record no longer exists)
*/

-- 2. Confirm which record was deleted
-- Based on previous state, we know it was:
-- 6 | Doe | Jane | Dhaka | BD

-- 3. Impact analysis on geographic distribution
SELECT 
    country,
    COUNT(*) as InstructorCount,
    GROUP_CONCAT(city || ' (' || firstname || ' ' || lastname || ')' ORDER BY city, lastname) as RemainingInstructors
FROM Instructor
GROUP BY country
ORDER BY InstructorCount DESC;
/*
Now shows:
CA: 3 (Markham (Rav Ahuja), Toronto (Raul Chong), Toronto (Tony Cangiano))
BD: 1 (Dhaka (Sandip Saha))  <-- Reduced from 2 to 1
AE: 1 (Dubai (John Doe))
GB: 1 (London (Steven Ryan))
IN: 1 (Bangalore (Ram Sannareddy))
*/

-- 4. Dhaka office analysis after deletion
SELECT * FROM Instructor WHERE city = 'Dhaka';
/*
Now shows only: 4 | Saha | Sandip | Dhaka | BD
Jane Doe (previously in Dhaka) has been deleted
*/

-- 5. Doe family analysis
SELECT * FROM Instructor WHERE lastname = 'Doe';
/*
Now shows only: 5 | Doe | John | Dubai | AE
Jane Doe has been deleted, only John Doe remains
*/

-- 6. Create backup of deleted record (best practice before DELETE)
-- In real scenarios, always backup or archive before DELETE
/*
-- Method 1: Archive table
CREATE TABLE IF NOT EXISTS Instructor_Archive (
    ins_id INT,
    lastname TEXT,
    firstname TEXT,
    city TEXT,
    country TEXT,
    deleted_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_by TEXT
);

-- Archive before deletion
INSERT INTO Instructor_Archive (ins_id, lastname, firstname, city, country, deleted_by)
SELECT ins_id, lastname, firstname, city, country, 'system' 
FROM Instructor 
WHERE ins_id = 6;

-- Then delete
DELETE FROM Instructor WHERE ins_id = 6;
*/

-- 7. Comprehensive instructor directory after deletion
SELECT 
    ins_id as ID,
    UPPER(lastname) || ', ' || INITCAP(firstname) as Name,
    CASE 
        WHEN city = 'Dhaka' THEN '🏙 ' || city || ' (sole instructor in Dhaka)'
        ELSE city
    END as City,
    CASE country
        WHEN 'BD' THEN '🇧🇩 Bangladesh'
        WHEN 'CA' THEN '🇨🇦 Canada'
        WHEN 'AE' THEN '🇦🇪 United Arab Emirates'
        WHEN 'GB' THEN '🇬🇧 United Kingdom'
        WHEN 'IN' THEN '🇮🇳 India'
        ELSE '🏳 ' || country
    END as Country,
    CASE 
        WHEN country = 'BD' THEN '⚠️ Only 1 instructor remaining'
        ELSE '✅ Adequate coverage'
    END as Coverage_Status
FROM Instructor
ORDER BY 
    CASE 
        WHEN country = 'BD' THEN 1  -- Highlight affected country
        ELSE 2
    END,
    lastname;

-- 8. Data validation after deletion
-- Check for any orphaned data or integrity issues
SELECT 
    'Data Integrity Check' as Check_Type,
    '' as Result
UNION ALL
SELECT 'Total Instructors Remaining', CAST(COUNT(*) as TEXT) FROM Instructor
UNION ALL
SELECT 'Countries Still Represented', CAST(COUNT(DISTINCT country) as TEXT) FROM Instructor
UNION ALL
SELECT 'Instructors in Bangladesh', CAST(SUM(CASE WHEN country = 'BD' THEN 1 ELSE 0 END) as TEXT) FROM Instructor
UNION ALL
SELECT 'Minimum per Country Check', 
    CASE 
        WHEN MIN(country_count) >= 1 THEN '✅ All countries have at least 1 instructor'
        ELSE '❌ Some countries have no instructors'
    END
FROM (
    SELECT country, COUNT(*) as country_count FROM Instructor GROUP BY country
) as country_stats
UNION ALL
SELECT 'Data Consistency', 
    CASE 
        WHEN COUNT(*) = COUNT(DISTINCT ins_id) THEN '✅ All IDs unique'
        ELSE '❌ Duplicate IDs found'
    END
FROM Instructor;

-- 9. Statistical summary after deletion
SELECT 
    'Post-Deletion Statistics' as Metric,
    '' as Value
UNION ALL
SELECT 'Current Instructor Count', CAST(COUNT(*) as TEXT) FROM Instructor
UNION ALL
SELECT 'Deleted Today', '1 (Jane Doe from Dhaka, BD)'
UNION ALL
SELECT 'Remaining Countries', CAST(COUNT(DISTINCT country) as TEXT) FROM Instructor
UNION ALL
SELECT 'Single-Instructor Countries', 
    CAST(COUNT(*) as TEXT)
FROM (
    SELECT country 
    FROM Instructor 
    GROUP BY country 
    HAVING COUNT(*) = 1
) as single_instructor_countries
UNION ALL
SELECT 'Average Instructors per Country', 
    CAST(ROUND(AVG(country_count), 2) as TEXT)
FROM (
    SELECT COUNT(*) as country_count 
    FROM Instructor 
    GROUP BY country
) as country_stats;

-- 10. Export for HR records (with deletion noted)
SELECT 
    ins_id as "Employee_ID",
    lastname as "Last_Name",
    firstname as "First_Name",
    city as "Location_City",
    CASE country
        WHEN 'BD' THEN 'Bangladesh'
        WHEN 'CA' THEN 'Canada'
        WHEN 'AE' THEN 'United Arab Emirates'
        WHEN 'GB' THEN 'United Kingdom'
        WHEN 'IN' THEN 'India'
        ELSE country
    END as "Country",
    CASE 
        WHEN lastname = 'Doe' AND firstname = 'John' THEN '⚠️ Only Doe family member remaining'
        WHEN country = 'BD' THEN '⚠️ Only instructor in Bangladesh'
        ELSE 'Active'
    END as "Status_Notes",
    'Active' as "Employment_Status"
FROM Instructor
UNION ALL
SELECT 
    6 as "Employee_ID",
    'Doe' as "Last_Name",
    'Jane' as "First_Name",
    'Dhaka' as "Location_City",
    'Bangladesh' as "Country",
    'DELETED - ' || DATE('now') as "Status_Notes",
    'Terminated' as "Employment_Status"
ORDER BY "Employment_Status" DESC, "Country", "Last_Name";

-- 11. Lessons from this DELETE operation:
-- 1. DELETE is permanent - no undo without backup
-- 2. Always use WHERE clause with DELETE (avoid DELETE FROM Instructor with no WHERE!)
-- 3. Using primary key (ins_id) ensures precise deletion
-- 4. Consider business impact (regional coverage, family connections, etc.)
-- 5. Archive/backup important data before deletion

-- 12. Dangerous DELETE examples to avoid:
-- DELETE FROM Instructor;  -- Deletes ALL records!
-- DELETE FROM Instructor WHERE lastname = 'Doe';  -- Could delete multiple
-- DELETE FROM Instructor WHERE city = 'Dhaka';  -- Could delete multiple

-- 13. Safe DELETE pattern with validation
/*
-- Step 1: Check what will be deleted
SELECT * FROM Instructor WHERE ins_id = 6;
-- Verify it's the correct record

-- Step 2: Check dependencies (if any foreign keys)
-- In a real database, check for related records in other tables

-- Step 3: Archive the record
INSERT INTO Instructor_Archive 
SELECT *, CURRENT_TIMESTAMP, 'system' FROM Instructor WHERE ins_id = 6;

-- Step 4: Perform deletion within transaction
BEGIN TRANSACTION;

DELETE FROM Instructor WHERE ins_id = 6;

-- Step 5: Verify deletion
SELECT COUNT(*) FROM Instructor WHERE ins_id = 6;
-- Should be 0

-- Step 6: Commit or rollback based on verification
COMMIT;
-- Or ROLLBACK; if something went wrong
*/

-- 14. Impact on business rules
-- Example rule: Each country should have at least 1 instructor
SELECT 
    country,
    COUNT(*) as instructor_count,
    CASE 
        WHEN COUNT(*) = 0 THEN '❌ No instructors'
        WHEN COUNT(*) = 1 THEN '⚠️ Only one instructor'
        ELSE '✅ Adequate coverage'
    END as status
FROM Instructor
GROUP BY country
ORDER BY instructor_count;
/*
Bangladesh now has only 1 instructor - at risk if that person leaves
*/

-- 15. Recovery options (if deletion was accidental)
-- Option 1: Restore from backup (if available)
/*
INSERT INTO Instructor (ins_id, lastname, firstname, city, country)
SELECT ins_id, lastname, firstname, city, country
FROM Instructor_Backup
WHERE ins_id = 6;
*/

-- Option 2: Manual re-insertion (if you know the data)
/*
INSERT INTO Instructor (ins_id, lastname, firstname, city, country)
VALUES (6, 'Doe', 'Jane', 'Dhaka', 'BD');
*/

-- 16. Complete remaining instructor analysis
WITH RegionalStats AS (
    SELECT 
        CASE 
            WHEN country IN ('BD', 'IN') THEN 'South Asia'
            WHEN country = 'CA' THEN 'North America'
            WHEN country = 'AE' THEN 'Middle East'
            WHEN country = 'GB' THEN 'Europe'
            ELSE 'Other'
        END as region,
        COUNT(*) as instructor_count
    FROM Instructor
    GROUP BY 
        CASE 
            WHEN country IN ('BD', 'IN') THEN 'South Asia'
            WHEN country = 'CA' THEN 'North America'
            WHEN country = 'AE' THEN 'Middle East'
            WHEN country = 'GB' THEN 'Europe'
            ELSE 'Other'
        END
)
SELECT 
    region,
    instructor_count,
    ROUND(instructor_count * 100.0 / SUM(instructor_count) OVER(), 1) as percentage,
    CASE 
        WHEN instructor_count >= 2 THEN '✅ Good coverage'
        WHEN instructor_count = 1 THEN '⚠️ Minimal coverage'
        ELSE '❌ No coverage'
    END as coverage_status
FROM RegionalStats
ORDER BY instructor_count DESC;
/*
Shows regional coverage after deletion
*/

-- 17. Final data integrity verification
SELECT 
    CASE 
        WHEN COUNT(DISTINCT ins_id) = COUNT(*) THEN '✅'
        ELSE '❌'
    END || ' All IDs unique (' || COUNT(*) || ' records)' as ID_Check,
    CASE 
        WHEN MIN(LENGTH(lastname)) > 0 AND MIN(LENGTH(firstname)) > 0 THEN '✅'
        ELSE '❌'
    END || ' All names populated' as Name_Check,
    CASE 
        WHEN MIN(LENGTH(city)) > 0 AND MIN(LENGTH(country)) > 0 THEN '✅'
        ELSE '❌'
    END || ' All locations complete' as Location_Check
FROM Instructor;

-- 18. Remaining instructor timeline with IDs
SELECT 
    ROW_NUMBER() OVER (ORDER BY ins_id) as Seq,
    ins_id as Original_ID,
    lastname || ', ' || firstname as Name,
    city || ', ' || country as Location,
    CASE 
        WHEN ins_id > 6 THEN 'ID gap after deletion'
        ELSE 'Sequential ID'
    END as ID_Note
FROM Instructor
ORDER BY ins_id;
/*
Shows ID sequence now has a gap (missing 6)
*/

-- 19. Final state confirmation
SELECT * FROM Instructor ORDER BY ins_id;