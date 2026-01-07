-- Step 1: Revoke SELECT access to aircrafts_data table from user_a
REVOKE SELECT ON aircrafts_data FROM user_a;

-- Step 2: Revoke read_only role from user_a
REVOKE read_only FROM user_a;

-- Step 3: (Optional) List all roles and their memberships to confirm
-- This command only works inside psql shell:
-- \du
