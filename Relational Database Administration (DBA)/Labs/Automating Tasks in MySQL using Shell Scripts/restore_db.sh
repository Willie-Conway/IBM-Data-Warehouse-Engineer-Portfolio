#!/bin/bash

# Usage: ./restore_db.sh <database_name> <backup_file_name.sql.gz>
# Example: ./restore_db.sh sakila sakila_30-07-2025.sql.gz

# Parameters
DB_NAME=$1
BACKUP_FILE=$2
BACKUP_DIR="/home/project/backups"

# Check for required parameters
if [ -z "$DB_NAME" ] || [ -z "$BACKUP_FILE" ]; then
  echo "Usage: $0 <database_name> <backup_file_name.sql.gz>"
  exit 1
fi

# Check if backup file exists
if [ ! -f "$BACKUP_DIR/$BACKUP_FILE" ]; then
  echo "Backup file not found: $BACKUP_DIR/$BACKUP_FILE"
  exit 1
fi

# Extract SQL file using gunzip
echo "Extracting backup file..."
gunzip -k "$BACKUP_DIR/$BACKUP_FILE"  # -k to keep original .gz file

# Get SQL file name (remove .gz extension)
SQL_FILE="${BACKUP_FILE%.gz}"

# Check if extracted SQL file exists
if [ ! -f "$BACKUP_DIR/$SQL_FILE" ]; then
  echo "Extraction failed or SQL file not found: $SQL_FILE"
  exit 1
fi

# Check if database exists, create if not
EXISTS=$(mysql -e "SHOW DATABASES LIKE '$DB_NAME'" | grep "$DB_NAME")
if [ "$EXISTS" == "" ]; then
  echo "Database $DB_NAME does not exist. Creating..."
  mysql -e "CREATE DATABASE $DB_NAME"
else
  echo "Restoring into existing database: $DB_NAME"
fi

# Restore the SQL file to the database
echo "Restoring $SQL_FILE into database $DB_NAME..."
mysql "$DB_NAME" < "$BACKUP_DIR/$SQL_FILE"

if [ $? -eq 0 ]; then
  echo "Database restore complete."
else
  echo "Restore failed."
fi


# How to Use:

# Save the script in your project folder:

# nano /home/project/restore_db.sh

# Paste the script, save and exit.

# Make it executable:

# chmod +x /home/project/restore_db.sh

# Run the script like this:

# ./restore_db.sh sakila sakila_30-07-2025.sql.gz

# Replace sakila_30-07-2025.sql.gz with your actual backup file.