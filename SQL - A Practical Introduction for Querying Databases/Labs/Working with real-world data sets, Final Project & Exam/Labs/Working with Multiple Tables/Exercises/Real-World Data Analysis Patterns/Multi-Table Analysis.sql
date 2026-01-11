-- Combine different datasets
SELECT school_data.*, socioeconomic_data.*
FROM school_data, socioeconomic_data
WHERE school_data.area_id = socioeconomic_data.area_id;