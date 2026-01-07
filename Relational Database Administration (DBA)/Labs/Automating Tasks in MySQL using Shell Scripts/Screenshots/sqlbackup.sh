
#!/bin/sh
# The above line tells the interpreter this code needs to be run as a shell script.

# Set the database name to a variable. 
DATABASE='sakila'

# This will be printed on to the screen. In the case of cron job, it will be printed to the logs.
echo "Pulling Database: This may take a few minutes"

# Set the folder where the database backup will be stored
backupfolder=/home/theia/backups

# Number of days to store the backup 
keep_day=30

sqlfile=$backupfolder/all-database-$(date +%d-%m-%Y_%H-%M-%S).sql
zipfile=$backupfolder/all-database-$(date +%d-%m-%Y_%H-%M-%S).gz

# Create a backup

if mysqldump  $DATABASE > $sqlfile ; then
   echo 'Sql dump created'
    # Compress backup 
    if gzip -c $sqlfile > $zipfile; then
        echo 'The backup was successfully compressed'
    else
        echo 'Error compressing backupBackup was not created!' 
        exit
    fi
    rm $sqlfile 
else
   echo 'pg_dump return non-zero code No backup was created!' 
   exit
fi

# Delete old backups 
find $backupfolder -mtime +$keep_day -delete



# Make it executable:

# sudo chmod u+x+r sqlbackup.sh

# mkdir /home/theia/backups

# or

# chmod +x /home/project/sqlbackup.sh

# Crontab Configuration

# Open crontab editor:

# crontab -e

# For a backup every 2 minutes, add:

# cron

# */2 * * * * /home/project/sqlbackup.sh > /home/project/backup.log 2>&1

# For a backup every Monday at 12:00 a.m., use:

# cron

# 0 0 * * 1 /home/project/sqlbackup.sh > /home/project/backup.log 2>&1
# For a backup every day at 6:00 a.m., use:
# cron

# 0 6 * * * /home/project/sqlbackup.sh > /home/project/backup.log 2>&1

# Start the cron service:

# bash

# sudo service cron start


