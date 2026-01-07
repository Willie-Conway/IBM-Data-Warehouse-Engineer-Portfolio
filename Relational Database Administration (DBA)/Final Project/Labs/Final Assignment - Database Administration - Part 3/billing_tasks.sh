#!/bin/bash

# Define DB path
DB_PATH="billing.db"

# Count rows
echo "Counting rows..."
sqlite3 $DB_PATH "SELECT COUNT(*) FROM billing;"

# Create view
echo "Creating view..."
sqlite3 $DB_PATH "
CREATE VIEW basicbilldetails AS
SELECT customerid, month, billedamount
FROM billing;
"

# Baseline performance
echo "Baseline query..."
sqlite3 $DB_PATH "SELECT strftime('%Y-%m-%d %H:%M:%f', 'now');"
sqlite3 $DB_PATH "SELECT * FROM billing WHERE billedamount = 19929;"
sqlite3 $DB_PATH "SELECT strftime('%Y-%m-%d %H:%M:%f', 'now');"

# Create index
echo "Creating index..."
sqlite3 $DB_PATH "CREATE INDEX billingamount ON billing (billedamount);"

# Performance after indexing
echo "Query after indexing..."
sqlite3 $DB_PATH "SELECT strftime('%Y-%m-%d %H:%M:%f', 'now');"
sqlite3 $DB_PATH "SELECT * FROM billing WHERE billedamount = 19929;"
sqlite3 $DB_PATH "SELECT strftime('%Y-%m-%d %H:%M:%f', 'now');"
