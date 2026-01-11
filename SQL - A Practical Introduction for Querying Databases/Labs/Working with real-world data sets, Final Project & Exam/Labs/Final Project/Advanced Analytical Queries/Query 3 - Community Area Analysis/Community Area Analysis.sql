-- Comprehensive community area profile
SELECT 
    csd.community_area_name,
    csd.hardship_index,
    csd.per_capita_income,
    COUNT(DISTINCT cps.name_of_school) as total_schools,
    ROUND(AVG(cps.safety_score), 1) as avg_school_safety,
    COUNT(cc.case_number) as total_crimes,
    ROUND(COUNT(CASE WHEN cc.arrest = TRUE THEN 1 END) * 100.0 / COUNT(cc.case_number), 1) as arrest_rate_percent
FROM chicago_socioeconomic_data csd
LEFT JOIN chicago_public_schools cps 
    ON csd.community_area_number = cps.community_area_number
LEFT JOIN chicago_crime cc 
    ON csd.community_area_number = cc.community_area
GROUP BY csd.community_area_name, csd.hardship_index, csd.per_capita_income
ORDER BY csd.hardship_index DESC;