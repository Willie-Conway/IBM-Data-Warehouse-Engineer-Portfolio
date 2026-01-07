#!/bin/bash

echo "======================"
echo "1.1 Current User:"
echo "----------------------"
whoami
echo

echo "======================"
echo "1.2 OS Information:"
echo "----------------------"
uname
uname -a
echo

echo "======================"
echo "1.3 User & Group Info:"
echo "----------------------"
id
echo

echo "======================"
echo "1.4 Disk Space:"
echo "----------------------"
df
echo "----------------------"
df -h
echo

echo "======================"
echo "1.5 Running Processes (User):"
echo "----------------------"
ps
echo "----------------------"
echo "Running Processes (All):"
ps -e
echo

echo "======================"
echo "1.6 Top Processes (Once):"
echo "----------------------"
top -n 1
echo

echo "======================"
echo "1.7 Echo Output Demo:"
echo "----------------------"
echo "Welcome to the linux lab"
echo -e "This will be printed \nin two lines"
echo -e "Column1\tColumn2\tColumn3"
echo

echo "======================"
echo "1.8 Date and Time:"
echo "----------------------"
date
date "+%D"
date "+%T"
echo

echo "======================"
echo "1.9 Manual for 'ls':"
echo "----------------------"
man ls | head -n 20  # Show only top 20 lines
echo "...(manual continues, press 'q' if running manually)..."
echo

echo "✅ All informational commands executed."


# How to Use:

# Create the script file:

# nano info_commands.sh


# Make it executable:

# chmod +x info_commands.sh

# Run it:

# ./info_commands.sh