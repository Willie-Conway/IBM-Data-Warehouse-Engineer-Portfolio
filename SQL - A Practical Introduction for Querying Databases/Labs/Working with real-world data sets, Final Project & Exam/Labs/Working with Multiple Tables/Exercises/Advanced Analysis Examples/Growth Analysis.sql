-- Find schools with improving attendance
SELECT Name_of_School, 
       Average_Student_Attendance,
       CAST(REPLACE(Average_Student_Attendance, '%', '') AS DOUBLE) -
       CAST(REPLACE(Previous_Year_Attendance, '%', '') AS DOUBLE) 
       as Attendance_Change
FROM chicago_public_schools
ORDER BY Attendance_Change DESC;