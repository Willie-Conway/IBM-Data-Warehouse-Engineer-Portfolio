START TRANSACTION;
-- 1. Deduct from sender account
-- 2. Add to receiver account
-- 3. Log the transaction
-- If insufficient funds: ROLLBACK
-- If successful: COMMIT