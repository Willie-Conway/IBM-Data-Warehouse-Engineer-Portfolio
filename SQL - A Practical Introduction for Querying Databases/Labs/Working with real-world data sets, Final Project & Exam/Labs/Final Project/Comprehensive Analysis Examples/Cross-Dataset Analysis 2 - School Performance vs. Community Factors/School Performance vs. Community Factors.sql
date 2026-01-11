-- Analyze school safety in relation to community characteristics
SELECT 
    cps.name_of_school,
    cps.safety_score,
    csd.community_area_name,
    csd.hardship_index,
    csd.per_capita_income,
    csd.percent_households_below_poverty
FROM chicago_public_schools cps
JOIN chicago_socioeconomic_data csd
    ON cps.community_area_number = csd.community_area_number
WHERE cps.safety_score IS NOT NULL
ORDER BY cps.safety_score DESC;