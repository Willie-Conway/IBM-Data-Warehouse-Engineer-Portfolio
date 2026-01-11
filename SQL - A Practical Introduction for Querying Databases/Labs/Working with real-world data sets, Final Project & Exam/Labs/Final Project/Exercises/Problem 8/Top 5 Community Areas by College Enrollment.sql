-- Purpose: Identify areas with highest educational attainment
SELECT community_area_name, 
       AVG(college_enrollment) AS avg_college_enrollment
FROM chicago_public_schools
WHERE college_enrollment IS NOT NULL
GROUP BY community_area_name
ORDER BY avg_college_enrollment DESC
LIMIT 5;