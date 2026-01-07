#!/bin/bash

# ---------------------------------------
# Exercise 1: Create "world" Database in MySQL
# Author: Willie Conway
# ---------------------------------------

echo "🚀 Starting Exercise 1: Create your 'world' database in MySQL..."

# Step 1: Notify user to launch MySQL service manually
echo "🔔 Please make sure your MySQL service session is ACTIVE in the Skills Network Toolbox."
echo "📌 Also, copy your MySQL password from the interface for later CLI access."
read -p "Press [Enter] to continue once MySQL service is active..."

# Step 2: Download the world_mysql_script.sql file
echo "⬇️ Downloading SQL script file..."
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0231EN-SkillsNetwork/datasets/World/world_mysql_script.sql

if [ -f "world_mysql_script.sql" ]; then
    echo "✅ Script file downloaded successfully."
else
    echo "❌ Download failed. Please check your internet connection and try again."
    exit 1
fi

# Step 3: Instructions for MySQL CLI session
echo ""
echo "🔑 Next Steps:"
echo "1. Click the 'MySQL CLI' button from the MySQL session tab."
echo "2. Paste your copied password into the CLI when prompted (Ctrl+V or Cmd+V)."
echo "3. Once inside the MySQL prompt, run the following commands:"

cat <<EOF

----------------------------------------
-- MySQL CLI COMMANDS TO RUN MANUALLY --
----------------------------------------

CREATE DATABASE world;
USE world;
SOURCE world_mysql_script.sql;
SHOW TABLES;

----------------------------------------
EOF

echo "📝 Note: You won’t see your password when pasting it — that’s normal for secure terminal input."

echo "✅ Script complete. Proceed with the manual MySQL steps listed above."




# How to Use It:

# Save the script above as exercise1_create_world_db.sh.

# In your Cloud IDE terminal, run:

# chmod +x exercise1_create_world_db.sh
# ./exercise1_create_world_db.sh
