SELECT 
    ccd.CASE_NUMBER,
    ccd.PRIMARY_TYPE AS crime_type,
    csd.COMMUNITY_AREA_NAME AS community_name
FROM 
    chicago_crime ccd
LEFT JOIN 
    chicago_socioeconomic_data csd
ON 
    ccd.COMMUNITY_AREA_NUMBER = csd.COMMUNITY_AREA_NUMBER
WHERE 
    ccd.LOCATION_DESCRIPTION LIKE '%SCHOOL%';