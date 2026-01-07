#!/bin/bash

# Exit on any error
set -e

echo "🚀 Connecting to PostgreSQL and modifying 'aircrafts_data' table..."

# Step 1: Check if PostgreSQL is running
sudo systemctl start postgresql

# Step 2: Insert Airbus A380 into aircrafts_data
sudo -u postgres psql -d demo -c "INSERT INTO aircrafts_data(aircraft_code, model, range) VALUES (380, '{\"en\": \"Airbus A380-800\"}', 15700);"

# Step 3: Confirm insertion
echo "✅ Aircraft data after insertion:"
sudo -u postgres psql -d demo -c "SELECT * FROM aircrafts_data;"

echo "🎯 Modification completed successfully. Proceed to pgAdmin for backup."



# How to Use:

# Save as: modify_aircraft_data.sh

# Make it executable:

# chmod +x modify_aircraft_data.sh

# Run:

# ./modify_aircraft_data.sh