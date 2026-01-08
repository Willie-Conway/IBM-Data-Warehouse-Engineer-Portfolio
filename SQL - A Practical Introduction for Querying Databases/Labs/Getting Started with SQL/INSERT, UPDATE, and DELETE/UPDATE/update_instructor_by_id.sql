-- Practice SQL
-- Database: Instructors

-- Query 1: Update instructor's city and country using primary key
UPDATE Instructor 
SET city = 'Dubai', country = 'AE' 
WHERE ins_id = 5;

-- Query 2: View all instructor records after the update
SELECT * FROM Instructor;

/*
Final Output after UPDATE operation:
+--------+-----------+-----------+-------------+---------+
| ins_id | lastname  | firstname | city        | country |
+--------+-----------+-----------+-------------+---------+
|      1 | Ahuja     | Rav       | Markham     | CA      |
|      2 | Chong     | Raul      | Toronto     | CA      |
|      4 | Saha      | Sandip    | Toronto     | CA      |
|      5 | Doe       | John      | Dubai       | AE      |  <-- UPDATED
|      6 | Doe       | Jane      | Dhaka       | BD      |
|      7 | Cangiano  | Tony      | Toronto     | CA      |
|      8 | Ryan      | Steven    | London      | GB      |
|      9 | Sannareddy| Ram       | Bangalore   | IN      |
+--------+-----------+-----------+-------------+---------+
(8 instructors total)

What happened:
1. UPDATE statement modified the record WHERE ins_id = 5
2. Only one instructor matches: John Doe (ins_id=5)
3. City changed from Sydney to Dubai
4. Country changed from AU (Australia) to AE (United Arab Emirates)
5. All other records unchanged

Previous state:
ins_id=5 | Doe | John | Sydney | AU

Current state:
ins_id=5 | Doe | John | Dubai | AE
*/

-- File name: update_instructor_by_id.sql

-- Comprehensive analysis of the UPDATE operation:

-- 1. Verify the specific change
SELECT * FROM Instructor WHERE ins_id = 5;
/*
Returns: 5 | Doe | John | Dubai | AE
*/

-- 2. Track the change history (simulated)
WITH ChangeHistory AS (
    SELECT 5 as ins_id, 'Doe' as lastname, 'John' as firstname, 'Sydney' as old_city, 'AU' as old_country, 'Dubai' as new_city, 'AE' as new_country
)
SELECT 
    c.ins_id as ID,
    c.lastname || ', ' || c.firstname as Name,
    c.old_city || ', ' || c.old_country as Previous_Location,
    c.new_city || ', ' || c.new_country as Current_Location,
    CASE 
        WHEN c.old_country != c.new_country THEN 'International relocation'
        ELSE 'Domestic move'
    END as Move_Type
FROM ChangeHistory c;

-- 3. Geographic distribution update
SELECT 
    country,
    COUNT(*) as InstructorCount,
    GROUP_CONCAT(city || ' (' || firstname || ' ' || lastname || ')' ORDER BY city) as Instructors
FROM Instructor
GROUP BY country
ORDER BY InstructorCount DESC;
/*
Now shows:
CA: 4 (Markham (Rav Ahuja), Toronto (Sandip Saha), Toronto (Raul Chong), Toronto (Tony Cangiano))
AE: 1 (Dubai (John Doe))
BD: 1 (Dhaka (Jane Doe))
GB: 1 (London (Steven Ryan))
IN: 1 (Bangalore (Ram Sannareddy))
AU: 0 (previously had John Doe)
*/

-- 4. Middle East representation analysis
SELECT * FROM Instructor WHERE country = 'AE';
/*
Returns: John Doe in Dubai, UAE
First instructor in the Middle East region
*/

-- 5. Doe family distribution
SELECT * FROM Instructor WHERE lastname = 'Doe' ORDER BY ins_id;
/*
Shows:
5 | Doe | John | Dubai | AE (Middle East)
6 | Doe | Jane | Dhaka | BD (South Asia)
The Doe siblings are now in different regions
*/

-- 6. Timezone considerations
SELECT 
    firstname || ' ' || lastname as Instructor,
    city || ', ' || 
    CASE country
        WHEN 'AE' THEN 'UAE'
        WHEN 'CA' THEN 'Canada'
        WHEN 'BD' THEN 'Bangladesh'
        WHEN 'GB' THEN 'UK'
        WHEN 'IN' THEN 'India'
        ELSE country
    END as Location,
    CASE 
        WHEN city = 'Dubai' THEN 'GST (UTC+4)'
        WHEN city = 'Dhaka' THEN 'BST (UTC+6)'
        WHEN city = 'London' THEN 'GMT (UTC+0)'
        WHEN city = 'Bangalore' THEN 'IST (UTC+5:30)'
        WHEN city = 'Toronto' THEN 'EST (UTC-5)'
        WHEN city = 'Markham' THEN 'EST (UTC-5)'
        WHEN city = 'Sydney' THEN 'AEST (UTC+10)'
        ELSE 'Check timezone'
    END as Timezone
FROM Instructor
ORDER BY 
    CASE country
        WHEN 'AE' THEN 1
        WHEN 'BD' THEN 2
        WHEN 'IN' THEN 3
        WHEN 'GB' THEN 4
        WHEN 'CA' THEN 5
        ELSE 6
    END;

-- 7. Update impact on regional diversity
WITH RegionalAnalysis AS (
    SELECT 
        CASE 
            WHEN country IN ('AE', 'SA', 'QA') THEN 'Middle East'
            WHEN country IN ('IN', 'BD', 'PK', 'LK') THEN 'South Asia'
            WHEN country IN ('CA', 'US', 'MX') THEN 'North America'
            WHEN country IN ('GB', 'FR', 'DE', 'ES') THEN 'Europe'
            WHEN country IN ('AU', 'NZ') THEN 'Oceania'
            ELSE 'Other'
        END as Region,
        COUNT(*) as InstructorCount
    FROM Instructor
    GROUP BY 
        CASE 
            WHEN country IN ('AE', 'SA', 'QA') THEN 'Middle East'
            WHEN country IN ('IN', 'BD', 'PK', 'LK') THEN 'South Asia'
            WHEN country IN ('CA', 'US', 'MX') THEN 'North America'
            WHEN country IN ('GB', 'FR', 'DE', 'ES') THEN 'Europe'
            WHEN country IN ('AU', 'NZ') THEN 'Oceania'
            ELSE 'Other'
        END
)
SELECT 
    Region,
    InstructorCount,
    ROUND(InstructorCount * 100.0 / SUM(InstructorCount) OVER(), 1) as Percentage
FROM RegionalAnalysis
ORDER BY InstructorCount DESC;
/*
Shows regional diversity percentages
*/

-- 8. Best practice: Using primary key for updates
-- This is the CORRECT way to update a specific record:
-- WHERE ins_id = 5 (primary key) ensures only one record is updated
-- Much safer than: WHERE firstname = 'John' (could match multiple)

-- 9. What if we used a non-unique condition?
-- Example of risky update:
UPDATE Instructor 
SET city = 'TestCity'
WHERE firstname = 'John';
-- This would update ALL instructors named John

-- 10. Create comprehensive instructor directory
SELECT 
    ins_id as ID,
    UPPER(lastname) || ', ' || INITCAP(firstname) as Name,
    CASE 
        WHEN ins_id = 5 THEN '🌇 ' || city || ' (relocated from Sydney)'
        ELSE city
    END as City,
    CASE country
        WHEN 'AE' THEN '🇦🇪 United Arab Emirates'
        WHEN 'CA' THEN '🇨🇦 Canada'
        WHEN 'BD' THEN '🇧🇩 Bangladesh'
        WHEN 'GB' THEN '🇬🇧 United Kingdom'
        WHEN 'IN' THEN '🇮🇳 India'
        ELSE '🏳 ' || country
    END as Country,
    CASE 
        WHEN country = 'AE' THEN 'Middle East Office'
        WHEN city = 'Toronto' THEN 'Toronto Office'
        WHEN city = 'London' THEN 'London Office'
        WHEN city = 'Bangalore' THEN 'Bangalore Office'
        ELSE 'Remote/Other Location'
    END as Office_Designation
FROM Instructor
ORDER BY 
    CASE 
        WHEN country = 'AE' THEN 1  -- UAE first (newest update)
        WHEN country = 'CA' THEN 2
        WHEN country = 'BD' THEN 3
        WHEN country = 'GB' THEN 4
        WHEN country = 'IN' THEN 5
        ELSE 6
    END,
    lastname;

-- 11. Data validation after update
-- Check for any data inconsistencies
SELECT 
    'Data Validation Results' as Check_Type,
    '' as Result
UNION ALL
SELECT 'Unique IDs', 
    CASE WHEN COUNT(DISTINCT ins_id) = COUNT(*) THEN '✅ Pass' ELSE '❌ Fail' END
FROM Instructor
UNION ALL
SELECT 'Complete Location Data',
    CASE WHEN COUNT(*) = SUM(CASE WHEN city != '' AND country != '' THEN 1 ELSE 0 END) THEN '✅ Pass' ELSE '❌ Fail' END
FROM Instructor
UNION ALL
SELECT 'Valid Country Codes',
    CASE WHEN COUNT(*) = SUM(CASE WHEN country IN ('CA', 'AE', 'BD', 'GB', 'IN', 'AU') THEN 1 ELSE 0 END) THEN '✅ Pass' ELSE '❌ Fail' END
FROM Instructor
UNION ALL
SELECT 'No Duplicate Full Names',
    CASE WHEN COUNT(*) = COUNT(DISTINCT lastname || firstname) THEN '✅ Pass' ELSE '❌ Fail' END
FROM Instructor;

-- 12. Statistical summary
SELECT 
    'Post-Update Statistics' as Metric,
    '' as Value
UNION ALL
SELECT 'Total Instructors', CAST(COUNT(*) as TEXT) FROM Instructor
UNION ALL
SELECT 'Countries Represented', CAST(COUNT(DISTINCT country) as TEXT) FROM Instructor
UNION ALL
SELECT 'Instructors in UAE', CAST(SUM(CASE WHEN country = 'AE' THEN 1 ELSE 0 END) as TEXT) FROM Instructor
UNION ALL
SELECT 'Instructors in Middle East', CAST(SUM(CASE WHEN country IN ('AE', 'SA', 'QA', 'OM') THEN 1 ELSE 0 END) as TEXT) FROM Instructor
UNION ALL
SELECT 'Doe Family Members', CAST(SUM(CASE WHEN lastname = 'Doe' THEN 1 ELSE 0 END) as TEXT) FROM Instructor
UNION ALL
SELECT 'Recent International Moves', '1 (John: Australia → UAE)';

-- 13. Export for management reporting
SELECT 
    ins_id as "Employee_ID",
    lastname as "Last_Name",
    firstname as "First_Name",
    city as "Current_City",
    CASE country
        WHEN 'AE' THEN 'United Arab Emirates'
        WHEN 'CA' THEN 'Canada'
        WHEN 'BD' THEN 'Bangladesh'
        WHEN 'GB' THEN 'United Kingdom'
        WHEN 'IN' THEN 'India'
        ELSE country
    END as "Country",
    CASE 
        WHEN ins_id = 5 THEN 'Recently transferred to Dubai office'
        WHEN ins_id IN (4, 7, 8, 9) THEN 'Recently relocated'
        ELSE 'Stable location'
    END as "Location_Status",
    CASE 
        WHEN country = 'AE' THEN 'Middle East Region'
        WHEN country IN ('CA', 'US', 'MX') THEN 'Americas Region'
        WHEN country IN ('GB', 'EU') THEN 'Europe Region'
        WHEN country IN ('IN', 'BD', 'PK') THEN 'South Asia Region'
        WHEN country IN ('AU', 'NZ') THEN 'APAC Region'
        ELSE 'Global'
    END as "Business_Region"
FROM Instructor
ORDER BY "Business_Region", "Country", lastname;

-- 14. Lessons from this UPDATE operation:
-- 1. Using primary key (ins_id) is the safest way to update specific records
-- 2. Can update multiple columns in one statement (city and country)
-- 3. Always verify which records will be affected (use SELECT with WHERE first)
-- 4. Consider the business impact of location changes
-- 5. Maintain regional diversity analytics

-- 15. Example of testing before updating
-- Best practice workflow:
-- Step 1: Check what will be affected
SELECT * FROM Instructor WHERE ins_id = 5;
-- Returns: John Doe in Sydney, AU

-- Step 2: Plan the update
-- We want to move John from Sydney to Dubai

-- Step 3: Execute the update
UPDATE Instructor 
SET city = 'Dubai', country = 'AE' 
WHERE ins_id = 5;

-- Step 4: Verify the change
SELECT * FROM Instructor WHERE ins_id = 5;
-- Returns: John Doe in Dubai, AE

-- 16. What if update affects business rules?
-- Example rule: Maximum 1 instructor per Middle Eastern country
SELECT 
    country,
    COUNT(*) as InstructorCount
FROM Instructor 
WHERE country IN ('AE', 'SA', 'QA', 'OM', 'KW')
GROUP BY country
HAVING COUNT(*) > 1;
-- Should return 0 rows if rule is enforced

-- 17. Complete change history tracking
SELECT 
    ins_id as ID,
    lastname || ', ' || firstname as Name,
    city || ', ' || country as Current_Location,
    CASE 
        WHEN ins_id = 5 THEN 'Australia → UAE'
        WHEN ins_id = 7 THEN 'Canada West → Canada East'
        WHEN ins_id = 8 THEN 'UK Countryside → London'
        WHEN ins_id = 9 THEN 'South India → Tech Hub'
        WHEN ins_id = 4 THEN 'Western Canada → Toronto'
        ELSE 'No recent move'
    END as Relocation_Summary
FROM Instructor
ORDER BY 
    CASE 
        WHEN ins_id = 5 THEN 1  -- Most recent
        WHEN ins_id IN (4, 7, 8, 9) THEN 2  -- Other recent moves
        ELSE 3
    END;

-- 18. Final data integrity check
WITH IntegrityChecks AS (
    SELECT 
        COUNT(DISTINCT ins_id) as unique_ids,
        COUNT(*) as total_rows,
        SUM(CASE WHEN city = '' OR country = '' THEN 1 ELSE 0 END) as incomplete_locations,
        COUNT(DISTINCT country) as unique_countries
    FROM Instructor
)
SELECT 
    CASE WHEN unique_ids = total_rows THEN '✅' ELSE '❌' END || ' All IDs unique' as Check1,
    CASE WHEN incomplete_locations = 0 THEN '✅' ELSE '❌' END || ' All locations complete' as Check2,
    CASE WHEN unique_countries >= 3 THEN '✅' ELSE '❌' END || ' Good geographic diversity (' || unique_countries || ' countries)' as Check3
FROM IntegrityChecks;

-- 19. Final state confirmation
SELECT * FROM Instructor ORDER BY ins_id;