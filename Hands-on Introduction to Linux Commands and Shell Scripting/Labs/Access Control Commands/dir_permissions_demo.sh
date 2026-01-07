#!/bin/bash

echo "➡️  Navigating to /home/project"
cd /home/project || exit

echo "📁 Creating test directory..."
mkdir -p test

echo -e "\n📋 Viewing default permissions for 'test' directory:"
ls -ld test

echo -e "\n📁 Creating test2 directory inside 'test'..."
cd test && mkdir -p test2
cd ..

echo -e "\n🚫 Removing execute permission for user on 'test'..."
chmod u-x test

echo "❌ Attempting to cd into test (should fail)..."
cd test 2>/dev/null || echo "Permission denied as expected."

echo -e "\n🔎 Listing 'test' directory contents (still allowed):"
ls -l

echo -e "\n❌ Attempting to create a new directory test/test3 (should fail)..."
mkdir test/test3 2>/dev/null || echo "Cannot create directory: Permission denied."

echo -e "\n✅ Restoring execute permission for user and removing write permission on 'test'..."
chmod u+x test
chmod u-w test
ls -ld test

echo -e "\n🚶 Entering test and attempting to create 'test_again' directory (should fail)..."
cd test && mkdir test_again 2>/dev/null || echo "Still can't create directory: Permission denied."
cd ..

echo -e "\n🏁 Exercise complete!"




# To Use the Script

# Open your terminal and move to your home directory:


# cd ~
# Create the script file:


# nano dir_permissions_demo.sh

# Paste the script above into the nano editor. Then press Ctrl + X, then Y, then Enter to save.

# Make the script executable:


# chmod +x dir_permissions_demo.sh

# Run the script:


# ./dir_permissions_demo.sh
