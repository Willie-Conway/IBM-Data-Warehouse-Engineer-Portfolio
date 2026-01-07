#!/bin/bash
# This script sets up a sample cron job that runs every day at 9:00 AM

# Define the cron job
CRON_TIME="0 9 * * *"
COMMAND="/home/$(whoami)/daily_report.sh"
CRON_JOB="$CRON_TIME $COMMAND"

# Check if the command script exists
if [ ! -f "$COMMAND" ]; then
    echo "#!/bin/bash" > "$COMMAND"
    echo "echo \"This is your daily report at \$(date)\" >> /home/$(whoami)/report.log" >> "$COMMAND"
    chmod +x "$COMMAND"
    echo "✅ Created placeholder script: $COMMAND"
fi

# Add the cron job only if it's not already there
(crontab -l 2>/dev/null | grep -Fxq "$CRON_JOB") && echo "ℹ️  Cron job already exists." || (
    (crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab -
    echo "✅ Cron job added: $CRON_JOB"
)

# Show current cron jobs
echo -e "\n📋 Current crontab entries:"
crontab -l


# What it does:

# Creates a script daily_report.sh that logs the time to a file report.log.

# Adds a cron job that runs this script every day at 9:00 AM.

# Avoids duplicate entries.

# Displays current cron jobs after setup.




# How to Use:

# Save it as setup_cron_job.sh.

# Make it executable:

# chmod +x setup_cron_job.sh

# Run it:

# ./setup_cron_job.sh