SELECT Name_of_School, 
       REPLACE(Average_Student_Attendance, '%', '') 
FROM chicago_public_schools
ORDER BY Average_Student_Attendance 
LIMIT 5;