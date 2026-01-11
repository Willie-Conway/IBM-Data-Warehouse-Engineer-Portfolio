DELIMITER //
CREATE PROCEDURE VALIDATE_AND_CLEAN_DATA()
BEGIN
    DECLARE invalid_count INT DEFAULT 0;
    
    -- Find negative prices
    SELECT COUNT(*) INTO invalid_count 
    FROM PETSALE 
    WHERE SALEPRICE < 0;
    
    IF invalid_count > 0 THEN
        -- Fix negative prices
        UPDATE PETSALE 
        SET SALEPRICE = ABS(SALEPRICE)
        WHERE SALEPRICE < 0;
        
        SELECT CONCAT('Fixed ', invalid_count, ' negative price records') AS MESSAGE;
    ELSE
        SELECT 'No negative prices found' AS MESSAGE;
    END IF;
    
    -- Find future dates (data entry errors)
    UPDATE PETSALE 
    SET SALEDATE = CURDATE()
    WHERE SALEDATE > CURDATE();
    
    SELECT CONCAT('Updated ', ROW_COUNT(), ' future dates to today') AS MESSAGE;
END //
DELIMITER ;