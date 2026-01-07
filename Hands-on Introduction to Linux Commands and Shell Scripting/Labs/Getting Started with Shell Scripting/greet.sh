#!/bin/bash

# This script accepts the user's name and prints 
# a message greeting the user

# Print the prompt message on screen
echo -n "Enter your name : "

# Wait for user to enter a name, and save the entered name into the variable 'name'
read name

# Print the welcome message followed by the name
echo "Welcome $name"

# The following message should print on a single line. Hence the usage of '-n'
echo -n "Congratulations! You just created and ran your first shell script "
echo "using Bash on IBM Skills Network"




# How to Run This Script

# Create the file

# In the IDE:

# File → New File → Name it greet.sh

# Paste the script above and then save it (File → Save)

# Open a terminal

# Terminal → New Terminal

# Make it executable (optional)


# chmod +x greet.sh

# Run the script

# You can run it either way:


# bash greet.sh

# or, if made executable:

# ./greet.sh
