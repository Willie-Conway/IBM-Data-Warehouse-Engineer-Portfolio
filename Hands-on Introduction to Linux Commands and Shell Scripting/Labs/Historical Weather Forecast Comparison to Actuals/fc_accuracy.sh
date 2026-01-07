#!/bin/bash

# Extract yesterday's forecasted temperature (from second-to-last row)
yesterday_fc=$(tail -2 rx_poc.log | head -1 | cut -f5 | cut -d ' ' -f1)

# Extract today's observed temperature (from last row)
today_temp=$(tail -1 rx_poc.log | cut -f4)

# Compute accuracy (difference between forecast and observed)
accuracy=$((yesterday_fc - today_temp))
echo "Forecast difference: $accuracy"

# Determine accuracy range
if [ $accuracy -ge -1 ] && [ $accuracy -le 1 ]; then
    accuracy_range="excellent"
elif [ $accuracy -ge -2 ] && [ $accuracy -le 2 ]; then
    accuracy_range="good"
elif [ $accuracy -ge -3 ] && [ $accuracy -le 3 ]; then
    accuracy_range="fair"
else
    accuracy_range="poor"
fi

echo "Forecast accuracy is: $accuracy_range"

# Extract date and log entry values from today's row
row=$(tail -1 rx_poc.log)
year=$(echo -e "$row" | cut -f1)
month=$(echo -e "$row" | cut -f2)
day=$(echo -e "$row" | cut -f3)

# Append results to accuracy report
echo -e "$year\t$month\t$day\t$today_temp\t$yesterday_fc\t$accuracy\t$accuracy_range" >> historical_fc_accuracy.tsv





# Setup Instructions

# Create the script file:


# touch fc_accuracy.sh

# nano fc_accuracy.sh   # or open in VS Code or GUI editor

# Paste the script above into fc_accuracy.sh.




# Make it executable:

# chmod +x fc_accuracy.sh

# Create the report file with header (only once):

# echo -e "year\tmonth\tday\tobs_temp\tfc_temp\taccuracy\taccuracy_range" > historical_fc_accuracy.tsv

# Test the Script

# Ensure you have at least 2 days of data in rx_poc.log or manually add sample rows like this for testing:


# echo -e "2025\t07\t09\t26\t28 C" >> rx_poc.log
# echo -e "2025\t07\t10\t27\t29 C" >> rx_poc.log



# Then run:

# ./fc_accuracy.sh

# Check your historical_fc_accuracy.tsv:

# cat historical_fc_accuracy.tsv
