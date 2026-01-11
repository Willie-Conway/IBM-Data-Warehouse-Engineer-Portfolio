-- Purpose: Identify health-focused schools in specific community areas
SELECT name_of_school, community_area_number
FROM chicago_public_schools
WHERE community_area_number BETWEEN 10 AND 15
  AND healthy_school_certified = TRUE;