SELECT community_area_number, community_area_name, hardship_index 
FROM chicago_socioeconomic_data 
WHERE community_area_number IN (
    SELECT community_area_number 
    FROM chicago_public_schools 
    WHERE COLLEGE_ENROLLMENT = (
        SELECT MAX(COLLEGE_ENROLLMENT) 
        FROM chicago_public_schools
    )
);