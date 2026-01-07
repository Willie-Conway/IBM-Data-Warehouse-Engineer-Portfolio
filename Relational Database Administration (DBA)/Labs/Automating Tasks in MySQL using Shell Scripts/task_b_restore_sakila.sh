#!/bin/bash

# Task B: Restore Sakila Database Tables and Data

echo "🚀 Starting Task B: Restore Sakila Tables and Data"

# Ensure the dump file exists
if [ ! -f "sakila_mysql_dump.sql" ]; then
    echo "❌ Error: sakila_mysql_dump.sql not found. Please run Task A first."
    exit 1
fi

# Step 1: Use sakila database
echo "📂 Switching to database 'sakila'..."
mysql -e "USE sakila;" 2>/dev/null

if [ $? -ne 0 ]; then
    echo "❌ Failed to switch to database 'sakila'. Make sure it exists."
    exit 1
fi

# Step 2: Restore structure and data
echo "📦 Restoring sakila structure and data from sakila_mysql_dump.sql..."
mysql sakila < sakila_mysql_dump.sql

if [ $? -eq 0 ]; then
    echo "✅ Sakila database restored successfully."
else
    echo "❌ Failed to restore sakila database."
    exit 1
fi

# Step 3: Verify tables exist
echo "🔍 Listing all base tables in 'sakila' database:"
mysql -D sakila -e "SHOW FULL TABLES WHERE table_type = 'BASE TABLE';"

echo "🎉 Task B complete!"




# How to Run This Script

# Create the script file:

# nano task_b_restore_sakila.sh

# Paste the script, then save and exit (Ctrl + O, Enter, then Ctrl + X).

# Make the script executable:

# chmod +x task_b_restore_sakila.sh

# Run the script:

# ./task_b_restore_sakila.sh