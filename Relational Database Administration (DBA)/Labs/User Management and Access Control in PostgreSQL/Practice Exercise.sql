-- Step 1: Create the new user `user_b` with a password
CREATE USER user_b WITH PASSWORD 'user_b_password';

-- Step 2: Grant the `read_write` role to `user_b`
GRANT read_write TO user_b;




-- Optional Best Practices

-- CREATE ROLE read_write;
-- GRANT CONNECT ON DATABASE demo TO read_write;
-- GRANT USAGE ON SCHEMA public TO read_write;
-- GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO read_write;
-- ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO read_write;
