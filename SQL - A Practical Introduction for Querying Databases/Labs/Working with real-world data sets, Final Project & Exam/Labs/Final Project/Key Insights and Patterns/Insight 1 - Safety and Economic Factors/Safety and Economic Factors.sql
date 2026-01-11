-- Correlation between school safety and community wealth
SELECT 
    ROUND(cps.safety_score, 0) as safety_score_range,
    ROUND(AVG(csd.per_capita_income), 0) as avg_income,
    ROUND(AVG(csd.hardship_index), 1) as avg_hardship,
    COUNT(*) as school_count
FROM chicago_public_schools cps
JOIN chicago_socioeconomic_data csd
    ON cps.community_area_number = csd.community_area_number
WHERE cps.safety_score IS NOT NULL
GROUP BY ROUND(cps.safety_score, 0)
ORDER BY safety_score_range DESC;