#!/bin/sh

# Parameters:
# $1 = database name
# $2 = SQL file path

if [ -f "$2" ]; then 
    dbname=$(mysql -e "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = '$1'" | grep $1)
    if [ "$1" != "$dbname" ]; then
        echo "Database '$1' does not exist. Creating it now..."
        mysql -e "CREATE DATABASE $1"
    fi
    echo "Restoring database '$1' from $2 ..."
    mysql "$1" < "$2"
    echo "Restore complete."
else
    echo "File '$2' doesn't exist"
fi


# Make executable:

# chmod +x restore_db.sh

# Run example:

# ./restore_db.sh sakila /home/theia/backups/sakila-30-07-2025.sql