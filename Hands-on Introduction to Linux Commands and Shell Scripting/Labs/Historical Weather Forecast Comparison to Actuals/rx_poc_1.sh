#!/bin/bash

# Assign city name
city=Casablanca

# Download the weather report silently
curl -s wttr.in/$city?T --output weather_report

# Extract current observed temperature
obs_temp=$(cat weather_report | grep -m 1 '°.' | grep -Eo -e '-?[[:digit:]].*')
echo "The current temperature of $city: $obs_temp"

# Extract forecasted temperature for tomorrow at noon
fc_temp=$(cat weather_report | head -23 | tail -1 | grep '°.' | cut -d 'C' -f2 | grep -Eo -e '-?[[:digit:]].*')
echo "The forecasted temperature for noon tomorrow in $city: $fc_temp C"

# Set timezone and extract date components
TZ='Morocco/Casablanca'
day=$(TZ='Morocco/Casablanca' date -u +%d)
month=$(TZ='Morocco/Casablanca' date +%m)
year=$(TZ='Morocco/Casablanca' date +%Y)

# Combine values into a tab-delimited record
record=$(echo -e "$year\t$month\t$day\t$obs_temp\t$fc_temp C")

# Append record to log file
echo $record >> rx_poc.log
echo "Weather data appended to rx_poc.log"




# To Test:

# Make sure the script is executable:

# chmod u+x rx_poc_1.sh

# Run the script:

# ./rx_poc_1.sh

# View the contents of your log file:

# cat rx_poc_1.log

# You should now see a row with year, month, day, current temperature, and tomorrow's forecast appended to rx_poc.log.