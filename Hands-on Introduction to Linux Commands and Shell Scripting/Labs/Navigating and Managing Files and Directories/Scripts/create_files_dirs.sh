#!/bin/bash

echo "==============================="
echo " Exercise 2 - Files & Directories"
echo "==============================="
echo

# 2.1 Create a directory
echo "[2.1] Creating directory 'scripts'..."
mkdir -p scripts
echo "Verifying with ls:"
ls
echo

# 2.2 Change into 'scripts' directory
echo "[2.2] Changing into 'scripts' directory..."
cd scripts
echo "Current directory (pwd):"
pwd
echo

# Go back to home using 'cd' with no args
echo "Returning to home directory using 'cd'..."
cd
echo "Current directory (pwd):"
pwd
echo

# Go back one level from current directory
echo "Moving up one level with 'cd ..'..."
cd ..
echo "Current directory (pwd):"
pwd
echo

# 2.3 Create an empty file
echo "[2.3] Returning to home directory..."
cd
echo "Creating empty file 'myfile.txt'..."
touch myfile.txt
echo "Verifying file creation with ls:"
ls
echo

# Update timestamp
echo "Updating file timestamp..."
touch myfile.txt
echo "Last modified date of 'myfile.txt':"
date -r myfile.txt
echo

echo "==============================="
echo " End of Script"
echo "==============================="




# To Run the Script:

# Create the file:

# nano create_files_dirs.sh

# Paste the script content above.

# Save and exit (CTRL + X, then Y, then Enter).

# Make it executable:

# chmod +x create_files_dirs.sh

# Run it:

# ./create_files_dirs.sh