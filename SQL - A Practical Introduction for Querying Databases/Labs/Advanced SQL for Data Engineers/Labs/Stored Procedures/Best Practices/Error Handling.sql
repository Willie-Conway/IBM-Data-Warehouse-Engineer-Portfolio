BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
        @sqlstate = RETURNED_SQLSTATE,
        @errno = MYSQL_ERRNO,
        @text = MESSAGE_TEXT;
        
        INSERT INTO ERROR_LOG (error_time, error_message)
        VALUES (NOW(), CONCAT('Error: ', @errno, ' - ', @text));
        
        SELECT 'An error occurred. Please contact support.' AS ERROR;
    END;
    
    -- Main logic here
END;