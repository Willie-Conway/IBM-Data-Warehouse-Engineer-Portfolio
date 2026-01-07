#!/bin/bash

# Script: setup_postgres_demo.sh
# Purpose: Automate part of Exercise 1 - Create Your Database in PostgreSQL (Cloud IDE)

echo "=== PostgreSQL Demo Database Setup ==="

# Step 1: Download the SQL file containing Russian flight data
echo "Downloading SQL script file..."
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/example-guided-project/flights_RUSSIA_small.sql

if [ -f "flights_RUSSIA_small.sql" ]; then
    echo "✅ SQL file downloaded successfully."
else
    echo "❌ Failed to download SQL file. Check your network connection and try again."
    exit 1
fi

# Step 2: Provide manual CLI instruction for the user
echo ""
echo "⚠️  Now please switch to the PostgreSQL CLI tab in the Cloud IDE."
echo "Once there, run the following command to import the SQL file:"
echo ""
echo "    \\i flights_RUSSIA_small.sql"
echo ""
echo "This will create and switch you to the 'demo' database."
echo ""

# Step 3: Display tip for checking tables
echo "To list the tables after import, run:"
echo ""
echo "    \\dt"
echo ""
echo "You should see 8 tables under the 'booking' schema."
echo ""

echo "✅ Setup part complete. Finish the import manually via the PostgreSQL CLI."


# Instructions to Use:

# Save the script above as setup_postgres_demo.sh.

# In your Cloud IDE terminal, run the following commands:

# chmod +x setup_postgres_demo.sh

# ./setup_postgres_demo.sh