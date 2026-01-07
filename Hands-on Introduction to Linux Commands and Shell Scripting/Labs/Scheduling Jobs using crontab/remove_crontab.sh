#!/bin/bash

# This script removes the user's crontab and verifies its removal

echo "⚠️ WARNING: This will delete all your cron jobs."
read -p "Are you sure you want to continue? (y/n): " confirm

if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
    echo "Removing crontab..."
    crontab -r

    echo "Verifying crontab..."
    crontab -l 2>&1 | grep -q "no crontab"
    if [[ $? -eq 0 ]]; then
        echo "✅ Crontab removed successfully."
    else
        echo "❌ Failed to remove crontab or crontab still exists."
    fi
else
    echo "Operation cancelled."
fi


# To use the script:

# Save it as remove_crontab.sh

# Give it execute permission:

# chmod +x remove_crontab.sh

# Run it:

# ./remove_crontab.sh