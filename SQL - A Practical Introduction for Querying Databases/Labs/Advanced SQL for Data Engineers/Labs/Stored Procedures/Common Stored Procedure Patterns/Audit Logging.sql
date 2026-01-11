CREATE PROCEDURE UpdatePriceWithLog(
    IN pet_id INT,
    IN new_price DECIMAL(10,2),
    IN user_id INT
)
BEGIN
    DECLARE old_price DECIMAL(10,2);
    
    -- Get old price
    SELECT SALEPRICE INTO old_price FROM PETSALE WHERE ID = pet_id;
    
    -- Update price
    UPDATE PETSALE SET SALEPRICE = new_price WHERE ID = pet_id;
    
    -- Log the change
    INSERT INTO PRICE_CHANGE_AUDIT (
        pet_id, old_price, new_price, changed_by, change_date
    ) VALUES (
        pet_id, old_price, new_price, user_id, NOW()
    );
END;