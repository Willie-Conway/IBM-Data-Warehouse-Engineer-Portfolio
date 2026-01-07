#!/bin/bash

# Backup all databases
mysqldump --all-databases --user=root --password=CTAXg9IUAeTRpwRVmOfjNVuF > all-databases-backup.sql

# Create dated directory
DATE=$(date +%Y%m%d)
mkdir -p /tmp/mysqldumps/$DATE

# Move the backup file
mv all-databases-backup.sql /tmp/mysqldumps/$DATE/
