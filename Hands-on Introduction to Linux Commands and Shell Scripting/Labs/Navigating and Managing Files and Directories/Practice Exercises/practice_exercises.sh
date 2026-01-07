#!/bin/bash

echo "==============================="
echo " Practice Exercises Automation"
echo "==============================="

# 1. Display the contents of the /home directory
echo
echo "[1] Listing contents of /home:"
ls /home

# 2. Ensure that you are in your home directory
echo
echo "[2] Navigating to home directory and verifying:"
cd
pwd

# 3. Create a new directory called tmp and verify
echo
echo "[3] Creating tmp directory and listing contents:"
mkdir -p tmp
ls

# 4. Create empty file display.sh in tmp and verify
echo
echo "[4] Creating display.sh in tmp and listing details:"
cd tmp
touch display.sh
ls -l

# 5. Copy display.sh to report.sh
echo
echo "[5] Copying display.sh to report.sh:"
cp display.sh report.sh
ls -l

# 6. Move report.sh to parent directory
echo
echo "[6] Moving report.sh to parent directory:"
mv report.sh ../
echo "In current (tmp) directory:"
ls
echo "In parent (home) directory:"
ls ../

# 7. Delete display.sh
echo
echo "[7] Deleting display.sh:"
rm -f display.sh
ls || echo "display.sh deleted"

# 8. List files in /etc by ascending access time
echo
echo "[8] Listing /etc by ascending access time:"
ls -ltr /etc/ | head -n 10

# 9. Copy /var/log/bootstrap.log to current directory
echo
echo "[9] Copying /var/log/bootstrap.log to current directory:"
cp /var/log/bootstrap.log .
echo "Verifying copy:"
ls -l | grep bootstrap.log

echo
echo "==============================="
echo " All Practice Tasks Completed!"
echo "==============================="




# How to Use

# Open your terminal and create the script:


# nano practice_exercises.sh

# Paste the script above into the editor.

# Save and exit: CTRL + X, then Y, then Enter.

# Make it executable:


# chmod +x practice_exercises.sh

# Run it:


# ./practice_exercises.sh