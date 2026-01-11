SELECT Community_Area_Name, 
       SUM(College_Enrollment) AS TOTAL_ENROLLMENT 
FROM chicago_public_schools 
GROUP BY Community_Area_Name;