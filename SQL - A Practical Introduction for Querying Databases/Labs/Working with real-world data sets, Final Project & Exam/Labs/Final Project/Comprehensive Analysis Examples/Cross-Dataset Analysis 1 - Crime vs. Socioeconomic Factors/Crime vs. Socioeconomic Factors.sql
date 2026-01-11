-- Compare crime rates with hardship index
SELECT 
    cc.community_area,
    csd.community_area_name,
    COUNT(cc.case_number) as crime_count,
    csd.hardship_index,
    csd.per_capita_income
FROM chicago_crime cc
JOIN chicago_socioeconomic_data csd 
    ON cc.community_area = csd.community_area_number
GROUP BY cc.community_area, csd.community_area_name, 
         csd.hardship_index, csd.per_capita_income
ORDER BY crime_count DESC;