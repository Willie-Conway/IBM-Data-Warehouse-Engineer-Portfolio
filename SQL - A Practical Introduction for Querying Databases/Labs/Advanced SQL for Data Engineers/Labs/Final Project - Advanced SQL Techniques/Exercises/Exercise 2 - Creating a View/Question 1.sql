-- Create the view
CREATE OR REPLACE VIEW CHICAGO_SCHOOL_RATINGS AS
SELECT 
    NAME_OF_SCHOOL AS School_Name,
    Safety_Icon AS Safety_Rating,
    Family_Involvement_Icon AS Family_Rating,
    Environment_Icon AS Environment_Rating,
    Instruction_Icon AS Instruction_Rating,
    Leaders_Icon AS Leaders_Rating,
    Teachers_Icon AS Teachers_Rating
FROM 
    chicago_public_schools;

-- Select all columns from the view
SELECT * FROM CHICAGO_SCHOOL_RATINGS;

-- Select just school name and leaders rating
SELECT 
    School_Name, 
    Leaders_Rating 
FROM 
    CHICAGO_SCHOOL_RATINGS;