-- Test all score ranges
SELECT 'Testing all score ranges:' as Test_Header;

-- Test 1: Very strong (80-99)
CALL UPDATE_LEADERS_SCORE(609676, 90);
SELECT 'Score 90 -> Very strong' as Test, School_ID, Leaders_Score, Leaders_Icon 
FROM chicago_public_schools WHERE School_ID = 609676;

-- Test 2: Strong (60-79) 
CALL UPDATE_LEADERS_SCORE(609676, 65);
SELECT 'Score 65 -> Strong' as Test, School_ID, Leaders_Score, Leaders_Icon 
FROM chicago_public_schools WHERE School_ID = 609676;

-- Test 3: Average (40-59)
CALL UPDATE_LEADERS_SCORE(609676, 45);
SELECT 'Score 45 -> Average' as Test, School_ID, Leaders_Score, Leaders_Icon 
FROM chicago_public_schools WHERE School_ID = 609676;

-- Test 4: Weak (20-39)
CALL UPDATE_LEADERS_SCORE(609676, 25);
SELECT 'Score 25 -> Weak' as Test, School_ID, Leaders_Score, Leaders_Icon 
FROM chicago_public_schools WHERE School_ID = 609676;

-- Test 5: Very weak (0-19)
CALL UPDATE_LEADERS_SCORE(609676, 10);
SELECT 'Score 10 -> Very weak' as Test, School_ID, Leaders_Score, Leaders_Icon 
FROM chicago_public_schools WHERE School_ID = 609676;