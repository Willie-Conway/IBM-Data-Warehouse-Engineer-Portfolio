-- Categorize schools by safety levels
SELECT 
    CASE 
        WHEN safety_score >= 90 THEN 'Excellent (90-100)'
        WHEN safety_score >= 70 THEN 'Good (70-89)'
        WHEN safety_score >= 50 THEN 'Fair (50-69)'
        WHEN safety_score >= 1 THEN 'Poor (1-49)'
        ELSE 'No Data'
    END as safety_category,
    COUNT(*) as school_count,
    ROUND(AVG(college_enrollment), 0) as avg_enrollment,
    ROUND(AVG(CAST(REPLACE(average_student_attendance, '%', '') AS DECIMAL)), 1) as avg_attendance
FROM chicago_public_schools
GROUP BY safety_category
ORDER BY 
    CASE safety_category
        WHEN 'Excellent (90-100)' THEN 1
        WHEN 'Good (70-89)' THEN 2
        WHEN 'Fair (50-69)' THEN 3
        WHEN 'Poor (1-49)' THEN 4
        ELSE 5
    END;