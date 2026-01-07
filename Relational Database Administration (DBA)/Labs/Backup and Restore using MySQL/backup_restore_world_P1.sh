#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Connection details
MYSQL_HOST=172.21.8.103
MYSQL_PORT=3306
MYSQL_USER=root
MYSQL_PASS='JloZegetZekvOcCTPVfMmwLp'

# Step 1: Download the required SQL scripts
echo "Downloading SQL scripts..."
wget -O world_mysql_script.sql https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0231EN-SkillsNetwork/datasets/World/world_mysql_script.sql
wget -O world_mysql_update_1.sql https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0231EN-SkillsNetwork/datasets/World/world_mysql_update_1.sql

# Step 2: Create the new database
echo "Creating database world_P1..."
mysql --host=$MYSQL_HOST --port=$MYSQL_PORT --user=$MYSQL_USER --password=$MYSQL_PASS -e "CREATE DATABASE IF NOT EXISTS world_P1;"

# Step 3: Populate the database using the initial script
echo "Loading initial world_mysql_script.sql into world_P1..."
mysql --host=$MYSQL_HOST --port=$MYSQL_PORT --user=$MYSQL_USER --password=$MYSQL_PASS world_P1 < world_mysql_script.sql

# Step 4: Query to check for BGD records
echo "Checking if BGD records exist in city table..."
RESULT=$(mysql --host=$MYSQL_HOST --port=$MYSQL_PORT --user=$MYSQL_USER --password=$MYSQL_PASS --database=world_P1 --batch --skip-column-names -e "SELECT COUNT(*) FROM city WHERE countrycode='BGD';")

# Step 5: If no BGD data, apply the update script
if [ "$RESULT" -eq "0" ]; then
  echo "No BGD records found. Applying update..."
  mysql --host=$MYSQL_HOST --port=$MYSQL_PORT --user=$MYSQL_USER --password=$MYSQL_PASS world_P1 < world_mysql_update_1.sql
else
  echo "BGD records found: $RESULT"
fi

# Step 6: Perform a logical backup of city table
echo "Creating logical backup of city table..."
mysqldump --host=$MYSQL_HOST --port=$MYSQL_PORT --user=$MYSQL_USER --password=$MYSQL_PASS world_P1 city > world_P1_city_mysql_backup.sql

# Step 7: Drop the city table
echo "Dropping city table..."
mysql --host=$MYSQL_HOST --port=$MYSQL_PORT --user=$MYSQL_USER --password=$MYSQL_PASS --execute="DROP TABLE world_P1.city;"

# Step 8: Verify table is dropped
echo "Verifying drop..."
mysql --host=$MYSQL_HOST --port=$MYSQL_PORT --user=$MYSQL_USER --password=$MYSQL_PASS --execute="SHOW TABLES FROM world_P1;" | grep city || echo "city table successfully dropped."

# Step 9: Restore the table from backup
echo "Restoring city table from backup..."
mysql --host=$MYSQL_HOST --port=$MYSQL_PORT --user=$MYSQL_USER --password=$MYSQL_PASS world_P1 < world_P1_city_mysql_backup.sql

# Step 10: Verify restore
echo "Verifying restore..."
mysql --host=$MYSQL_HOST --port=$MYSQL_PORT --user=$MYSQL_USER --password=$MYSQL_PASS --execute="SELECT COUNT(*) FROM world_P1.city;"

echo "✅ Backup and restore process completed successfully."



# How to Run This Script in the Cloud IDE:

# Open the Cloud IDE terminal.

# Create the script file:

# nano backup_restore_world_P1.sh

# Paste the script above. Save and exit (Ctrl+O, then Enter, then Ctrl+X).

# Make the script executable:

# chmod +x backup_restore_world_P1.sh

# Run the script:

# ./backup_restore_world_P1.sh