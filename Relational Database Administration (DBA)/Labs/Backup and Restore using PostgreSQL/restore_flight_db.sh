#!/bin/bash

# Exit script on error
set -e

# Step 1: Download the SQL file
echo "Downloading the full database backup..."
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/example-guided-project/flights_RUSSIA_small.sql

# Step 2: Start PostgreSQL CLI and restore the SQL file into a new database called 'demo'
echo "Restoring the backup into PostgreSQL..."

# Ensure PostgreSQL service is running
echo "Starting PostgreSQL service..."
sudo systemctl start postgresql

# Create the database 'demo' if it doesn't exist
echo "Creating 'demo' database..."
sudo -u postgres psql -c "DROP DATABASE IF EXISTS demo;"
sudo -u postgres psql -c "CREATE DATABASE demo;"

# Restore the backup into the 'demo' database
echo "Restoring data from flights_RUSSIA_small.sql..."
sudo -u postgres psql -d demo -f flights_RUSSIA_small.sql

# Step 3: Confirm tables exist
echo "Listing tables in 'demo' database..."
sudo -u postgres psql -d demo -c "\dt"

echo "✅ Restoration completed successfully."




# How to Use

# Save the script as restore_flight_db.sh.

# Make it executable:

# chmod +x restore_flight_db.sh

# Run it:

# ./restore_flight_db.sh