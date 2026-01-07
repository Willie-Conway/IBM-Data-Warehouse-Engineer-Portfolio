#!/bin/bash

# Final Assignment - Database Administration - Part 2
# Script: mybackup.sh
# Purpose: Backup all MySQL databases and store them in a timestamped directory under /tmp/mysqldumps/

# Set variables
DATE=$(date +%Y%m%d)
BACKUP_DIR="/tmp/mysqldumps/$DATE"
BACKUP_FILE="all-databases-backup.sql"
MYSQL_USER="root"
MYSQL_PASSWORD="CTAXg9IUAeTRpwRVmOfjNVuF"  # Replace with actual password if different

echo "==> Creating backup directory: $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

echo "==> Starting MySQL database backup..."
mysqldump --all-databases --user=$MYSQL_USER --password=$MYSQL_PASSWORD > "$BACKUP_FILE"

# Check if dump was created
if [ -f "$BACKUP_FILE" ]; then
    echo "==> Moving backup to $BACKUP_DIR"
    mv "$BACKUP_FILE" "$BACKUP_DIR/"
    echo "==> Backup completed and moved to $BACKUP_DIR"
else
    echo "❌ Error: Backup file not created."
    exit 1
fi

# Optional: List contents
echo "==> Contents of $BACKUP_DIR:"
ls -lh "$BACKUP_DIR"

exit 0


# How to Use This Script

# Create the script in your project folder:

# nano mybackup.sh

# Paste the code above and save (Ctrl+O, Enter, Ctrl+X).

# Make it executable:

# chmod +x mybackup.sh

# Run it:

# ./mybackup.sh

# Verify your backup:

# ls /tmp/mysqldumps/$(date +%Y%m%d)/