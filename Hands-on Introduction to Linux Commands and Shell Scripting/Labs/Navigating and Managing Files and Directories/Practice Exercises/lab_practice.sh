#!/bin/bash

# Show current user and directory
echo "Current user: $(whoami)"
echo "Present Working Directory: $(pwd)"

# Create a new directory and navigate into it
mkdir -p ~/lab_tmp/scripts
cd ~/lab_tmp/scripts || exit

# Create and write to a file
echo "Hello! This is a test file." > hello.txt
echo "Created hello.txt with content."

# Copy the file
cp hello.txt copy_hello.txt
echo "Copied hello.txt to copy_hello.txt"

# Rename the file
mv copy_hello.txt renamed_hello.txt
echo "Renamed copy_hello.txt to renamed_hello.txt"

# Move file to parent directory
mv renamed_hello.txt ..
echo "Moved renamed_hello.txt to parent directory"

# Delete the original file
rm -i hello.txt
echo "Deleted hello.txt (if confirmed)."

# Search for .txt files in home directory
echo "Searching for .txt files in home..."
find ~ -name '*.txt' 2>/dev/null

# Show system info
echo -e "\nSystem Info:"
uname -a
id
df -h | grep '^/dev'

# List final contents
echo -e "\nFinal contents of ~/lab_tmp:"
ls -l ~/lab_tmp

# Show completion message
echo -e "\nScript finished. All operations completed."




# Instructions to Run the Script:

# Save the script:

# nano lab_practice.sh

# Paste the script, save with CTRL+X, then Y, then Enter.

# Make it executable:

# chmod +x lab_practice.sh

# Run the script:

# ./lab_practice.sh