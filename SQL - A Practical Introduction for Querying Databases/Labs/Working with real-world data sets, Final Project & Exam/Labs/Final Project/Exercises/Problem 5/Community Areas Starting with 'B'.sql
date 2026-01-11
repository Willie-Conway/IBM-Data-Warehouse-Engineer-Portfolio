-- Purpose: Filter and categorize community areas alphabetically
SELECT DISTINCT community_area_name
FROM chicago_socioeconomic_data
WHERE community_area_name LIKE 'B%';