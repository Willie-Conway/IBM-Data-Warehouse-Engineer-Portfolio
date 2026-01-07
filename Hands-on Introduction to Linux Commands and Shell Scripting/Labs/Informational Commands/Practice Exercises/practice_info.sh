#!/bin/bash

echo "============================"
echo "1. OS Information"
echo "----------------------------"
uname
echo

echo "============================"
echo "2. All Running Processes"
echo "----------------------------"
ps -e
echo

echo "============================"
echo "3. Table of Processes (Sorted by Memory)"
echo "----------------------------"
echo "NOTE: Running 'top' now. Press Shift + M to sort by memory usage."
echo "      Press 'q' to exit top."
top
echo

echo "============================"
echo "4. Current Time"
echo "----------------------------"
date "+%T"
echo

echo "============================"
echo "5. Echo Messages with New Line"
echo "----------------------------"
echo -e "Hello! \nGoodbye!"
echo




# To Use:

# Create the script:

# nano practice_info.sh

# Paste the script, then save with CTRL+X, Y, Enter.

# Make it executable:


# chmod +x practice_info.sh


# Run the script:

# ./practice_info.sh
