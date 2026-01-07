#!/bin/bash

# MySQL credentials
MYSQL_USER="root"
MYSQL_HOST="mysql"
MYSQL_PORT="3306"
WORLD_DB="world"
BACKUP_FILE="world_countrylanguage_mysql_backup.sql"

# Prompt user for password securely
echo -n "Enter MySQL root password: "
read -s MYSQL_PWD
echo

# Step 1: Download required SQL files
echo "Downloading SQL scripts..."
wget -q https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0231EN-SkillsNetwork/datasets/World/world_mysql_script.sql
wget -q https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0231EN-SkillsNetwork/datasets/World/world_mysql_update_A.sql

# Step 2: Create and initialize the world database
echo "Creating and initializing world database..."
mysql --host=$MYSQL_HOST --port=$MYSQL_PORT --user=$MYSQL_USER --password=$MYSQL_PWD --execute="CREATE DATABASE IF NOT EXISTS $WORLD_DB;"
mysql --host=$MYSQL_HOST --port=$MYSQL_PORT --user=$MYSQL_USER --password=$MYSQL_PWD $WORLD_DB < world_mysql_script.sql

# Step 3: Verify countrylanguage table (should be empty for CAN)
echo "Checking if any 'CAN' entries exist in countrylanguage table..."
mysql --host=$MYSQL_HOST --port=$MYSQL_PORT --user=$MYSQL_USER --password=$MYSQL_PWD --execute="SELECT * FROM world.countrylanguage WHERE countrycode='CAN';"

# Step 4: Run update script to insert data
echo "Inserting Canada-related data..."
mysql --host=$MYSQL_HOST --port=$MYSQL_PORT --user=$MYSQL_USER --password=$MYSQL_PWD $WORLD_DB < world_mysql_update_A.sql

# Step 5: Verify the inserted data
echo "Verifying data insertion..."
mysql --host=$MYSQL_HOST --port=$MYSQL_PORT --user=$MYSQL_USER --password=$MYSQL_PWD --execute="SELECT * FROM world.countrylanguage WHERE countrycode='CAN';"

# Step 6: Perform a logical backup
echo "Performing logical backup of countrylanguage table..."
mysqldump --host=$MYSQL_HOST --port=$MYSQL_PORT --user=$MYSQL_USER --password=$MYSQL_PWD $WORLD_DB countrylanguage > $BACKUP_FILE

# Step 7: Drop the table to simulate accidental deletion
echo "Dropping countrylanguage table..."
mysql --host=$MYSQL_HOST --port=$MYSQL_PORT --user=$MYSQL_USER --password=$MYSQL_PWD --execute="DROP TABLE world.countrylanguage;"

# Step 8: Verify that the table is gone
echo "Verifying table drop..."
mysql --host=$MYSQL_HOST --port=$MYSQL_PORT --user=$MYSQL_USER --password=$MYSQL_PWD --execute="SHOW TABLES FROM world;"

# Step 9: Restore from backup
echo "Restoring countrylanguage table from backup..."
mysql --host=$MYSQL_HOST --port=$MYSQL_PORT --user=$MYSQL_USER --password=$MYSQL_PWD $WORLD_DB < $BACKUP_FILE

# Step 10: Verify data restoration
echo "Verifying data restoration..."
mysql --host=$MYSQL_HOST --port=$MYSQL_PORT --user=$MYSQL_USER --password=$MYSQL_PWD --execute="SELECT * FROM world.countrylanguage WHERE countrycode='CAN';"

echo "✅ Logical backup and restore process complete."


# How to Use:

# Save the script above as logical_backup_restore_world.sh

# Make it executable:

# chmod +x logical_backup_restore_world.sh

# Run it:

# ./logical_backup_restore_world.sh

# Enter the MySQL root password when prompted.