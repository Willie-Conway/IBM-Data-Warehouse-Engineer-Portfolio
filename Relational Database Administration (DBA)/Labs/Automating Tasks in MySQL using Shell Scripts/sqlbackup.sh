#!/bin/sh
# --------------------------------------------
# Shell Script: sqlbackup.sh
# Purpose: Backup MySQL 'sakila' database, compress, and retain for 30 days
# --------------------------------------------

# Set the database name
DATABASE='sakila'

# Print log
echo "🕒 Pulling Database: This may take a few minutes..."

# Set backup folder
backupfolder=/home/theia/backups

# Set number of days to retain backups
keep_day=30

# Generate filenames with timestamp
timestamp=$(date +%d-%m-%Y_%H-%M-%S)
sqlfile=$backupfolder/all-database-$timestamp.sql
zipfile=$backupfolder/all-database-$timestamp.gz

# Ensure backup folder exists
if [ ! -d "$backupfolder" ]; then
    echo "📁 Backup folder does not exist. Creating $backupfolder..."
    mkdir -p $backupfolder
fi

# Create SQL dump
if mysqldump $DATABASE > $sqlfile ; then
    echo "✅ SQL dump created: $sqlfile"

    # Compress the SQL file
    if gzip -c $sqlfile > $zipfile; then
        echo "✅ Backup compressed: $zipfile"
        rm $sqlfile
    else
        echo "❌ Error compressing backup. SQL file retained."
        exit 1
    fi
else
    echo "❌ mysqldump failed. No backup was created!"
    exit 1
fi

# Delete backups older than $keep_day days
echo "🧹 Cleaning up backups older than $keep_day days..."
find $backupfolder -mtime +$keep_day -delete
echo "✅ Cleanup complete."

echo "🎉 Backup script finished!"






# How to Use This Script

# Create the script file:

# nano sqlbackup.sh

# Paste the script, then save with:

# Ctrl + O, then Enter

# Exit with Ctrl + X

# Make it executable:

# sudo chmod u+x+r sqlbackup.sh

# Create the backup folder (if not already created):

# mkdir -p /home/theia/backups

# Run the script:

# ./sqlbackup.sh



# Optional: Set up a Cron Job (for automation)
# To run the backup daily, type:

# crontab -e

# Then add this line to run every day at 2am:

# 0 2 * * * /home/theia/sqlbackup.sh