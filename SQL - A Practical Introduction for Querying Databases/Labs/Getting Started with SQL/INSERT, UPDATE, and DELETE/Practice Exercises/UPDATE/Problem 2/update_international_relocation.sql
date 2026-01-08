-- Practice SQL
-- Database: Instructors

-- Query 1: Update instructor's city and country using primary key
UPDATE Instructor 
SET city = 'Dhaka', country = 'BD' 
WHERE ins_id = 4;

-- Query 2: View all instructor records after the update
SELECT * FROM Instructor;

/*
Final Output after UPDATE operation:
+--------+-----------+-----------+-------------+---------+
| ins_id | lastname  | firstname | city        | country |
+--------+-----------+-----------+-------------+---------+
|      1 | Ahuja     | Rav       | Markham     | CA      |
|      2 | Chong     | Raul      | Toronto     | CA      |
|      4 | Saha      | Sandip    | Dhaka       | BD      |  <-- UPDATED
|      5 | Doe       | John      | Dubai       | AE      |
|      6 | Doe       | Jane      | Dhaka       | BD      |
|      7 | Cangiano  | Tony      | Toronto     | CA      |
|      8 | Ryan      | Steven    | London      | GB      |
|      9 | Sannareddy| Ram       | Bangalore   | IN      |
+--------+-----------+-----------+-------------+---------+
(8 instructors total)

What happened:
1. UPDATE statement modified the record WHERE ins_id = 4
2. Only one instructor matches: Sandip Saha (ins_id=4)
3. City changed from Toronto to Dhaka
4. Country changed from CA (Canada) to BD (Bangladesh)
5. Significant international relocation

Previous state:
ins_id=4 | Saha | Sandip | Toronto | CA

Current state:
ins_id=4 | Saha | Sandip | Dhaka | BD
*/

-- File name: update_international_relocation.sql

-- Comprehensive analysis of the international relocation:

-- 1. Verify the specific change
SELECT * FROM Instructor WHERE ins_id = 4;
/*
Returns: 4 | Saha | Sandip | Dhaka | BD
*/

-- 2. Track the international move
WITH RelocationHistory AS (
    SELECT 
        4 as ins_id,
        'Saha' as lastname,
        'Sandip' as firstname,
        'Toronto' as from_city,
        'CA' as from_country,
        'Dhaka' as to_city,
        'BD' as to_country
)
SELECT 
    r.ins_id as ID,
    r.lastname || ', ' || r.firstname as Name,
    r.from_city || ', ' || 
    CASE r.from_country 
        WHEN 'CA' THEN 'Canada' 
        ELSE r.from_country 
    END as From_Location,
    r.to_city || ', ' || 
    CASE r.to_country 
        WHEN 'BD' THEN 'Bangladesh' 
        ELSE r.to_country 
    END as To_Location,
    'International Relocation' as Move_Type,
    CASE 
        WHEN r.from_country = 'CA' AND r.to_country = 'BD' THEN 'North America → South Asia'
        ELSE 'Cross-regional move'
    END as Region_Change
FROM RelocationHistory r;

-- 3. Dhaka now has two instructors
SELECT * FROM Instructor WHERE city = 'Dhaka' ORDER BY lastname;
/*
Returns:
4 | Saha | Sandip | Dhaka | BD
6 | Doe | Jane | Dhaka | BD

Dhaka now has 2 instructors:
1. Jane Doe (already there)
2. Sandip Saha (newly relocated)
*/

-- 4. Geographic distribution update
SELECT 
    country,
    COUNT(*) as InstructorCount,
    GROUP_CONCAT(city || ' (' || firstname || ' ' || lastname || ')' ORDER BY city, lastname) as Instructors
FROM Instructor
GROUP BY country
ORDER BY InstructorCount DESC;
/*
Now shows:
CA: 3 (Markham (Rav Ahuja), Toronto (Raul Chong), Toronto (Tony Cangiano))
BD: 2 (Dhaka (Jane Doe), Dhaka (Sandip Saha))  <-- Increased from 1 to 2
AE: 1 (Dubai (John Doe))
GB: 1 (London (Steven Ryan))
IN: 1 (Bangalore (Ram Sannareddy))
*/

-- 5. Family/surname analysis in Dhaka
SELECT 
    lastname,
    COUNT(*) as Count,
    GROUP_CONCAT(firstname ORDER BY firstname) as FirstNames
FROM Instructor 
WHERE city = 'Dhaka'
GROUP BY lastname;
/*
Shows:
Doe: 1 (Jane)
Saha: 1 (Sandip)

Two different families in Dhaka
*/

-- 6. Bangladesh representation analysis
SELECT 
    'Bangladesh Instructors' as Category,
    COUNT(*) as Count,
    GROUP_CONCAT(firstname || ' ' || lastname ORDER BY lastname) as Names,
    'Dhaka' as City,
    '100% of BD instructors in capital' as Note
FROM Instructor 
WHERE country = 'BD';
/*
Bangladesh now has 2 instructors, both in Dhaka
*/

-- 7. Canadian instructors after departure
SELECT * FROM Instructor WHERE country = 'CA' ORDER BY city, lastname;
/*
Now 3 Canadian instructors:
1. Rav Ahuja (Markham)
2. Raul Chong (Toronto)
3. Tony Cangiano (Toronto)

Sandip Saha moved from Toronto to Dhaka
*/

-- 8. Timezone implications
SELECT 
    firstname || ' ' || lastname as Instructor,
    city || ', ' || 
    CASE country
        WHEN 'BD' THEN 'Bangladesh'
        WHEN 'CA' THEN 'Canada'
        WHEN 'AE' THEN 'UAE'
        WHEN 'GB' THEN 'UK'
        WHEN 'IN' THEN 'India'
        ELSE country
    END as Location,
    CASE 
        WHEN city = 'Dhaka' THEN 'BST (UTC+6)'
        WHEN city = 'Toronto' THEN 'EST (UTC-5)'
        WHEN city = 'Markham' THEN 'EST (UTC-5)'
        WHEN city = 'Dubai' THEN 'GST (UTC+4)'
        WHEN city = 'London' THEN 'GMT (UTC+0)'
        WHEN city = 'Bangalore' THEN 'IST (UTC+5:30)'
        ELSE 'Check timezone'
    END as Timezone,
    CASE 
        WHEN ins_id = 4 THEN '11 hour time difference from Toronto'
        ELSE 'Normal office hours'
    END as Timezone_Note
FROM Instructor
ORDER BY 
    CASE 
        WHEN country = 'BD' THEN 1  -- Focus on updated country
        WHEN country = 'CA' THEN 2
        WHEN country = 'AE' THEN 3
        WHEN country = 'GB' THEN 4
        WHEN country = 'IN' THEN 5
        ELSE 6
    END;

-- 9. Impact on regional diversity
WITH RegionalAnalysis AS (
    SELECT 
        CASE 
            WHEN country IN ('BD', 'IN', 'PK', 'LK') THEN 'South Asia'
            WHEN country IN ('AE', 'SA', 'QA') THEN 'Middle East'
            WHEN country IN ('CA', 'US') THEN 'North America'
            WHEN country IN ('GB', 'EU') THEN 'Europe'
            WHEN country IN ('AU', 'NZ') THEN 'Oceania'
            ELSE 'Other'
        END as Region,
        COUNT(*) as InstructorCount
    FROM Instructor
    GROUP BY 
        CASE 
            WHEN country IN ('BD', 'IN', 'PK', 'LK') THEN 'South Asia'
            WHEN country IN ('AE', 'SA', 'QA') THEN 'Middle East'
            WHEN country IN ('CA', 'US') THEN 'North America'
            WHEN country IN ('GB', 'EU') THEN 'Europe'
            WHEN country IN ('AU', 'NZ') THEN 'Oceania'
            ELSE 'Other'
        END
)
SELECT 
    Region,
    InstructorCount,
    ROUND(InstructorCount * 100.0 / SUM(InstructorCount) OVER(), 1) as Percentage,
    CASE 
        WHEN Region = 'South Asia' AND InstructorCount > 1 THEN '✅ Growing region'
        WHEN InstructorCount = 1 THEN '⚠️ Single representative'
        ELSE '📊 Stable'
    END as Status
FROM RegionalAnalysis
ORDER BY InstructorCount DESC;
/*
Shows regional distribution with South Asia now having 3 instructors
*/

-- 10. Create comprehensive instructor directory
SELECT 
    ins_id as ID,
    UPPER(lastname) || ', ' || INITCAP(firstname) as Name,
    CASE 
        WHEN ins_id = 4 THEN '🌏 ' || city || ' (recently relocated from Toronto)'
        WHEN city = 'Dhaka' THEN '🏙 ' || city || ' (capital city)'
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
        WHEN country = 'BD' THEN 'South Asia Region'
        WHEN country = 'CA' THEN 'North America Region'
        WHEN country = 'AE' THEN 'Middle East Region'
        WHEN country = 'GB' THEN 'Europe Region'
        WHEN country = 'IN' THEN 'South Asia Region'
        ELSE 'Global'
    END as Business_Region
FROM Instructor
ORDER BY 
    CASE 
        WHEN country = 'BD' THEN 1  -- Highlight updated country
        WHEN country = 'CA' THEN 2
        WHEN country = 'AE' THEN 3
        WHEN country = 'GB' THEN 4
        WHEN country = 'IN' THEN 5
        ELSE 6
    END,
    lastname;

-- 11. Data validation after international move
-- Check for any business rule violations
SELECT 
    'Business Rule Compliance Check' as Check_Type,
    '' as Result
UNION ALL
SELECT 'Maximum instructors per city (example: 3)',
    CASE 
        WHEN MAX(city_count) <= 3 THEN '✅ Within limits'
        ELSE '❌ Exceeds limit'
    END
FROM (
    SELECT city, COUNT(*) as city_count 
    FROM Instructor 
    GROUP BY city
) as city_counts
UNION ALL
SELECT 'Minimum instructors per region',
    CASE 
        WHEN COUNT(*) >= 3 THEN '✅ Good coverage'
        ELSE '⚠️ Needs more representation'
    END
FROM (
    SELECT 
        CASE 
            WHEN country IN ('BD', 'IN') THEN 'South Asia'
            WHEN country = 'CA' THEN 'North America'
            WHEN country = 'AE' THEN 'Middle East'
            WHEN country = 'GB' THEN 'Europe'
            ELSE 'Other'
        END as region
    FROM Instructor
    GROUP BY 
        CASE 
            WHEN country IN ('BD', 'IN') THEN 'South Asia'
            WHEN country = 'CA' THEN 'North America'
            WHEN country = 'AE' THEN 'Middle East'
            WHEN country = 'GB' THEN 'Europe'
            ELSE 'Other'
        END
    HAVING COUNT(*) >= 2
) as region_coverage;

-- 12. Statistical summary after relocation
SELECT 
    'Post-Relocation Statistics' as Metric,
    '' as Value
UNION ALL
SELECT 'Total Instructors', CAST(COUNT(*) as TEXT) FROM Instructor
UNION ALL
SELECT 'Instructors in Bangladesh', CAST(SUM(CASE WHEN country = 'BD' THEN 1 ELSE 0 END) as TEXT) FROM Instructor
UNION ALL
SELECT 'Instructors in Dhaka', CAST(SUM(CASE WHEN city = 'Dhaka' THEN 1 ELSE 0 END) as TEXT) FROM Instructor
UNION ALL
SELECT 'Canadian Instructors', CAST(SUM(CASE WHEN country = 'CA' THEN 1 ELSE 0 END) as TEXT) FROM Instructor
UNION ALL
SELECT 'South Asian Instructors', CAST(SUM(CASE WHEN country IN ('BD', 'IN') THEN 1 ELSE 0 END) as TEXT) FROM Instructor
UNION ALL
SELECT 'International Relocations Today', '1 (Sandip: Canada → Bangladesh)';

-- 13. Export for HR and management reporting
SELECT 
    ins_id as "Employee_ID",
    lastname as "Last_Name",
    firstname as "First_Name",
    city as "Current_City",
    CASE country
        WHEN 'BD' THEN 'Bangladesh'
        WHEN 'CA' THEN 'Canada'
        WHEN 'AE' THEN 'United Arab Emirates'
        WHEN 'GB' THEN 'United Kingdom'
        WHEN 'IN' THEN 'India'
        ELSE country
    END as "Country",
    CASE 
        WHEN ins_id = 4 THEN 'INTERNATIONAL TRANSFER: Toronto → Dhaka'
        WHEN ins_id IN (5, 7, 8, 9) THEN 'Recently relocated'
        ELSE 'Stable assignment'
    END as "Assignment_Status",
    CASE 
        WHEN country = 'BD' THEN 'South Asia Operations'
        WHEN country = 'CA' THEN 'North America Operations'
        WHEN country = 'AE' THEN 'Middle East Operations'
        WHEN country = 'GB' THEN 'European Operations'
        WHEN country = 'IN' THEN 'India Operations'
        ELSE 'Global Operations'
    END as "Operations_Unit"
FROM Instructor
ORDER BY 
    CASE 
        WHEN ins_id = 4 THEN 1  -- Most recent change first
        ELSE 2
    END,
    "Country",
    lastname;

-- 14. Lessons from this international UPDATE:
-- 1. Primary key updates are precise and safe
-- 2. International relocations impact regional diversity stats
-- 3. Consider timezone implications for team coordination
-- 4. Update business analytics after significant location changes
-- 5. Verify business rules still apply after relocation

-- 15. Example of comprehensive update with validation
-- Before international transfer, check:
-- 1. Target country business rules
-- 2. Timezone impact on team
-- 3. Regional representation balance

/*
-- Sample validation before update
DECLARE @target_city VARCHAR(50) = 'Dhaka';
DECLARE @target_country VARCHAR(2) = 'BD';
DECLARE @instructor_id INT = 4;

-- Check if target city already has too many instructors
IF (SELECT COUNT(*) FROM Instructor WHERE city = @target_city) < 3  -- Example limit
BEGIN
    -- Check if instructor exists
    IF EXISTS (SELECT 1 FROM Instructor WHERE ins_id = @instructor_id)
    BEGIN
        -- Perform the update
        UPDATE Instructor 
        SET city = @target_city, 
            country = @target_country,
            relocation_date = GETDATE()
        WHERE ins_id = @instructor_id;
        
        PRINT 'International transfer completed successfully';
    END
    ELSE
    BEGIN
        PRINT 'Instructor not found';
    END
END
ELSE
BEGIN
    PRINT 'Target city at capacity, transfer denied';
END
*/

-- 16. Dhaka office capacity analysis
SELECT 
    city,
    country,
    COUNT(*) as current_instructors,
    CASE 
        WHEN COUNT(*) >= 3 THEN 'At capacity'
        WHEN COUNT(*) = 2 THEN 'Has space'
        ELSE 'Underutilized'
    END as capacity_status
FROM Instructor
WHERE city = 'Dhaka'
GROUP BY city, country;

-- 17. Complete relocation history
SELECT 
    ins_id as ID,
    lastname || ', ' || firstname as Name,
    city || ', ' || country as Current_Location,
    CASE 
        WHEN ins_id = 4 THEN 'Toronto, CA → Dhaka, BD'
        WHEN ins_id = 5 THEN 'Sydney, AU → Dubai, AE'
        WHEN ins_id = 7 THEN 'Vancouver, CA → Toronto, CA'
        WHEN ins_id = 8 THEN 'Barlby, GB → London, GB'
        WHEN ins_id = 9 THEN 'Hyderabad, IN → Bangalore, IN'
        ELSE 'Original assignment'
    END as Relocation_History,
    CASE 
        WHEN ins_id IN (4, 5) THEN 'International Transfer'
        WHEN ins_id IN (7, 8, 9) THEN 'Domestic/Regional Move'
        ELSE 'No moves'
    END as Move_Type
FROM Instructor
ORDER BY 
    CASE 
        WHEN ins_id = 4 THEN 1  -- Most recent
        WHEN ins_id = 5 THEN 2
        WHEN ins_id IN (7, 8, 9) THEN 3
        ELSE 4
    END;

-- 18. Final data integrity verification
WITH DataQuality AS (
    SELECT 
        COUNT(DISTINCT ins_id) as unique_ids,
        COUNT(*) as total_rows,
        SUM(CASE WHEN country IN ('BD', 'CA', 'AE', 'GB', 'IN') THEN 1 ELSE 0 END) as valid_countries,
        COUNT(DISTINCT country) as country_count
    FROM Instructor
)
SELECT 
    CASE WHEN unique_ids = total_rows THEN '✅' ELSE '❌' END || ' All IDs unique' as ID_Check,
    CASE WHEN valid_countries = total_rows THEN '✅' ELSE '❌' END || ' Valid country codes' as Country_Check,
    CASE WHEN country_count >= 4 THEN '✅' ELSE '⚠️' END || ' Good diversity (' || country_count || ' countries)' as Diversity_Check
FROM DataQuality;

-- 19. Final state confirmation
SELECT * FROM Instructor ORDER BY ins_id;