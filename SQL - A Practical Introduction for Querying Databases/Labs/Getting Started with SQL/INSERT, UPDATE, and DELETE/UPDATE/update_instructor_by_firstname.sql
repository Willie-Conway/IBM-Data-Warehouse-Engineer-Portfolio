-- Practice SQL
-- Database: Instructors

-- Query 1: Update instructor's city based on first name
UPDATE Instructor 
SET city = 'Toronto' 
WHERE firstname = "Sandip";

-- Query 2: View all instructor records after the update
SELECT * FROM Instructor;

/*
Final Output after UPDATE operation:
+--------+-----------+-----------+-------------+---------+
| ins_id | lastname  | firstname | city        | country |
+--------+-----------+-----------+-------------+---------+
|      1 | Ahuja     | Rav       | Markham     | CA      |
|      2 | Chong     | Raul      | Toronto     | CA      |
|      4 | Saha      | Sandip    | Toronto     | CA      |  <-- UPDATED
|      5 | Doe       | John      | Sydney      | AU      |
|      6 | Doe       | Jane      | Dhaka       | BD      |
|      7 | Cangiano  | Tony      | Toronto     | CA      |
|      8 | Ryan      | Steven    | London      | GB      |
|      9 | Sannareddy| Ram       | Bangalore   | IN      |
+--------+-----------+-----------+-------------+---------+
(8 instructors total)

What happened:
1. UPDATE statement modified records WHERE firstname = "Sandip"
2. Only one instructor matches: Sandip Saha (ins_id=4)
3. City changed from Edmonton to Toronto
4. Country remains CA (Canada)
5. All other records unchanged

Previous state:
ins_id=4 | Saha | Sandip | Edmonton | CA

Current state:
ins_id=4 | Saha | Sandip | Toronto | CA
*/

-- File name: update_instructor_by_firstname.sql

-- Comprehensive analysis of the UPDATE operation:

-- 1. Verify the specific change
SELECT * FROM Instructor WHERE firstname = 'Sandip';
/*
Returns: 4 | Saha | Sandip | Toronto | CA
*/

-- 2. Track the change (simulated history)
WITH PreviousState AS (
    SELECT 4 as ins_id, 'Saha' as lastname, 'Sandip' as firstname, 'Edmonton' as old_city, 'Toronto' as new_city, 'CA' as country
)
SELECT 
    p.ins_id as ID,
    p.lastname || ', ' || p.firstname as Name,
    p.old_city as Previous_City,
    p.new_city as Current_City,
    p.country as Country,
    'Moved within Canada' as Change_Type
FROM PreviousState p;

-- 3. Toronto instructors analysis (after update)
SELECT * FROM Instructor WHERE city = 'Toronto' ORDER BY lastname;
/*
Now shows 3 instructors in Toronto:
1. Tony Cangiano (ID 7)
2. Raul Chong (ID 2)  
3. Sandip Saha (ID 4) - newly added to Toronto
*/

-- 4. Geographic distribution update
SELECT 
    city,
    COUNT(*) as InstructorCount,
    GROUP_CONCAT(firstname || ' ' || lastname ORDER BY lastname) as Instructors
FROM Instructor
WHERE country = 'CA'
GROUP BY city
ORDER BY InstructorCount DESC;
/*
Shows Canadian city distribution:
Toronto: 3 (Raul Chong, Sandip Saha, Tony Cangiano)
Markham: 1 (Rav Ahuja)
Edmonton: 0 (previously had Sandip Saha)
Vancouver: 0 (previously had Antonio Cangiano)
*/

-- 5. Impact analysis of the UPDATE
SELECT 
    'Instructors in Toronto' as Metric,
    CAST(COUNT(*) as TEXT) as Value
FROM Instructor 
WHERE city = 'Toronto'
UNION ALL
SELECT 
    'Instructors moved from Edmonton',
    CAST(COUNT(*) as TEXT)
FROM Instructor 
WHERE city = 'Edmonton'  -- Should be 0 now
UNION ALL
SELECT 
    'Canadian cities with instructors',
    CAST(COUNT(DISTINCT city) as TEXT)
FROM Instructor 
WHERE country = 'CA';

-- 6. Potential issues with UPDATE by firstname
-- What if there were multiple instructors named "Sandip"?
INSERT INTO Instructor(ins_id, lastname, firstname, city, country)
VALUES(10, 'Patel', 'Sandip', 'Montreal', 'CA');

-- Now running the same UPDATE would affect BOTH Sandips
UPDATE Instructor 
SET city = 'Toronto' 
WHERE firstname = "Sandip";
-- This would move BOTH Sandip Saha AND Sandip Patel to Toronto

-- 7. Safer UPDATE approach using unique identifier
UPDATE Instructor 
SET city = 'Toronto' 
WHERE ins_id = 4;  -- More precise than using firstname

-- 8. Create comprehensive instructor directory
SELECT 
    ins_id as ID,
    lastname || ', ' || firstname as Name,
    CASE 
        WHEN ins_id = 4 THEN '🏙 ' || city || ' (recently moved from Edmonton)'
        WHEN ins_id = 7 THEN '🏙 ' || city || ' (recently moved from Vancouver)'
        WHEN ins_id = 8 THEN '🏙 ' || city || ' (recently moved from Barlby)'
        WHEN ins_id = 9 THEN '🏙 ' || city || ' (recently moved from Hyderabad)'
        ELSE city
    END as Location,
    CASE country
        WHEN 'CA' THEN '🇨🇦 Canada'
        WHEN 'GB' THEN '🇬🇧 United Kingdom'
        WHEN 'IN' THEN '🇮🇳 India'
        WHEN 'AU' THEN '🇦🇺 Australia'
        WHEN 'BD' THEN '🇧🇩 Bangladesh'
        ELSE '🏳 ' || country
    END as Country,
    CASE 
        WHEN city = 'Toronto' THEN 'Eastern Time (ET)'
        WHEN city = 'Vancouver' THEN 'Pacific Time (PT)'
        WHEN city = 'Edmonton' THEN 'Mountain Time (MT)'
        WHEN city = 'Markham' THEN 'Eastern Time (ET)'
        WHEN city = 'London' THEN 'GMT (UTC+0)'
        WHEN city = 'Bangalore' THEN 'IST (UTC+5:30)'
        WHEN city = 'Sydney' THEN 'AEST (UTC+10)'
        WHEN city = 'Dhaka' THEN 'BST (UTC+6)'
        ELSE 'Check timezone'
    END as Timezone
FROM Instructor
ORDER BY country, city, lastname;

-- 9. Data quality and business rule validation
-- Rule: No more than 3 instructors per city (example business rule)
SELECT 
    city,
    country,
    COUNT(*) as InstructorCount,
    CASE 
        WHEN COUNT(*) > 3 THEN '❌ Exceeds limit'
        WHEN COUNT(*) = 3 THEN '⚠️ At limit'
        ELSE '✅ Within limits'
    END as Status
FROM Instructor
GROUP BY city, country
HAVING COUNT(*) >= 3;
/*
Toronto, CA: 3 instructors (at limit)
*/

-- 10. Update impact on regional distribution
WITH RegionalAnalysis AS (
    SELECT 
        CASE 
            WHEN city = 'Toronto' THEN 'GTA (Greater Toronto Area)'
            WHEN city IN ('Markham', 'Vancouver', 'Edmonton') THEN 'Other Canadian Cities'
            WHEN country = 'CA' THEN 'Rest of Canada'
            ELSE 'International'
        END as Region,
        COUNT(*) as InstructorCount
    FROM Instructor
    GROUP BY 
        CASE 
            WHEN city = 'Toronto' THEN 'GTA (Greater Toronto Area)'
            WHEN city IN ('Markham', 'Vancouver', 'Edmonton') THEN 'Other Canadian Cities'
            WHEN country = 'CA' THEN 'Rest of Canada'
            ELSE 'International'
        END
)
SELECT 
    Region,
    InstructorCount,
    ROUND(InstructorCount * 100.0 / SUM(InstructorCount) OVER(), 1) as Percentage
FROM RegionalAnalysis
ORDER BY InstructorCount DESC;
/*
Shows regional distribution percentages
*/

-- 11. Backup strategy before UPDATE operations
-- Best practice: Backup affected records before UPDATE
/*
-- Create backup of records that will be changed
CREATE TABLE Instructor_Backup AS 
SELECT *, CURRENT_TIMESTAMP as backup_time
FROM Instructor 
WHERE firstname = 'Sandip';

-- Then perform UPDATE
UPDATE Instructor SET city = 'Toronto' WHERE firstname = 'Sandip';

-- Verify changes
SELECT * FROM Instructor WHERE firstname = 'Sandip';

-- If something went wrong, restore from backup
/*
UPDATE Instructor i
SET city = b.city
FROM Instructor_Backup b
WHERE i.ins_id = b.ins_id;
*/
*/

-- 12. Statistical summary
SELECT 
    'Post-Update Statistics' as Category,
    '' as Value
UNION ALL
SELECT 'Total Instructors', CAST(COUNT(*) as TEXT) FROM Instructor
UNION ALL
SELECT 'Toronto Instructors', CAST(SUM(CASE WHEN city = 'Toronto' THEN 1 ELSE 0 END) as TEXT) FROM Instructor
UNION ALL
SELECT 'Canadian Instructors', CAST(SUM(CASE WHEN country = 'CA' THEN 1 ELSE 0 END) as TEXT) FROM Instructor
UNION ALL
SELECT 'Cities with Multiple Instructors', CAST(COUNT(*) as TEXT) FROM (
    SELECT city FROM Instructor GROUP BY city HAVING COUNT(*) > 1
) as multi_city
UNION ALL
SELECT 'Recent Relocations', '4 (Antonio, Steve, Ramesh, Sandip)';

-- 13. Export for HR/management reporting
SELECT 
    ins_id as "Employee ID",
    lastname as "Last Name",
    firstname as "First Name",
    city as "Current Location",
    CASE country
        WHEN 'CA' THEN 'Canada'
        WHEN 'GB' THEN 'United Kingdom'
        WHEN 'IN' THEN 'India'
        WHEN 'AU' THEN 'Australia'
        WHEN 'BD' THEN 'Bangladesh'
        ELSE country
    END as "Country",
    CASE 
        WHEN ins_id = 4 THEN 'Relocated from Edmonton to Toronto'
        WHEN ins_id = 7 THEN 'Relocated from Vancouver to Toronto'
        WHEN ins_id = 8 THEN 'Relocated from Barlby to London'
        WHEN ins_id = 9 THEN 'Relocated from Hyderabad to Bangalore'
        ELSE 'No recent relocation'
    END as "Relocation Status",
    CASE 
        WHEN city = 'Toronto' THEN 'GTA Office'
        WHEN city = 'London' THEN 'UK Office'
        WHEN city = 'Bangalore' THEN 'India Office'
        ELSE 'Remote/Other'
    END as "Office Designation"
FROM Instructor
ORDER BY "Country", lastname;

-- 14. Lessons learned from this UPDATE:
-- 1. UPDATE with WHERE clause can affect multiple records
-- 2. Using non-unique criteria (firstname) can have unintended consequences
-- 3. Always test UPDATE with SELECT first
-- 4. Consider using primary key for precise updates
-- 5. Backup data before bulk updates

-- 15. Best practice: Test UPDATE with SELECT first
-- Before running: UPDATE Instructor SET city='Toronto' WHERE firstname="Sandip"
-- First run:
SELECT * FROM Instructor WHERE firstname = 'Sandip';
-- Review which records will be affected
-- Then run the UPDATE if correct

-- 16. Alternative: UPDATE with JOIN for complex conditions
-- If we wanted to move all instructors from Edmonton to Toronto:
/*
UPDATE Instructor
SET city = 'Toronto'
WHERE city = 'Edmonton';
*/

-- 17. Final verification of data integrity
SELECT 
    CASE 
        WHEN COUNT(DISTINCT ins_id) = COUNT(*) THEN '✅ All IDs unique'
        ELSE '❌ Duplicate IDs found'
    END as ID_Check,
    CASE 
        WHEN COUNT(*) = 0 THEN '✅ No empty names'
        ELSE '❌ Found empty names'
    END as Name_Check,
    CASE 
        WHEN SUM(CASE WHEN city = '' OR country = '' THEN 1 ELSE 0 END) = 0 THEN '✅ All locations complete'
        ELSE '❌ Incomplete locations'
    END as Location_Check
FROM Instructor;

-- 18. Complete instructor timeline with all changes
SELECT 
    ins_id as ID,
    lastname || ', ' || firstname as Name,
    city as Current_Location,
    CASE 
        WHEN ins_id = 4 THEN 'Edmonton → Toronto'
        WHEN ins_id = 7 THEN 'Vancouver → Toronto'
        WHEN ins_id = 8 THEN 'Barlby → London'
        WHEN ins_id = 9 THEN 'Hyderabad → Bangalore'
        ELSE 'Original location'
    END as Relocation_History,
    CASE 
        WHEN ins_id IN (4, 7, 8, 9) THEN 'Recently updated'
        ELSE 'Stable'
    END as Status
FROM Instructor
ORDER BY ins_id;

-- 19. Final state confirmation
SELECT * FROM Instructor ORDER BY ins_id;