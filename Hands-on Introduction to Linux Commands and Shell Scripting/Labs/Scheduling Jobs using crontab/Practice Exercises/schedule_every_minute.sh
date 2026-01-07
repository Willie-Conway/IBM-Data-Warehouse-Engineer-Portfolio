#!/bin/bash

# This script adds a cron job to append the date to /tmp/everymin.txt every minute

# Check if job already exists to avoid duplicates
job="* * * * * date >> /tmp/everymin.txt"

# List current crontab
current_cron=$(crontab -l 2>/dev/null)

# Add the job if it's not already there
if echo "$current_cron" | grep -Fxq "$job"; then
    echo "✅ Cron job already exists."
else
    (echo "$current_cron"; echo "$job") | crontab -
    echo "🕒 Cron job added: $job"
fi

# Confirm it's in crontab
echo "📋 Current crontab:"
crontab -l


# To use this script:

# Save it as schedule_every_minute.sh

# Make it executable:

# chmod +x schedule_every_minute.sh

# Run it:

# ./schedule_every_minute.sh

# Copy file to folder

# cp /tmp/everymin.txt /home/project/