#!/bin/bash

# Variables - adjust as needed
PGUSER="postgres"
PGHOST="localhost"
PGDATABASE="restored_demo"
BACKUP_FILE="restored_demo_backup.sql"
BOOK_REF="0002D8"

echo "Querying original passenger info..."
psql -U $PGUSER -h $PGHOST -d $PGDATABASE -c "SELECT * FROM tickets WHERE book_ref = '$BOOK_REF';"

echo "Updating passenger name to 'SANYA KORELEVA'..."
psql -U $PGUSER -h $PGHOST -d $PGDATABASE -c "UPDATE tickets SET passenger_name = 'SANYA KORELEVA' WHERE book_ref = '$BOOK_REF';"

echo "Verifying the update..."
psql -U $PGUSER -h $PGHOST -d $PGDATABASE -c "SELECT * FROM tickets WHERE book_ref = '$BOOK_REF';"

echo "Backing up the database to $BACKUP_FILE..."
pg_dump -U $PGUSER -h $PGHOST $PGDATABASE > $BACKUP_FILE

echo "Backup complete!"


# How to use:

# Save the above code to a file called update_and_backup.sh

# Make it executable:

# chmod +x update_and_backup.sh

# Run the script:

# ./update_and_backup.sh

# Enter your PostgreSQL password when prompted.