-- Purpose: Explore relationship between school safety and community wealth
SELECT csd.per_capita_income
FROM chicago_socioeconomic_data csd
WHERE csd.community_area_number = (
    SELECT community_area_number
    FROM chicago_public_schools
    WHERE safety_score = 1
    LIMIT 1
);