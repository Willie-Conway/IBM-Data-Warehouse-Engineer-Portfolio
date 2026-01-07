#!/bin/bash

echo "==============================="
echo " Exercise 1 - Files & Directories"
echo "==============================="
echo

# 1.1 Present working directory
echo "[1.1] Present Working Directory (pwd):"
pwd
echo

# 1.2 List current directory
echo "[1.2] List contents of current directory (ls):"
ls
echo

# List contents of /bin
echo "[1.3] List files in /bin (ls /bin):"
ls /bin
echo

# Check if 'ls' exists in /bin
echo "[1.4] Check if /bin/ls exists:"
ls /bin/ls
echo

# List all files in /bin starting with 'b'
echo "[1.5] List all files in /bin starting with 'b' (ls /bin/b*):"
ls /bin/b*
echo

# List all files in /bin ending in 'r'
echo "[1.6] List all files in /bin ending with 'r' (ls /bin/*r):"
ls /bin/*r
echo

# Long format listing
echo "[1.7] Long listing format (ls -l):"
ls -l
echo

# Descriptive list of options
echo "[1.8] All files including hidden in /etc (ls -la /etc):"
ls -la /etc | head -20  # limit output for readability
echo "...(output truncated)"
echo

echo "==============================="
echo " End of Script"
echo "==============================="



# How to Use:

# Create the script:

# nano navigate_files_dirs.sh

# Paste the above code into the terminal editor.

# Save and exit (CTRL + X, then Y, then Enter).

# Make it executable:

# chmod +x navigate_files_dirs.sh

# Run the script:


# ./navigate_files_dirs.sh