DELIMITER //
CREATE PROCEDURE GET_PET_STATS(
    IN pet_id INTEGER,
    OUT original_price DECIMAL(10,2),
    OUT current_price DECIMAL(10,2),
    OUT discount_percent DECIMAL(5,2)
)
BEGIN
    -- Get original price from history or backup
    SELECT SALEPRICE INTO original_price 
    FROM PETSALE_HISTORY 
    WHERE ID = pet_id;
    
    -- Get current price
    SELECT SALEPRICE INTO current_price 
    FROM PETSALE 
    WHERE ID = pet_id;
    
    -- Calculate discount percentage
    SET discount_percent = ((original_price - current_price) / original_price) * 100;
END //
DELIMITER ;

-- Usage:
CALL GET_PET_STATS(1, @orig, @curr, @discount);
SELECT @orig, @curr, @discount;