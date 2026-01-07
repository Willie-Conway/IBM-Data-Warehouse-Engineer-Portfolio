-- Step 1: Connect to the demo database
\c demo;

-- Step 2: Create a role that has both read and write permissions
-- Note: You can customize this if you need more granular control
CREATE ROLE read_write;

-- Grant SELECT, INSERT, UPDATE, DELETE on all tables in the public schema to the role
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO read_write;

-- Optional: Ensure future tables also get permissions automatically
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO read_write;

-- Step 3: Create the user and assign a password
CREATE USER user_b WITH PASSWORD 'user_b_password';

-- Step 4: Grant the user the read_write role
GRANT read_write TO user_b;

-- ✅ Optional: Revoke access if needed
-- REVOKE read_write FROM user_b;
-- DROP USER user_b;
