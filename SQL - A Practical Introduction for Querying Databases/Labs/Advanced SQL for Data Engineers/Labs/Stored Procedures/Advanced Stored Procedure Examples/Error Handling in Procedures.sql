DELIMITER //
CREATE PROCEDURE UPDATE_PET_PRICE(
    IN pet_id INTEGER,
    IN new_price DECIMAL(10,2)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error occurred during price update' AS ERROR_MESSAGE;
        ROLLBACK;
    END;
    
    START TRANSACTION;
    
    -- Update price
    UPDATE PETSALE 
    SET SALEPRICE = new_price 
    WHERE ID = pet_id;
    
    -- Log the change
    INSERT INTO PRICE_CHANGE_LOG (PET_ID, OLD_PRICE, NEW_PRICE, CHANGE_DATE)
    VALUES (pet_id, (SELECT SALEPRICE FROM PETSALE WHERE ID = pet_id), new_price, NOW());
    
    COMMIT;
    
    SELECT 'Price updated successfully' AS MESSAGE;
END //
DELIMITER ;