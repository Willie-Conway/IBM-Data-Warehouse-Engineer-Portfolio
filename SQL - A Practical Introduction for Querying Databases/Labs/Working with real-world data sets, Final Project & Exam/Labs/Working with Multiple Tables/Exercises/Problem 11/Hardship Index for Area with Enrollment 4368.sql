SELECT hardship_index 
FROM chicago_socioeconomic_data CD, 
     chicago_public_schools CPS 
WHERE CD.community_area_number = CPS.community_area_number 
  AND college_enrollment = 4368;