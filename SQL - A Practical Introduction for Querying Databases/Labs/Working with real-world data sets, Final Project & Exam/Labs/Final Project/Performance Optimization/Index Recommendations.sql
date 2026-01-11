-- Suggested indexes for better query performance
CREATE INDEX idx_crime_date ON chicago_crime(date);
CREATE INDEX idx_crime_community_area ON chicago_crime(community_area);
CREATE INDEX idx_crime_arrest ON chicago_crime(arrest);
CREATE INDEX idx_schools_community_area ON chicago_public_schools(community_area_number);
CREATE INDEX idx_schools_safety ON chicago_public_schools(safety_score);
CREATE INDEX idx_socioeconomic_area ON chicago_socioeconomic_data(community_area_number);