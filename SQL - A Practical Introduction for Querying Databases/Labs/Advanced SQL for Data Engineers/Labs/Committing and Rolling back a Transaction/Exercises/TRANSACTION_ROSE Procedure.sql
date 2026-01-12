-- Drop the old procedure if it exists
DROP PROCEDURE IF EXISTS TRANSACTION_ROSE;

DELIMITER //

CREATE PROCEDURE TRANSACTION_ROSE()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;                
     
    START TRANSACTION;
    
    -- Use AccountNumber instead of AccountName
    UPDATE BankAccounts
    SET Balance = Balance - 200
    WHERE AccountNumber = 'B001';  -- Rose
    
    UPDATE BankAccounts
    SET Balance = Balance + 200
    WHERE AccountNumber = 'B003';  -- Shoe Shop
    
    UPDATE ShoeShop
    SET Stock = Stock - 1
    WHERE Product = 'Boots';
    
    UPDATE BankAccounts
    SET Balance = Balance - 300
    WHERE AccountNumber = 'B001';  -- Rose again
    
    COMMIT;    
    
END //

DELIMITER ;