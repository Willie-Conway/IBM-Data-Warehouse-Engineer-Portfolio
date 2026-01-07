#!/bin/bash

# This script initializes the rx_poc.log weather report file

# Define the log file name
logfile="rx_poc.log"

# Define the header row with tab-separated fields
header=$(echo -e "year\tmonth\tday\tobs_temp\tfc_temp")

# Create the log file and write the header
echo "$header" > "$logfile"

# Confirm creation
echo "Log file '$logfile' initialized with header:"
cat "$logfile"



# To use it:

# Save the script to a file:

# nano init_rx_poc_log.sh

# Paste the script, then save and exit.

# Make it executable:

# chmod +x init_rx_poc_log.sh

# Run the script:

# ./init_rx_poc_log.sh