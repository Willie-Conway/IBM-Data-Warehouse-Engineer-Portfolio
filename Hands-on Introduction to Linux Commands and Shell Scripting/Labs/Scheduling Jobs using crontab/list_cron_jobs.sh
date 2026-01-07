#!/bin/bash
# This script lists the user's current crontab jobs

echo "📋 Checking for existing cron jobs for user: $(whoami)..."

# Try to list current crontab entries
if crontab -l 2>/dev/null; then
    echo "✅ Above are your current scheduled cron jobs."
else
    echo "⚠️  No crontab found for user: $(whoami)."
    echo "ℹ️  You can create one using: crontab -e"
fi



# How to Use:

# Save it as list_cron_jobs.sh.

# Make it executable:

# chmod +x list_cron_jobs.sh

# Run it:

# ./list_cron_jobs.sh