# Open crontab editor
crontab -e

# Add this line for daily at 2 AM
0 2 * * * /bin/bash /home/project/ETL.sh >> /home/project/etl_cron.log 2>&1

# For testing (every 5 minutes)
*/5 * * * * /bin/bash /home/project/ETL.sh >> /home/project/etl_cron.log 2>&1

# Start/restart cron service
sudo service cron restart