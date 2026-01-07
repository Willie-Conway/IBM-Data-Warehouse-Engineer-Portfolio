#!/bin/bash

echo "=========================================="
echo "Exercise 1 - Upgrading and Installing Packages"
echo "=========================================="

# Step 1: Update package index
echo
echo "Step 1: Updating package list index..."
echo "Command: sudo apt update"
sudo apt update
echo "✅ Package list updated."

# Step 2: Upgrade nano
echo
echo "Step 2: Upgrading nano to the latest version..."
echo "Command: sudo apt upgrade nano"
sudo apt upgrade nano -y
echo "✅ nano upgraded."

# Step 3: Install Vim
echo
echo "Step 3: Installing Vim text editor..."
echo "Command: sudo apt install vim"
sudo apt install vim -y
echo "✅ Vim installed."

echo
echo "🎉 All tasks complete!"


# How to Use the Script

# Save the script to a file:

# nano apt_upgrade_install.sh

# Make it executable:

# chmod +x apt_upgrade_install.sh

# Run it:

# ./apt_upgrade_install.sh