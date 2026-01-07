#!/bin/bash

# Connect to PostgreSQL and the 'demo' database
psql <<EOF

-- Connect to demo database
\connect demo

-- Display all tables in the 'bookings' schema
SELECT * FROM pg_tables WHERE schemaname = 'bookings';

-- Enable row-level security on the 'boarding_passes' table
ALTER TABLE boarding_passes ENABLE ROW LEVEL SECURITY;

-- Re-run table metadata query to confirm row-level security
SELECT * FROM pg_tables WHERE schemaname = 'bookings';

-- Check the 'wal_level' setting from pg_settings
SELECT name, setting, short_desc FROM pg_settings WHERE name = 'wal_level';

EOF



# How to Run It

# Save it as navigate_pg_catalog.sh

# Make it executable:

# chmod +x navigate_pg_catalog.sh

# Run it:

# ./navigate_pg_catalog.sh