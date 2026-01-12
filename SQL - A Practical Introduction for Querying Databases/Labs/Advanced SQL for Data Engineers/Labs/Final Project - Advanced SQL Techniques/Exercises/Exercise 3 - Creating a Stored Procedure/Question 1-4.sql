 MySQL returned an empty result set (i.e. zero rows). (Query took 0.0197 seconds.)
-- ============================================ -- EXERCISE 3: COMPLETE SOLUTION -- ============================================ -- Step 1: Fix the column length issue ALTER TABLE chicago_public_schools MODIFY COLUMN Leaders_Icon VARCHAR(20);
[ Edit inline ] [ Edit ] [ Create PHP code ]
 MySQL returned an empty result set (i.e. zero rows). (Query took 0.0066 seconds.)
-- Step 2: Create the stored procedure DROP PROCEDURE IF EXISTS UPDATE_LEADERS_SCORE;
[ Edit inline ] [ Edit ] [ Create PHP code ]
 MySQL returned an empty result set (i.e. zero rows). (Query took 0.0070 seconds.)
CREATE PROCEDURE UPDATE_LEADERS_SCORE( IN in_School_ID INT, IN in_Leader_Score INT ) BEGIN -- Update Leaders_Score and Leaders_Icon based on the score UPDATE chicago_public_schools SET Leaders_Score = in_Leader_Score, Leaders_Icon = CASE WHEN in_Leader_Score >= 80 AND in_Leader_Score <= 99 THEN 'Very strong' WHEN in_Leader_Score >= 60 AND in_Leader_Score <= 79 THEN 'Strong' WHEN in_Leader_Score >= 40 AND in_Leader_Score <= 59 THEN 'Average' WHEN in_Leader_Score >= 20 AND in_Leader_Score <= 39 THEN 'Weak' WHEN in_Leader_Score >= 0 AND in_Leader_Score <= 19 THEN 'Very weak' ELSE NULL END WHERE School_ID = in_School_ID; END;
[ Edit inline ] [ Edit ] [ Create PHP code ]
 Current selection does not contain a unique column. Grid edit, checkbox, Edit, Copy and Delete features are not available. Documentation
 Showing rows 0 - 2 (3 total, Query took 0.0005 seconds.)
-- Step 3: Test the procedure -- First, get a valid School_ID SELECT School_ID, NAME_OF_SCHOOL, Leaders_Score, Leaders_Icon FROM chicago_public_schools WHERE Leaders_Score IS NOT NULL LIMIT 3;
[ Edit inline ] [ Edit ] [ Create PHP code ]
School_ID
NAME_OF_SCHOOL
Leaders_Score
Leaders_Icon
610038
Abraham Lincoln Elementary School
65
Weak
610281
Adam Clayton Powell Paideia Community Academy Elem...
63
Weak
610185
Adlai E Stevenson Elementary School
NDA
Weak
Query results operations
    
 Current selection does not contain a unique column. Grid edit, checkbox, Edit, Copy and Delete features are not available. Documentation
 Showing rows 0 - 0 (1 total, Query took 0.0010 seconds.)
-- Use one of the School_IDs from above (e.g., 609676) -- Show before state SELECT 'BEFORE' as Time, School_ID, Leaders_Score, Leaders_Icon FROM chicago_public_schools WHERE School_ID = 609676;
[ Edit inline ] [ Edit ] [ Create PHP code ]
 Show all	|			Number of rows: 
25
Filter rows: 
Search this table
Time
School_ID
Leaders_Score
Leaders_Icon
BEFORE
609676
50
Weak
 Show all	|			Number of rows: 
25
Filter rows: 
Search this table
Query results operations
    
 MySQL returned an empty result set (i.e. zero rows). (Query took 0.0067 seconds.)
-- Call the procedure CALL UPDATE_LEADERS_SCORE(609676, 75);
[ Edit inline ] [ Edit ] [ Create PHP code ]
 Current selection does not contain a unique column. Grid edit, checkbox, Edit, Copy and Delete features are not available. Documentation
 Showing rows 0 - 0 (1 total, Query took 0.0010 seconds.)
-- Show after state SELECT 'AFTER' as Time, School_ID, Leaders_Score, Leaders_Icon FROM chicago_public_schools WHERE School_ID = 609676;
[ Edit inline ] [ Edit ] [ Create PHP code ]
 Show all	|			Number of rows: 
25
Filter rows: 
Search this table
Time
School_ID
Leaders_Score
Leaders_Icon
AFTER
609676
75
Strong
 Show all	|			Number of rows: 
25
Filter rows: 
Search this table
Query results operations
   