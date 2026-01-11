-- Purpose: Measure overall school safety across Chicago
SELECT AVG(safety_score) AS avg_safety_score
FROM chicago_public_schools
WHERE safety_score IS NOT NULL;