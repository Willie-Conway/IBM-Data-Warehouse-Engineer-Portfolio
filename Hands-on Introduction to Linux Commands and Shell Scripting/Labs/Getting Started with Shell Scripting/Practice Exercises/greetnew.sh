#!/bin/bash
# This script accepts the user's first and last names
# and prints a personalized greeting

# Prompt for first name
echo -n "Enter your firstname: "
read firstname

# Prompt for last name
echo -n "Enter your lastname: "
read lastname

# Display greeting
echo "Hello $firstname $lastname."




# Steps to run it:

# Create the file:

# Paste the script above, then save and exit (in nano: Ctrl+O, Enter, Ctrl+X).

# Make it executable:

# chmod u+x greetnew.sh

# Run the script:

# ./greetnew.sh