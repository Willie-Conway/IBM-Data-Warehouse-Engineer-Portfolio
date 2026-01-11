-- Check for data completeness
SELECT 
    'chicago_crime' as table_name,
    COUNT(*) as total_rows,
    SUM(CASE WHEN date IS NULL THEN 1 ELSE 0 END) as missing_dates,
    SUM(CASE WHEN primary_type IS NULL THEN 1 ELSE 0 END) as missing_crime_type
FROM chicago_crime
UNION ALL
SELECT 
    'chicago_public_schools',
    COUNT(*),
    SUM(CASE WHEN safety_score IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN community_area_number IS NULL THEN 1 ELSE 0 END)
FROM chicago_public_schools
UNION ALL
SELECT 
    'chicago_socioeconomic_data',
    COUNT(*),
    SUM(CASE WHEN hardship_index IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN per_capita_income IS NULL THEN 1 ELSE 0 END)
FROM chicago_socioeconomic_data;