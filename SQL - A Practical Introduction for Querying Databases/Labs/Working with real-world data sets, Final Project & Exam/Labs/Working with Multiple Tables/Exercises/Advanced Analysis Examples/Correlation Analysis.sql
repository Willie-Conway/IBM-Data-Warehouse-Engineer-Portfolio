-- Compare school safety with community hardship
SELECT CPS.Name_of_School, CPS.Safety_Score, 
       CSD.hardship_index
FROM chicago_public_schools CPS
JOIN chicago_socioeconomic_data CSD
ON CPS.community_area_number = CSD.community_area_number
ORDER BY CPS.Safety_Score DESC;