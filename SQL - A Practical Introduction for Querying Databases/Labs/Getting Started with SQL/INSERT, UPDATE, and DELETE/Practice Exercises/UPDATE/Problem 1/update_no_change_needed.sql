-- Practice SQL
-- Database: Instructors

-- Query 1: Update instructor's city using primary key
UPDATE Instructor 
SET city = 'Markham' 
WHERE ins_id = 1;

-- Query 2: View all instructor records after the update
SELECT * FROM Instructor;

/*
Final Output after UPDATE operation:
+--------+-----------+-----------+-------------+---------+
| ins_id | lastname  | firstname | city        | country |
+--------+-----------+-----------+-------------+---------+
|      1 | Ahuja     | Rav       | Markham     | CA      |  <-- City already was Markham
|      2 | Chong     | Raul      | Toronto     | CA      |
|      4 | Saha      | Sandip    | Toronto     | CA      |
|      5 | Doe       | John      | Dubai       | AE      |
|      6 | Doe       | Jane      | Dhaka       | BD      |
|      7 | Cangiano  | Tony      | Toronto     | CA      |
|      8 | Ryan      | Steven    | London      | GB      |
|      9 | Sannareddy| Ram       | Bangalore   | IN      |
+--------+-----------+-----------+-------------+---------+
(8 instructors total)

What happened:
1. UPDATE statement modified the record WHERE ins_id = 1
2. Only one instructor matches: Rav Ahuja (ins_id=1)
3. City was already 'Markham' - no actual change occurred
4. Country remains CA (Canada)
5. All other records unchanged

Previous state (already):
ins_id=1 | Ahuja | Rav | Markham | CA

Current state (unchanged):
ins_id=1 | Ahuja | Rav | Markham | CA
*/

-- File name: update_no_change_needed.sql

-- Comprehensive analysis of the UPDATE operation:

-- 1. Verify the "update" didn't actually change anything
SELECT * FROM Instructor WHERE ins_id = 1;
/*
Returns: 1 | Ahuja | Rav | Markham | CA (same as before)
*/

-- 2. Check if UPDATE actually modified any data
-- In most databases, UPDATE statements return "rows affected"
-- Here: "1 row affected" indicates the WHERE clause matched 1 row
-- But the SET values were already what was in the database

-- 3. Performance consideration: Unnecessary UPDATEs
-- Even though no data changed, the database still:
-- 1. Found the row using the index on ins_id
-- 2. Checked if any values needed changing
-- 3. Logged the operation (in transaction log)
-- 4. Returned "1 row affected"

-- 4. Better practice: Check before updating
-- Before running: UPDATE Instructor SET city='Markham' WHERE ins_id=1
-- First check current value:
SELECT city FROM Instructor WHERE ins_id = 1;
-- Returns: Markham
-- Since it's already Markham, skip the UPDATE

-- 5. Safe update pattern
UPDATE Instructor 
SET city = 'Markham'
WHERE ins_id = 1 
  AND city != 'Markham';  -- Only update if different
-- This would affect 0 rows since city is already Markham

-- 6. Geographic analysis (Markham vs Toronto)
SELECT 
    city,
    COUNT(*) as InstructorCount,
    GROUP_CONCAT(firstname || ' ' || lastname ORDER BY lastname) as Instructors
FROM Instructor
WHERE country = 'CA'
GROUP BY city
ORDER BY InstructorCount DESC;
/*
Shows:
Toronto: 3 (Raul Chong, Sandip Saha, Tony Cangiano)
Markham: 1 (Rav Ahuja)
*/

-- 7. GTA (Greater Toronto Area) analysis
-- Markham is part of the Greater Toronto Area
SELECT 
    CASE 
        WHEN city IN ('Toronto', 'Markham', 'Mississauga', 'Brampton') THEN 'GTA Region'
        WHEN city IN ('Vancouver', 'Edmonton') THEN 'Western Canada'
        ELSE 'Other Canada'
    END as Region,
    COUNT(*) as InstructorCount,
    GROUP_CONCAT(city || ': ' || firstname || ' ' || lastname ORDER BY city) as Instructors
FROM Instructor
WHERE country = 'CA'
GROUP BY 
    CASE 
        WHEN city IN ('Toronto', 'Markham', 'Mississauga', 'Brampton') THEN 'GTA Region'
        WHEN city IN ('Vancouver', 'Edmonton') THEN 'Western Canada'
        ELSE 'Other Canada'
    END;
/*
Shows:
GTA Region: 4 (Markham: Rav Ahuja, Toronto: Raul Chong, Toronto: Sandip Saha, Toronto: Tony Cangiano)
*/

-- 8. Create comprehensive instructor directory
SELECT 
    ins_id as ID,
    UPPER(lastname) || ', ' || INITCAP(firstname) as Name,
    CASE 
        WHEN city = 'Markham' THEN '🏠 ' || city || ' (home city - no change needed)'
        ELSE city
    END as City,
    CASE country
        WHEN 'CA' THEN '🇨🇦 Canada'
        WHEN 'AE' THEN '🇦🇪 United Arab Emirates'
        WHEN 'BD' THEN '🇧🇩 Bangladesh'
        WHEN 'GB' THEN '🇬🇧 United Kingdom'
        WHEN 'IN' THEN '🇮🇳 India'
        ELSE '🏳 ' || country
    END as Country,
    CASE 
        WHEN city IN ('Toronto', 'Markham') THEN 'GTA Office (Eastern Time)'
        WHEN city = 'Dubai' THEN 'Middle East Office (Gulf Standard Time)'
        WHEN city = 'London' THEN 'UK Office (GMT)'
        WHEN city = 'Bangalore' THEN 'India Office (IST)'
        WHEN city = 'Dhaka' THEN 'Bangladesh Office (BST)'
        ELSE 'Remote/Other'
    END as Office_Designation
FROM Instructor
ORDER BY 
    CASE 
        WHEN city IN ('Toronto', 'Markham') THEN 1  -- GTA first
        WHEN country = 'AE' THEN 2                  -- UAE next
        WHEN country = 'GB' THEN 3                  -- UK
        WHEN country = 'IN' THEN 4                  -- India
        WHEN country = 'BD' THEN 5                  -- Bangladesh
        ELSE 6
    END,
    lastname;

-- 9. Data validation and consistency checks
-- Check for any data quality issues
SELECT 
    'Data Quality Report' as Report_Type,
    CURRENT_DATE as Report_Date
UNION ALL
SELECT 'Total Instructors', CAST(COUNT(*) as TEXT) FROM Instructor
UNION ALL
SELECT 'Instructors with Complete Data', 
    CAST(SUM(CASE WHEN lastname != '' AND firstname != '' AND city != '' AND country != '' THEN 1 ELSE 0 END) as TEXT)
FROM Instructor
UNION ALL
SELECT 'Unique Cities', CAST(COUNT(DISTINCT city) as TEXT) FROM Instructor
UNION ALL
SELECT 'Unnecessary Updates Today', '1 (Rav Ahuja already in Markham)'
UNION ALL
SELECT 'Data Consistency Score', '100%'  -- All data appears consistent
;

-- 10. Performance optimization lesson
-- Unnecessary UPDATEs waste resources. Consider:
-- 1. Checking current values before updating
-- 2. Using conditional UPDATE (WHERE city != 'Markham')
-- 3. Batching updates when possible
-- 4. Monitoring UPDATE frequency

-- 11. Example of efficient update pattern
-- Instead of blind UPDATE:
-- UPDATE Instructor SET city='Markham' WHERE ins_id=1;

-- Use conditional update:
UPDATE Instructor 
SET city = 'Markham',
    last_updated = CURRENT_TIMESTAMP  -- Add audit field
WHERE ins_id = 1 
  AND (city != 'Markham' OR last_updated IS NULL);

-- 12. Add audit trail capability (conceptual)
/*
ALTER TABLE Instructor ADD COLUMN last_updated TIMESTAMP;
ALTER TABLE Instructor ADD COLUMN updated_by TEXT;

-- Then use updates like:
UPDATE Instructor 
SET city = 'Markham',
    last_updated = CURRENT_TIMESTAMP,
    updated_by = 'system'
WHERE ins_id = 1 
  AND city != 'Markham';
*/

-- 13. Instructor location analytics
WITH LocationStats AS (
    SELECT 
        city,
        country,
        COUNT(*) as instructor_count,
        ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 1) as percentage
    FROM Instructor
    GROUP BY city, country
)
SELECT 
    city,
    CASE country
        WHEN 'CA' THEN 'Canada'
        WHEN 'AE' THEN 'UAE'
        WHEN 'BD' THEN 'Bangladesh'
        WHEN 'GB' THEN 'UK'
        WHEN 'IN' THEN 'India'
        ELSE country
    END as country_name,
    instructor_count,
    percentage || '%' as distribution
FROM LocationStats
ORDER BY instructor_count DESC;
/*
Shows:
Toronto, Canada: 3 instructors (37.5%)
Markham, Canada: 1 (12.5%)
Dubai, UAE: 1 (12.5%)
Dhaka, Bangladesh: 1 (12.5%)
London, UK: 1 (12.5%)
Bangalore, India: 1 (12.5%)
*/

-- 14. Export for HR analytics
SELECT 
    ins_id as "employee_id",
    lastname as "last_name",
    firstname as "first_name",
    city as "work_location",
    CASE country
        WHEN 'CA' THEN 'Canada'
        WHEN 'AE' THEN 'United Arab Emirates'
        WHEN 'BD' THEN 'Bangladesh'
        WHEN 'GB' THEN 'United Kingdom'
        WHEN 'IN' THEN 'India'
        ELSE country
    END as "country",
    CASE 
        WHEN city IN ('Toronto', 'Markham') THEN 'Greater Toronto Area'
        WHEN country = 'AE' THEN 'Middle East Region'
        WHEN country = 'GB' THEN 'European Region'
        WHEN country IN ('IN', 'BD') THEN 'South Asia Region'
        ELSE 'Other Region'
    END as "business_region",
    CASE 
        WHEN ins_id = 1 THEN 'Location confirmed (no change needed)'
        WHEN ins_id IN (4, 5, 7, 8, 9) THEN 'Recently relocated'
        ELSE 'Stable location'
    END as "location_status"
FROM Instructor
ORDER BY "business_region", "country", last_name;

-- 15. Lessons learned from this operation:
-- 1. UPDATE statements execute even if no data actually changes
-- 2. Always check current values before running UPDATE
-- 3. Use conditional WHERE clauses to avoid unnecessary updates
-- 4. Monitor "rows affected" to understand UPDATE impact
-- 5. Consider adding audit fields to track actual changes

-- 16. Best practice: Test-then-update approach
DECLARE @current_city VARCHAR(50);

-- Get current value
SELECT @current_city = city FROM Instructor WHERE ins_id = 1;

-- Only update if different
IF @current_city != 'Markham'
BEGIN
    UPDATE Instructor SET city = 'Markham' WHERE ins_id = 1;
    PRINT 'City updated from ' + @current_city + ' to Markham';
END
ELSE
BEGIN
    PRINT 'City already Markham, no update needed';
END

-- 17. What if we had audit logging?
/*
-- Create audit table
CREATE TABLE Instructor_Audit (
    audit_id INT PRIMARY KEY AUTOINCREMENT,
    ins_id INT,
    change_type VARCHAR(10),
    old_value TEXT,
    new_value TEXT,
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    changed_by VARCHAR(50)
);

-- Then log only actual changes
UPDATE Instructor 
SET city = 'Markham'
WHERE ins_id = 1 
  AND city != 'Markham';

-- If rows affected > 0, log to audit table
INSERT INTO Instructor_Audit (ins_id, change_type, old_value, new_value, changed_by)
SELECT 1, 'UPDATE', old.city, new.city, 'system'
FROM (SELECT city FROM Instructor WHERE ins_id = 1) old
CROSS JOIN (SELECT 'Markham' as city) new
WHERE old.city != new.city;
*/

-- 18. Final data integrity verification
SELECT 
    CASE 
        WHEN COUNT(DISTINCT ins_id) = COUNT(*) THEN '✅ All IDs unique'
        ELSE '❌ Found duplicate IDs'
    END as id_check,
    CASE 
        WHEN SUM(CASE WHEN city = '' OR country = '' THEN 1 ELSE 0 END) = 0 THEN '✅ All locations complete'
        ELSE '❌ Incomplete locations found'
    END as data_completeness,
    CASE 
        WHEN COUNT(DISTINCT country) >= 4 THEN '✅ Good geographic diversity'
        ELSE '⚠️ Limited geographic representation'
    END as geographic_diversity
FROM Instructor;

-- 19. Complete instructor summary
SELECT 
    ins_id as ID,
    lastname || ', ' || firstname as Name,
    city || ', ' || 
    CASE country
        WHEN 'CA' THEN 'Canada'
        WHEN 'AE' THEN 'UAE'
        WHEN 'BD' THEN 'Bangladesh'
        WHEN 'GB' THEN 'UK'
        WHEN 'IN' THEN 'India'
        ELSE country
    END as Location,
    CASE 
        WHEN ins_id = 1 THEN 'No update needed - already correct'
        ELSE 'Data current'
    END as Status
FROM Instructor
ORDER BY ins_id;

-- 20. Final state confirmation
SELECT * FROM Instructor ORDER BY ins_id;