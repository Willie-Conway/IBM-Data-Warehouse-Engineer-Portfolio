#!/bin/bash

# -----------------------------------------------
# Exercise 3: Navigate the MySQL System Tables
# Author: Willie Conway
# -----------------------------------------------

echo "🚀 Starting Exercise 3: Navigate the MySQL System Tables..."

# Step 1: Initial prompt
echo "🔔 Make sure your MySQL service session is ACTIVE."
echo "📌 Have your MySQL password ready. Open the MySQL CLI when prompted."
read -p "Press [Enter] to continue once MySQL is active..."

# Step 2: Show CLI commands
echo ""
echo "🔍 Inside MySQL CLI, execute the following commands step by step:"
echo "------------------------------------------------------------------"

cat <<'EOF'
-- 1. List all databases
SHOW DATABASES;

-- 2. Switch to the system database
USE mysql;

-- 3. View all system tables in the mysql database
SHOW TABLES;

-- 4. Display the User column from the user table
SELECT User FROM user;

-- 5. Create a new user
CREATE USER test_user;

-- 6. Verify user was added
SELECT User FROM user;

-- 7. Switch to information_schema to explore metadata
USE information_schema;

-- 8. View column names in the 'country' table from the 'world' database
SELECT COLUMN_NAME FROM COLUMNS WHERE TABLE_NAME = 'country';

-- 9. View storage engine types for specific tables
SELECT table_name, engine 
FROM INFORMATION_SCHEMA.TABLES 
WHERE table_name IN ('country', 'city', 'countrylanguage', 'csv_test');

-- 10. View table sizes in kilobytes (KB)
SELECT table_name, 
       (data_length + index_length)/1024 AS size_kb 
FROM INFORMATION_SCHEMA.TABLES 
WHERE table_name IN ('country', 'city', 'countrylanguage', 'csv_test');
EOF

echo "------------------------------------------------------------------"
echo ""
echo "🧠 Tips:"
echo "🔹 The 'mysql' database uses MyISAM engine for system-level metadata."
echo "🔹 The 'information_schema' database is read-only and contains meta info about all other databases."
echo "🔹 You can’t insert, update, or delete from information_schema — only SELECT."
echo ""
echo "📚 More about system tables: https://dev.mysql.com/doc/refman/8.0/en/system-database.html"

echo "✅ Exercise complete! You now understand MySQL system metadata and how to inspect users, privileges, and table engines."



# How to Use:

# Save the script above as exercise3_navigate_system_tables.sh

# In your Cloud IDE terminal, make it executable:

# chmod +x exercise3_navigate_system_tables.sh

# Then run it:

# ./exercise3_navigate_system_tables.sh