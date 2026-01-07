#!/bin/bash

# Define the database file
DB_NAME="lab_billing.db"
TABLE_NAME="billing"
CSV_FILE="billing.csv"
INDEX_NAME="billingamount"
VIEW_NAME="basicbilldetails"
QUERY_AMOUNT=19929

echo "🚀 Starting Part 3 Database Lab..."

# Remove existing DB to start fresh
if [ -f "$DB_NAME" ]; then
    rm "$DB_NAME"
    echo "🗑️ Removed old $DB_NAME"
fi

# Create and initialize the billing table
sqlite3 "$DB_NAME" <<EOF
-- Create billing table
CREATE TABLE $TABLE_NAME (
    customerid INTEGER,
    month TEXT,
    billedamount INTEGER
);

-- Import data
.mode csv
.import $CSV_FILE $TABLE_NAME

-- Show total number of rows imported
SELECT COUNT(*) AS total_rows FROM $TABLE_NAME;
EOF

echo "✅ Table restored and row count displayed."

# Create a view
sqlite3 "$DB_NAME" <<EOF
-- Create view
CREATE VIEW $VIEW_NAME AS
SELECT customerid, month, billedamount FROM $TABLE_NAME;
EOF

echo "✅ View '$VIEW_NAME' created."

# Baseline query timing
echo "⏱️ Baseline query performance:"
sqlite3 "$DB_NAME" <<EOF
SELECT strftime('%Y-%m-%d %H:%M:%f', 'now') AS start_time;
SELECT * FROM $TABLE_NAME WHERE billedamount = $QUERY_AMOUNT;
SELECT strftime('%Y-%m-%d %H:%M:%f', 'now') AS end_time;
EOF

# Create an index
sqlite3 "$DB_NAME" <<EOF
CREATE INDEX $INDEX_NAME ON $TABLE_NAME(billedamount);
EOF

echo "✅ Index '$INDEX_NAME' created."

# Query after indexing
echo "⏱️ Query performance after indexing:"
sqlite3 "$DB_NAME" <<EOF
SELECT strftime('%Y-%m-%d %H:%M:%f', 'now') AS start_time;
SELECT * FROM $TABLE_NAME WHERE billedamount = $QUERY_AMOUNT;
SELECT strftime('%Y-%m-%d %H:%M:%f', 'now') AS end_time;
EOF

echo "🎉 Lab Part 3 Complete. Capture your screenshots now."


# Screenshot Checklist:

# restore-table.jpg: Output after table creation and row count.

# create-view.jpg: View creation query output.

# query-base-line.jpg: Output with timestamps before index.

# index-creation.jpg: Index creation confirmation.

# query-after-index.jpg: Output with timestamps after index.