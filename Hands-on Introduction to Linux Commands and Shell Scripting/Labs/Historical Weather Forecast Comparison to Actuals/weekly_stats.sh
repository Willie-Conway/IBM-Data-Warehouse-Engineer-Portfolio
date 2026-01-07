#!/bin/bash

# Step 1: Extract the last 7 accuracy values and save to scratch.txt
tail -7 synthetic_historical_fc_accuracy.tsv | cut -f6 > scratch.txt

# Step 2: Read the values into an array
week_fc=($(cat scratch.txt))

# Step 3: Convert all values to absolute integers
for i in {0..6}; do
  # Convert negative values to positive
  if [[ ${week_fc[$i]} -lt 0 ]]; then
    week_fc[$i]=$(( -1 * ${week_fc[$i]} ))
  fi
done

# Step 4: Initialize min and max
minimum=${week_fc[0]}
maximum=${week_fc[0]}

# Step 5: Loop through array to find min and max
for item in "${week_fc[@]}"; do
  if [[ $item -lt $minimum ]]; then
    minimum=$item
  fi
  if [[ $item -gt $maximum ]]; then
    maximum=$item
  fi
done

# Step 6: Output results
echo "Minimum absolute forecast error (past 7 days): $minimum"
echo "Maximum absolute forecast error (past 7 days): $maximum"




# How to Set Up and Run

# Create the script:

# touch weekly_stats.sh

# nano weekly_stats.sh   # Or use your GUI editor
# Paste the script above into the file and save it.

# Make it executable:


# chmod +x weekly_stats.sh

# Download the dataset:


# wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBMSkillsNetwork-LX0117EN-Coursera/labs/synthetic_historical_fc_accuracy.tsv

# Run the script:

# ./weekly_stats.sh

# Output Example:

# nginx

# Minimum absolute forecast error (past 7 days): 1
# Maximum absolute forecast error (past 7 days): 4