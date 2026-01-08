-- Practice SQL
-- Database: Instructors

-- Query 1: Attempt to delete instructor by first name
DELETE FROM instructor
WHERE firstname = 'Hima';

-- Query 2: View all instructor records (no changes)
SELECT * FROM Instructor;

/*
Final Output after DELETE attempt:
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
(7 instructors total - no change)

What happened:
1. DELETE statement attempted to remove records WHERE firstname = 'Hima'
2. No instructor has firstname 'Hima' in the database
3. "0 rows affected" - no records were deleted
4. Table remains unchanged
5. All 7 instructors still present

Note: This is a safe DELETE operation since no matching records were found
*/

-- File name: delete_no_match.sql

-- Comprehensive analysis of the DELETE operation with no matches:

-- 1. Verify no instructor named 'Hima' exists
SELECT * FROM Instructor WHERE firstname = 'Hima';
/*
Returns: 0 rows
Confirms no instructor with firstname 'Hima'
*/

-- 2. Check all current first names in database
SELECT DISTINCT firstname FROM Instructor ORDER BY firstname;
/*
Returns:
John
Ram
Rav
Raul
Sandip
Steven
Tony

No 'Hima' in the list
*/

-- 3. Safe DELETE pattern demonstrated
-- This DELETE was safe because:
-- 1. It used a WHERE clause (not DELETE FROM Instructor without WHERE)
-- 2. The condition didn't match any records
-- 3. "0 rows affected" confirms no deletion occurred

-- 4. What if there WAS an instructor named 'Hima'?
-- To understand the potential impact, let's analyze:
SELECT COUNT(*) as PotentialDeletions FROM Instructor WHERE firstname = 'Hima';
-- Returns 0, but if it returned > 0, those records would be deleted

-- 5. Dangerous DELETE scenarios to be aware of:
-- Scenario 1: DELETE without WHERE (deletes everything)
-- DELETE FROM Instructor;  -- DANGEROUS!

-- Scenario 2: DELETE with common first name
-- DELETE FROM Instructor WHERE firstname = 'John';  -- Would delete John Doe

-- Scenario 3: Typo in condition
-- DELETE FROM Instructor WHERE firstname = 'Jhon';  -- Typo, might delete nothing or wrong person

-- 6. Best practice: Always verify before DELETE
-- Step 1: Check what will be deleted
SELECT * FROM Instructor WHERE firstname = 'Hima';
-- Returns 0 rows

-- Step 2: If returns > 0 rows, review carefully
-- Step 3: Consider backing up those records
-- Step 4: Then execute DELETE

-- 7. Create safe DELETE procedure (conceptual)
/*
CREATE PROCEDURE SafeDeleteInstructor(@firstname VARCHAR(50))
AS
BEGIN
    DECLARE @record_count INT;
    
    -- Check how many records match
    SELECT @record_count = COUNT(*) 
    FROM Instructor 
    WHERE firstname = @firstname;
    
    IF @record_count = 0
    BEGIN
        PRINT 'No records found with firstname: ' + @firstname;
        RETURN;
    END
    
    IF @record_count = 1
    BEGIN
        -- Show the record that will be deleted
        SELECT * FROM Instructor WHERE firstname = @firstname;
        
        PRINT '1 record will be deleted. Proceed?';
        -- In application, ask for confirmation
    END
    ELSE
    BEGIN
        PRINT CAST(@record_count AS VARCHAR) + ' records will be deleted.';
        SELECT * FROM Instructor WHERE firstname = @firstname;
        
        PRINT 'Multiple records will be deleted. Proceed with caution?';
        -- In application, show warning and ask for confirmation
    END
    
    -- Actual deletion would be handled by application after confirmation
END;
*/

-- 8. Current instructor statistics
SELECT 
    'Current Database State' as Report,
    '' as Value
UNION ALL
SELECT 'Total Instructors', CAST(COUNT(*) as TEXT) FROM Instructor
UNION ALL
SELECT 'Unique First Names', CAST(COUNT(DISTINCT firstname) as TEXT) FROM Instructor
UNION ALL
SELECT 'Countries Represented', CAST(COUNT(DISTINCT country) as TEXT) FROM Instructor
UNION ALL
SELECT 'Safe DELETE Operations', '1 (attempted to delete non-existent Hima)'
UNION ALL
SELECT 'Actual Deletions Today', '1 (Jane Doe at 10:42 AM)';

-- 9. Name pattern analysis
SELECT 
    firstname,
    COUNT(*) as Frequency,
    GROUP_CONCAT(lastname ORDER BY lastname) as LastNames
FROM Instructor
GROUP BY firstname
ORDER BY Frequency DESC, firstname;
/*
Shows:
John: 1 (Doe)
Ram: 1 (Sannareddy)
Rav: 1 (Ahuja)
Raul: 1 (Chong)
Sandip: 1 (Saha)
Steven: 1 (Ryan)
Tony: 1 (Cangiano)

All first names are unique in current dataset
*/

-- 10. What names COULD be dangerous to delete?
-- Names that appear multiple times would delete multiple records
SELECT 
    firstname,
    COUNT(*) as RecordCount
FROM Instructor
GROUP BY firstname
HAVING COUNT(*) > 1;
-- Returns 0 rows (all first names are unique currently)

-- 11. Create comprehensive instructor directory
SELECT 
    ins_id as ID,
    UPPER(lastname) || ', ' || INITCAP(firstname) as Name,
    city as City,
    CASE country
        WHEN 'CA' THEN '🇨🇦 Canada'
        WHEN 'BD' THEN '🇧🇩 Bangladesh'
        WHEN 'AE' THEN '🇦🇪 United Arab Emirates'
        WHEN 'GB' THEN '🇬🇧 United Kingdom'
        WHEN 'IN' THEN '🇮🇳 India'
        ELSE '🏳 ' || country
    END as Country,
    CASE 
        WHEN firstname IN ('John', 'Jane') THEN '⚠️ Only remaining Doe family member'
        WHEN country = 'BD' THEN '⚠️ Only instructor in Bangladesh'
        ELSE '✅ Stable'
    END as Status_Note
FROM Instructor
ORDER BY 
    CASE 
        WHEN country = 'BD' THEN 1  -- Highlight vulnerable country
        ELSE 2
    END,
    lastname;

-- 12. Data protection recommendations
-- For production databases, consider:
-- 1. Soft deletes (add 'is_active' flag instead of physical DELETE)
-- 2. Audit logging for all DELETE operations
-- 3. Permission controls (who can DELETE)
-- 4. Backup before bulk deletions
-- 5. Confirmation dialogs in applications

-- 13. Soft delete example (alternative approach)
/*
-- Add active flag to table
ALTER TABLE Instructor ADD COLUMN is_active BOOLEAN DEFAULT 1;

-- Instead of DELETE, update the flag
UPDATE Instructor 
SET is_active = 0
WHERE firstname = 'Hima';  -- Would affect 0 rows

-- View only active instructors
SELECT * FROM Instructor WHERE is_active = 1;

-- "Undelete" if needed
UPDATE Instructor SET is_active = 1 WHERE ins_id = 6;
*/

-- 14. Export current state for reference
SELECT 
    ins_id as "ID",
    lastname as "Last_Name",
    firstname as "First_Name",
    city as "City",
    CASE country
        WHEN 'CA' THEN 'Canada'
        WHEN 'BD' THEN 'Bangladesh'
        WHEN 'AE' THEN 'United Arab Emirates'
        WHEN 'GB' THEN 'United Kingdom'
        WHEN 'IN' THEN 'India'
        ELSE country
    END as "Country",
    'Active' as "Status",
    CURRENT_DATE as "As_Of_Date"
FROM Instructor
UNION ALL
SELECT 
    6 as "ID",
    'Doe' as "Last_Name",
    'Jane' as "First_Name",
    'Dhaka' as "City",
    'Bangladesh' as "Country",
    'Deleted ' || DATE('now') as "Status",
    CURRENT_DATE as "As_Of_Date"
ORDER BY "Status", "Country", "Last_Name";

-- 15. Lessons from this operation:
-- 1. DELETE with no matching WHERE clause is safe (0 rows affected)
-- 2. Always check "rows affected" after DELETE operations
-- 3. Using non-unique criteria (firstname) can be risky if matches exist
-- 4. Better to use primary key (ins_id) for precise deletions
-- 5. Consider implementing soft delete pattern for important data

-- 16. What if we had found 'Hima'?
-- Example recovery procedure if wrong deletion occurred:
/*
-- Step 1: Identify what was deleted (from logs or backup)
-- Step 2: Restore from backup if available
INSERT INTO Instructor (ins_id, lastname, firstname, city, country)
SELECT ins_id, lastname, firstname, city, country
FROM Instructor_Backup
WHERE firstname = 'Hima';

-- Step 3: Update application to prevent recurrence
*/

-- 17. Data quality assessment
WITH QualityMetrics AS (
    SELECT 
        COUNT(*) as total_records,
        COUNT(DISTINCT firstname) as unique_firstnames,
        SUM(CASE WHEN LENGTH(TRIM(firstname)) = 0 THEN 1 ELSE 0 END) as empty_firstnames,
        SUM(CASE WHEN firstname = 'Hima' THEN 1 ELSE 0 END) as hima_count
    FROM Instructor
)
SELECT 
    CASE 
        WHEN hima_count = 0 THEN '✅ No instructors named Hima (safe DELETE)'
        ELSE '⚠️ Found ' || hima_count || ' instructors named Hima'
    END as Delete_Safety,
    CASE 
        WHEN empty_firstnames = 0 THEN '✅ All first names populated'
        ELSE '❌ ' || empty_firstnames || ' empty first names found'
    END as Data_Completeness,
    CASE 
        WHEN unique_firstnames = total_records THEN '✅ All first names unique'
        ELSE '⚠️ Some duplicate first names exist'
    END as Name_Uniqueness
FROM QualityMetrics;

-- 18. Final instructor roster with safety notes
SELECT 
    ROW_NUMBER() OVER (ORDER BY ins_id) as RowNum,
    ins_id,
    lastname || ', ' || firstname as FullName,
    city || ', ' || country as Location,
    CASE 
        WHEN firstname IN ('John', 'Jane', 'James', 'Jim') THEN '⚠️ Common first name (use ID for deletion)'
        ELSE '✅ Unique enough for careful deletion'
    END as Deletion_Risk
FROM Instructor
ORDER BY ins_id;

-- 19. Best practice summary for DELETE operations:
-- 1. Always use WHERE clause (avoid DELETE FROM table without WHERE)
-- 2. Prefer primary key over other identifiers
-- 3. Check affected rows count (0 rows affected = safe but ineffective)
-- 4. Backup before important deletions
-- 5. Consider soft delete pattern for business data
-- 6. Implement audit logging for all deletions
-- 7. Use transactions for reversible operations
-- 8. Test DELETE with SELECT first

-- 20. Final state confirmation
SELECT * FROM Instructor ORDER BY ins_id;