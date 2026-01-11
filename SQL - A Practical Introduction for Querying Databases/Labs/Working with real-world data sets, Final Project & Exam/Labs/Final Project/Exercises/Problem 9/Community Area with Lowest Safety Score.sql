-- Purpose: Identify the community area needing most safety intervention
SELECT community_area_name
FROM chicago_public_schools
WHERE safety_score = (
    SELECT MIN(safety_score)
    FROM chicago_public_schools
    WHERE safety_score IS NOT NULL
);