SELECT Name_of_School, Average_Student_Attendance 
FROM chicago_public_schools
WHERE CAST(REPLACE(Average_Student_Attendance, '%', '') AS DOUBLE) < 70
ORDER BY Average_Student_Attendance;