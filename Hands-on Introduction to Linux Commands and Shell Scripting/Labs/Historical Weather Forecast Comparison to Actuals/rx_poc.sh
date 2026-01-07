#!/bin/bash

# Script to fetch raw weather data for Casablanca

# Assign city name
city=Casablanca

# Download weather data silently and save to file
curl -s wttr.in/$city?T --output weather_report

# Notify user
echo "Weather report for $city saved to weather_report"



# Setup & Run Instructions:

# Create the script file:

# nano rx_poc.sh

# Paste the script above into the editor. Save and exit (Ctrl + X, then Y, then Enter).

# Make it executable:

# chmod u+x rx_poc.sh

# Run it:

# ./rx_poc.sh

