#!/bin/bash

# Move to project directory
cd /home/project || exit

echo "Downloading usdoi.txt..."
wget -q https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-LX0117EN-SkillsNetwork/labs/module%201/usdoi.txt

echo -e "\nInitial permissions for usdoi.txt:"
ls -l usdoi.txt

echo -e "\nRevoking read permission for all users..."
chmod -r usdoi.txt
ls -l usdoi.txt

echo -e "\nGranting read permission to all users..."
chmod +r usdoi.txt
ls -l usdoi.txt

echo -e "\nRevoking read permission only for 'others'..."
chmod o-r usdoi.txt
ls -l usdoi.txt

echo -e "\n✅ Script complete. Current permissions for usdoi.txt:"
ls -l usdoi.txt




# To Use This Script:

# Open your terminal and go to your home directory:


# Create the script:

# s_practice.sh

# Paste the script above into the editor. Save with Ctrl + X, then Y, then Enter.

# Make the script executable:

# chmod +x permissions_practice.sh

# Run it:


# ./permissions_practice.sh