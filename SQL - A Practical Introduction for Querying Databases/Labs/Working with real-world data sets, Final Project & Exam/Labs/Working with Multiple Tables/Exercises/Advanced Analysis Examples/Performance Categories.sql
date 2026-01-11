-- Categorize schools by safety score
SELECT 
    CASE 
        WHEN Safety_Score >= 90 THEN 'Excellent'
        WHEN Safety_Score >= 70 THEN 'Good'
        WHEN Safety_Score >= 50 THEN 'Fair'
        ELSE 'Poor'
    END as Safety_Category,
    COUNT(*) as School_Count
FROM chicago_public_schools
GROUP BY Safety_Category;