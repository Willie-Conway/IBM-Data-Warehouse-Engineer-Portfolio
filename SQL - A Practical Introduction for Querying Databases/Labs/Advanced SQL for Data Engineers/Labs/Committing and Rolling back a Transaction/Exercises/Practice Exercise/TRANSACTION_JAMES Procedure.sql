DELIMITER //

CREATE PROCEDURE TRANSACTION_JAMES()                         
BEGIN
    -- Declare exit handler for exceptions
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;   -- Undo all changes on error
        RESIGNAL;   -- Re-raise the exception
    END;           
    
    START TRANSACTION;
    
    -- Buy 4 pairs of Trainers (4 × 300 = 1200)
    UPDATE BankAccounts
    SET Balance = Balance - 1200
    WHERE AccountName = 'James';
    
    UPDATE BankAccounts
    SET Balance = Balance + 1200
    WHERE AccountName = 'Shoe Shop';
    
    UPDATE ShoeShop
    SET Stock = Stock - 4
    WHERE Product = 'Trainers';
    
    -- Attempt to buy Brogues (price: 150)
    UPDATE BankAccounts
    SET Balance = Balance - 150
    WHERE AccountName = 'James';
        
    COMMIT;    -- Save all changes if successful
        
END //

DELIMITER ;