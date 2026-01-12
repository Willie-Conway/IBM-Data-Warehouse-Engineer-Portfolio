-- Call the stored procedure
CALL TRANSACTION_JAMES();

-- Check results
SELECT * FROM BankAccounts;
SELECT * FROM ShoeShop;