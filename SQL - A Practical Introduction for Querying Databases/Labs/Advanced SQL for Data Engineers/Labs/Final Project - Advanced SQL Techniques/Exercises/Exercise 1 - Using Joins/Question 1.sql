SELECT 
    cps.NAME_OF_SCHOOL AS school_name,
    csd.COMMUNITY_AREA_NAME AS community_name,
    cps.AVERAGE_STUDENT_ATTENDANCE AS average_attendance
FROM 
    chicago_public_schools cps
LEFT JOIN 
    chicago_socioeconomic_data csd
ON 
    cps.COMMUNITY_AREA_NUMBER = csd.COMMUNITY_AREA_NUMBER
WHERE 
    csd.HARDSHIP_INDEX = 98;