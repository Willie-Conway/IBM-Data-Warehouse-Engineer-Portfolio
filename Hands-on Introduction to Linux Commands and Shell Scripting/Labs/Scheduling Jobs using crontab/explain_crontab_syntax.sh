#!/bin/bash

# This script demonstrates a sample crontab job and explains each field

echo "🔍 Sample crontab entry:"
echo "0 9 * * 1 /home/youruser/weekly_report.sh"

echo ""
echo "🗓️ Breakdown:"
echo " ┌───────────── minute (0 - 59)"
echo " │ ┌───────────── hour (0 - 23)"
echo " │ │ ┌───────────── day of month (1 - 31)"
echo " │ │ │ ┌───────────── month (1 - 12)"
echo " │ │ │ │ ┌───────────── day of week (0 - 6) (Sunday=0)"
echo " │ │ │ │ │"
echo " 0  9  *  *  1  /home/youruser/weekly_report.sh"
echo ""
echo "📋 This cron job runs the script /home/youruser/weekly_report.sh every Monday at 9:00 AM."

echo ""
echo "⚙️ Want to add it to your crontab? (y/n): "
read -r confirm

if [[ $confirm == "y" || $confirm == "Y" ]]; then
    (crontab -l 2>/dev/null; echo "0 9 * * 1 /home/youruser/weekly_report.sh") | crontab -
    echo "✅ Cron job added!"
else
    echo "❌ No changes made to your crontab."
fi



# How to use:

# Save as explain_crontab_syntax.sh

# Run:

# chmod +x explain_crontab_syntax.sh

# ./explain_crontab_syntax.sh