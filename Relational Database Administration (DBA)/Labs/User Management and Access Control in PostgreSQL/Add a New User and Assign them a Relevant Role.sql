-- Step 1: Create the read_only role (if not already exists)
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_roles WHERE rolname = 'read_only'
    ) THEN
        CREATE ROLE read_only;
    END IF;
END
$$;

-- Step 2: Grant read-only privileges (adjust schema and tables as needed)
-- Replace 'bookings' with your actual schema name
GRANT CONNECT ON DATABASE your_database_name TO read_only;
GRANT USAGE ON SCHEMA bookings TO read_only;
GRANT SELECT ON ALL TABLES IN SCHEMA bookings TO read_only;

-- Optional: Automatically grant SELECT on future tables
ALTER DEFAULT PRIVILEGES IN SCHEMA bookings
GRANT SELECT ON TABLES TO read_only;

-- Step 3: Create a new user with password
CREATE USER user_a WITH PASSWORD 'user_a_password';

-- Step 4: Grant read_only role to user_a
GRANT read_only TO user_a;
