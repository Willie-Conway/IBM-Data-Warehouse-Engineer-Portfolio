-- Purpose: Identify specific crime patterns at vulnerable locations
SELECT DISTINCT primary_type
FROM chicago_crime
WHERE LOWER(location_description) LIKE '%gas station%';