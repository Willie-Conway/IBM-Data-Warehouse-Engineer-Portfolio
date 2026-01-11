-- Analyze crime patterns by year and month
SELECT 
    YEAR(date) as crime_year,
    MONTH(date) as crime_month,
    COUNT(*) as crime_count,
    SUM(CASE WHEN arrest = TRUE THEN 1 ELSE 0 END) as arrests_made
FROM chicago_crime
WHERE date IS NOT NULL
GROUP BY YEAR(date), MONTH(date)
ORDER BY crime_year DESC, crime_month DESC;