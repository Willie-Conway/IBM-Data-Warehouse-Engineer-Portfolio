#!/bin/bash

echo "==============================="
echo " Exercise 3 - File Management"
echo "==============================="

# 3.1 Search for and locate files
echo
echo "[3.1] Searching for .txt files in /etc..."
find /etc -name '*.txt' 2>/dev/null | head -n 5

echo
echo "Searching for .conf files in /etc..."
find /etc -name '*.conf' 2>/dev/null | head -n 5

# 3.2 Remove a file
echo
echo "[3.2] Creating file 'myfile.txt' for deletion test..."
touch myfile.txt
echo "Attempting to remove 'myfile.txt'..."
rm -f myfile.txt
echo "Verifying deletion:"
ls | grep myfile.txt || echo "myfile.txt has been removed."

# 3.3 Move and rename a file
echo
echo "[3.3] Creating file 'users.txt'..."
touch users.txt
echo "Renaming 'users.txt' to 'user-info.txt'..."
mv users.txt user-info.txt
echo "Verifying rename:"
ls | grep user-info.txt

echo "Moving 'user-info.txt' to /tmp..."
mv user-info.txt /tmp
echo "Verifying move:"
ls | grep user-info.txt || echo "user-info.txt moved successfully."
ls -l /tmp | grep user-info.txt

# 3.4 Copy files
echo
echo "[3.4] Copying 'user-info.txt' back from /tmp to current dir..."
cp /tmp/user-info.txt user-info.txt
echo "Verifying copy:"
ls | grep user-info.txt

echo "Copying contents of /etc/passwd to 'users.txt'..."
cp /etc/passwd users.txt
echo "Verifying 'users.txt' exists:"
ls | grep users.txt

echo
echo "==============================="
echo " End of Exercise 3 Script"
echo "==============================="



# How to Use This Script

# Open terminal and create the script:

# nano manage_files_dirs.sh

# Paste the script above into the editor.

# Save and exit: CTRL + X, then Y, then Enter.

# Make the script executable:

# chmod +x manage_files_dirs.sh

# Run it:

# ./manage_files_dirs.sh