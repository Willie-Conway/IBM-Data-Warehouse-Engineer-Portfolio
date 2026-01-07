#!/bin/bash

echo "==============================="
echo " Step 1.1: Current Directory "
echo "==============================="
pwd
echo
echo "Contents of current directory:"
ls
echo

echo "=================================="
echo " Step 1.2: Root Directory / "
echo "=================================="
ls /
echo

echo "=================================="
echo " Step 1.3: /bin (System Commands)"
echo "=================================="
ls /bin
echo

echo "=================================="
echo " Step 1.4: /sbin (Admin Tools)"
echo "=================================="
ls /sbin
echo

echo "=================================="
echo " Step 1.5: /usr (User Programs)"
echo "=================================="
ls /usr
echo

echo "=================================="
echo " Step 1.6: /home (Home Folders)"
echo "=================================="
ls /home
echo

echo "=================================="
echo " Step 1.7: /media (External Drives)"
echo "=================================="
ls /media
echo

echo "=================================="
echo " Bonus: Long Format View of Root /"
echo "=================================="
ls -l /
echo

echo "Script finished."


# How to Use:

# # Save the above code into a file:

# nano browse_dirs.sh

# # Make it executable:

# chmod +x browse_dirs.sh

# Run it:

# ./browse_dirs.sh