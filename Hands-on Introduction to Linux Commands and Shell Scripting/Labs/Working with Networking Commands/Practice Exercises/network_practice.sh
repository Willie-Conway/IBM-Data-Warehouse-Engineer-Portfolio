#!/bin/bash

# network_practice.sh - Practice script for network commands

echo "📍 Step 1: Navigating to /home/project"
cd /home/project || exit
pwd

# Step 1: Display your host's IP address
echo -e "\n🌐 Step 2: Displaying host IP address:"
hostname -i

# Step 2: Get connectivity stats to www.google.com (limit to 4 pings)
echo -e "\n📶 Step 3: Testing connectivity to www.google.com (4 pings):"
ping -c 4 www.google.com

# Step 3: View info about the ethernet adapter eth0
echo -e "\n🧰 Step 4: Displaying info about ethernet adapter eth0:"
ip addr show eth0

# Step 4: View HTML code for www.google.com
echo -e "\n📄 Step 5: Viewing HTML source of www.google.com"
curl www.google.com

# Step 5: Download HTML code using wget
echo -e "\n💾 Step 6: Downloading HTML landing page from www.google.com"
wget www.google.com

# Step 6: Confirm downloaded file
echo -e "\n📁 Step 7: Verifying file was saved (should be index.html):"
ls -l index.html


# To Use the Script:

# Create the file:

# nano network_practice.sh

# Paste the script, save (Ctrl+O, Enter), and exit (Ctrl+X).

# Make it executable:

# chmod +x network_practice.sh

# Run it:

# ./network_practice.sh