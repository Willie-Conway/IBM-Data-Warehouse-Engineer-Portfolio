#!/bin/bash

# Task A: Create Sakila Database Script

echo "🚀 Starting Task A: Create Sakila Database"

# Step 1: Download sakila_mysql_dump.sql
echo "📥 Downloading Sakila MySQL dump file..."
wget -q https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0110EN-SkillsNetwork/datasets/sakila/sakila_mysql_dump.sql

if [ -f "sakila_mysql_dump.sql" ]; then
    echo "✅ Download complete: sakila_mysql_dump.sql"
else
    echo "❌ Download failed. Exiting."
    exit 1
fi

# Step 2: Prompt for MySQL password
read -s -p "🔐 Enter your MySQL root password: " MYSQL_PWD
echo ""

# Step 3: Create ~/.my.cnf file with password
echo "🔧 Configuring ~/.my.cnf for passwordless MySQL login..."
cat <<EOF | sudo tee ~/.my.cnf > /dev/null
[client]
host = mysql
port = 3306
user = root
password = $MYSQL_PWD
EOF

# Set permissions for security
chmod 600 ~/.my.cnf
echo "✅ .my.cnf configured and secured"

# Step 4: Create the database
echo "📂 Creating database 'sakila'..."
mysql -e "CREATE DATABASE sakila;" 2>/dev/null

if [ $? -eq 0 ]; then
    echo "✅ Database 'sakila' created successfully."
else
    echo "⚠️ Failed to create database. It may already exist."
fi

echo "🎉 Task A complete!"


# How to Use the Script

# Create the script file:

# nano task_a_create_sakila_db.sh

# Paste the script into the file, then save and exit:

# Ctrl + O, then Enter to save.

# Ctrl + X to exit.

# Make the script executable:

# chmod +x task_a_create_sakila_db.sh

# Run the script:

# ./task_a_create_sakila_db.sh