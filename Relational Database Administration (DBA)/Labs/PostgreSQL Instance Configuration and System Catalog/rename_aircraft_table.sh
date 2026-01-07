#!/bin/bash

# Shell script to safely rename 'aircrafts_data' to 'aircraft_fleet' and verify

psql <<EOF

-- Connect to demo database
\connect demo

-- Attempt (but fail) to rename table by updating system catalog (this is NOT allowed)
-- Uncomment the line below to see the error for educational purposes
-- UPDATE pg_tables SET tablename = 'aircraft_fleet' WHERE tablename = 'aircrafts_data';

-- Correct approach: Use ALTER TABLE to rename the table
ALTER TABLE aircrafts_data RENAME TO aircraft_fleet;

-- Confirm rename by querying pg_tables in the 'bookings' schema
SELECT tablename FROM pg_tables WHERE schemaname = 'bookings';

EOF



# Instructions to Run:

# Save the file as rename_aircraft_table.sh

# Make it executable:

# chmod +x rename_aircraft_table.sh

# Run it:

# ./rename_aircraft_table.sh