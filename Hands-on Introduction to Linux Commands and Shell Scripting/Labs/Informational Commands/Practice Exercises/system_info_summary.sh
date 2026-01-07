#!/bin/bash

echo "====== System Info Lab Summary ======"
echo

echo "[1] Username (whoami):"
whoami
echo

echo "[2] Kernel Name (uname):"
uname
echo

echo "[3] Full System Info (uname -a):"
uname -a
echo

echo "[4] User and Group ID (id):"
id
echo

echo "[5] Disk Space (df -h):"
df -h
echo

echo "[6] Running Processes (ps -e):"
ps -e | head -10  # display first 10 lines for brevity
echo "... (truncated)"
echo

echo "[7] Top Table of Processes (top -n 1):"
top -n 1 | head -15  # run top once, show first 15 lines
echo "... (truncated)"
echo

echo "[8] Echo Example (echo -e):"
echo -e "Hello from echo!\nThis is a new line."
echo

echo "[9] Current Date and Time:"
date
echo

echo "[10] How to Access Manual (man <command>):"
echo "Example: man ls"
echo "Note: Press 'q' to exit man pages."
echo

echo "====== End of Summary ======"


# To Use:

# Create the script:

# nano system_info_summary.sh

# Paste the script, then save with CTRL+X, Y, Enter.

# Make it executable:

# chmod +x system_info_summary.sh

# Run it:

# ./system_info_summary.sh