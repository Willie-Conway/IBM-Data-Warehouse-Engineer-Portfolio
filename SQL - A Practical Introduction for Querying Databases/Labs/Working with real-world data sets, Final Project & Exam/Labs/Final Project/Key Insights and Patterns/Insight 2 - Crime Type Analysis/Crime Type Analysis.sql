-- Most common crime types and arrest rates
SELECT 
    primary_type,
    COUNT(*) as total_incidents,
    SUM(CASE WHEN arrest = TRUE THEN 1 ELSE 0 END) as arrests,
    ROUND(SUM(CASE WHEN arrest = TRUE THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) as arrest_rate_percent,
    COUNT(DISTINCT community_area) as affected_areas
FROM chicago_crime
GROUP BY primary_type
HAVING total_incidents > 1000
ORDER BY total_incidents DESC;