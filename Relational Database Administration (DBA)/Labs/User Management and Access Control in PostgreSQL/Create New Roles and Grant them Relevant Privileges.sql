-- Connect to the demo database
\c demo;

-- Task A: Create and Grant Privileges to read_only Role

-- Step 1: Create the read_only role
CREATE ROLE read_only;

-- Step 2: Allow connection to the database
GRANT CONNECT ON DATABASE demo TO read_only;

-- Step 3: Allow usage of the bookings schema
GRANT USAGE ON SCHEMA bookings TO read_only;

-- Step 4: Grant SELECT privileges on all tables in the bookings schema
GRANT SELECT ON ALL TABLES IN SCHEMA bookings TO read_only;

-- Optional: Automatically grant SELECT on new tables
ALTER DEFAULT PRIVILEGES IN SCHEMA bookings
GRANT SELECT ON TABLES TO read_only;

---------------------------------------------------

-- Task B: Create and Grant Privileges to read_write Role

-- Step 1: Create the read_write role
CREATE ROLE read_write;

-- Step 2: Allow connection to the database
GRANT CONNECT ON DATABASE demo TO read_write;

-- Step 3: Allow usage of the bookings schema
GRANT USAGE ON SCHEMA bookings TO read_write;

-- Step 4: Grant full CRUD privileges on all tables
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA bookings TO read_write;

-- Optional: Automatically grant full CRUD on new tables
ALTER DEFAULT PRIVILEGES IN SCHEMA bookings
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO read_write;
