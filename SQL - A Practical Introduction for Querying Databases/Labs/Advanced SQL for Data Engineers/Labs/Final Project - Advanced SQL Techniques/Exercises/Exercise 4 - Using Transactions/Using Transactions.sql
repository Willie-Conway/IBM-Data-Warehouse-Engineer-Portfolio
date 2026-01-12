DROP PROCEDURE IF EXISTS UPDATE_LEADERS_SCORE;

DELIMITER //

CREATE PROCEDURE UPDATE_LEADERS_SCORE(
    IN in_School_ID INT,
    IN in_Leader_Score INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
    
    -- Validate input
    IF in_Leader_Score < 0 OR in_Leader_Score > 99 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Invalid leader score. Score must be between 0 and 99.';
    END IF;
    
    -- Start transaction
    START TRANSACTION;
    
    -- Single UPDATE statement using CASE
    UPDATE chicago_public_schools
    SET Leaders_Score = in_Leader_Score,
        Leaders_Icon = CASE 
            WHEN in_Leader_Score BETWEEN 80 AND 99 THEN 'Very strong'
            WHEN in_Leader_Score BETWEEN 60 AND 79 THEN 'Strong'
            WHEN in_Leader_Score BETWEEN 40 AND 59 THEN 'Average'
            WHEN in_Leader_Score BETWEEN 20 AND 39 THEN 'Weak'
            WHEN in_Leader_Score BETWEEN 0 AND 19 THEN 'Very weak'
            ELSE Leaders_Icon  -- Should never reach here due to validation
        END
    WHERE School_ID = in_School_ID;
    
    -- Check if any row was updated
    IF ROW_COUNT() = 0 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'School ID not found';
    ELSE
        COMMIT;
    END IF;
    
END //

DELIMITER ;