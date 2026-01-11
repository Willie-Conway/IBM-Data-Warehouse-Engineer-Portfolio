-- Purpose: Measure law enforcement effectiveness in making arrests
SELECT COUNT(*) AS crimes_with_arrest
FROM chicago_crime
WHERE arrest = TRUE;
-- Or: WHERE arrest = 1 (if stored as boolean)
-- Or: WHERE LOWER(arrest) = 'true' (if stored as string)