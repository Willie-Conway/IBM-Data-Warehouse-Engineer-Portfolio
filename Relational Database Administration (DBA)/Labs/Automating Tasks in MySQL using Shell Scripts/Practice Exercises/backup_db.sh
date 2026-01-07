#!/bin/sh

# Parameters:
# $1 = database name
# $2 = backup directory

dbname=$(mysql -e "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = '$1'" | grep $1)

# Create backup directory if it does not exist
if [ ! -d "$2" ]; then 
    mkdir -p "$2"
fi

if [ "$1" = "$dbname" ]; then
    sqlfile="$2/$1-$(date +%d-%m-%Y).sql"
    if mysqldump "$1" > "$sqlfile" ; then
        echo "SQL dump created: $sqlfile"
    else
        echo "Error creating backup!"
    fi
else
    echo "Database '$1' doesn't exist"
fi


# Make executable:

# chmod +x backup_db.sh

# Run example:

# ./backup_db.sh sakila /home/theia/backups