-- Option 1: Hard-coded value
SELECT Name_of_School, Safety_Score 
FROM chicago_public_schools 
WHERE Safety_Score = 99;

-- Option 2: Dynamic sub-query (better)
SELECT Name_of_School, Safety_Score 
FROM chicago_public_schools 
WHERE Safety_Score = (
    SELECT MAX(Safety_Score) 
    FROM chicago_public_schools
);