#!/bin/bash

# Assign city name
city=Casablanca

# Optional: Create log file with header if it doesn't exist
log_file="rx_poc.log"
if [ ! -f "$log_file" ]; then
  echo -e "year\tmonth\tday\tobs_temp\tfc_temp" > $log_file
fi

# Get weather report (save full raw data just in case)
curl -s wttr.in/$city?T --output weather_report

# Extract current observed temperature
obs_temp=$(curl -s wttr.in/$city?T | grep -m 1 '°.' | grep -Eo -e '-?[[:digit:]].*')
echo "Observed temperature in $city: $obs_temp"

# Extract forecast temperature for noon tomorrow
fc_temp=$(curl -s wttr.in/$city?T | head -23 | tail -1 | grep '°.' | cut -d 'C' -f2 | grep -Eo -e '-?[[:digit:]].*')
echo "Forecasted temperature for noon tomorrow in $city: $fc_temp C"

# Get current date in Casablanca time zone
TZ='Morocco/Casablanca'
day=$(TZ=$TZ date -u +%d)
month=$(TZ=$TZ date +%m)
year=$(TZ=$TZ date +%Y)

# Combine and log the entry
record=$(echo -e "$year\t$month\t$day\t$obs_temp\t$fc_temp C")
echo $record >> $log_file


# Make It Executable

# Run this in the terminal (from the same directory):

# chmod +x rx_poc_2.sh

# ⏰ Schedule with Crontab (Optional)
# If you want it to run every day at 8:00 AM system time (noon in Casablanca):

# crontab -e

# Add this line:

# 0 8 * * * /home/project/rx_poc_2.sh