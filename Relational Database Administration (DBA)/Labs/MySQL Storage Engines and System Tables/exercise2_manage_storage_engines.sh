#!/bin/bash

# ----------------------------------------------
# Exercise 2: Manage MySQL Storage Engines
# Author: Willie Conway
# ----------------------------------------------

echo "🚀 Starting Exercise 2: Manage MySQL Storage Engines..."

# Step 1: Ensure MySQL CLI is active
echo "🔔 Please ensure your MySQL session is ACTIVE in the Skills Network Toolbox."
echo "📌 Copy your MySQL password if needed for the CLI login."
read -p "Press [Enter] to continue once you're ready to access the MySQL CLI..."

# Step 2: Prompt to enter MySQL CLI
echo ""
echo "📥 Launch the MySQL CLI from the service tab now."
echo "🔐 Login using your MySQL password when prompted."
echo ""
echo "Once inside MySQL CLI, enter the following commands one at a time:"
echo "--------------------------------------------------------"

cat <<'EOF'
-- View available storage engines
SHOW ENGINES;

-- Create a CSV-based table
CREATE TABLE csv_test (
    i INT NOT NULL,
    c CHAR(10) NOT NULL
) ENGINE = CSV;

-- Confirm the table was created
SHOW TABLES;

-- Insert sample data
INSERT INTO csv_test VALUES
(1, 'data one'),
(2, 'data two'),
(3, 'data three');

-- View inserted data
SELECT * FROM csv_test;
EOF

echo "--------------------------------------------------------"
echo ""
echo "📌 NOTE:"
echo "🔹 CSV tables are saved as .CSV files inside your MySQL data directory."
echo "🔹 Limitations: No indexing, no partitioning support."
echo ""
echo "📚 For deeper learning, check MySQL Docs on engines:"
echo "🔗 https://dev.mysql.com/doc/refman/8.0/en/storage-engines.html"

echo "✅ Exercise complete! You’ve now created and used a CSV table in MySQL."




# How to Use:

# Save the script as exercise2_manage_storage_engines.sh.

# In your terminal, make it executable:

# chmod +x exercise2_manage_storage_engines.sh

# Then run:

# ./exercise2_manage_storage_engines.sh

