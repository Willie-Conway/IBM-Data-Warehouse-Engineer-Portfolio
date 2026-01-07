#!/bin/bash

# Script: optimize_postgres_database.sh
# Purpose: Automate PostgreSQL data optimization and vacuum checks

echo "=== PostgreSQL Database Optimization ==="

# Connect to demo database and verify connection
echo ""
echo "📌 Connecting to 'demo' database and listing tables..."
psql -d demo -c "\dt"

# Preview aircrafts_data
echo ""
echo "📌 Displaying sample data from aircrafts_data..."
psql -d demo -c "SELECT * FROM aircrafts_data;"

# Show current column types
echo ""
echo "📌 Showing column definitions for aircrafts_data..."
psql -d demo -c "\d aircrafts_data"

# Drop dependent view to allow type modification
echo ""
echo "📌 Dropping dependent view 'aircrafts' (required before modifying columns)..."
psql -d demo -c "DROP VIEW IF EXISTS aircrafts;"

# Alter range column type to smallint
echo ""
echo "📌 Altering 'range' column data type to SMALLINT for optimization..."
psql -d demo -c "ALTER TABLE aircrafts_data ALTER COLUMN range TYPE smallint;"

# Verify the change
echo ""
echo "📌 Verifying updated column data types..."
psql -d demo -c "\d aircrafts_data"

# Check autovacuum setting
echo ""
echo "📌 Checking if autovacuum is enabled..."
psql -d demo -c "SHOW autovacuum;"

# Show vacuum stats
echo ""
echo "📌 Displaying vacuum stats from pg_stat_user_tables..."
psql -d demo -c "SELECT relname, n_dead_tup, last_autoanalyze, autovacuum_count FROM pg_stat_user_tables;"

echo ""
echo "✅ Optimization complete. The 'range' column is now SMALLINT, and vacuum stats have been retrieved."


# How to Use:

# Save the script as optimize_postgres_database.sh.

# Run in your Cloud IDE terminal:

# chmod +x optimize_postgres_database.sh

# ./optimize_postgres_database.sh