START TRANSACTION;
-- 1. Reserve inventory
-- 2. Process payment
-- 3. Create order record
-- 4. Send confirmation
-- If any step fails: ROLLBACK
-- If all succeed: COMMIT