#!/bin/bash

echo "📁 Navigating to /home/project"
cd /home/project || exit

# 1.1 Create and manage file archives using tar
echo -e "\n📦 Creating tar archive of /bin directory..."
tar -cvf bin.tar /bin

echo -e "\n📄 Listing contents of bin.tar..."
tar -tvf bin.tar

echo -e "\n📂 Extracting bin.tar archive..."
tar -xvf bin.tar

echo -e "\n✅ Checking if 'bin' folder is extracted:"
ls -l | grep bin

# 1.2 Package and compress archive files using zip
echo -e "\n🗜️ Creating config.zip of .conf files in /etc..."
zip config.zip /etc/*.conf

echo -e "\n🗜️ Recursively zipping /bin directory into bin.zip (without following symlinks)..."
zip -ry bin.zip /bin

# 1.3 Extract, list, or test compressed files in a ZIP archive using unzip
echo -e "\n📂 Listing files inside config.zip:"
unzip -l config.zip

echo -e "\n📂 Extracting bin.zip (overwriting if needed)..."
unzip -o bin.zip

echo -e "\n✅ Checking extracted 'bin' directory:"
ls -l | grep bin


# To Use This Script:

# Create the script:

# nano archive_compress.sh

# Paste the script above, then save and exit (Ctrl + O, Enter, Ctrl + X).

# Make it executable:

# chmod +x archive_compress.sh

# Run it:

# ./archive_compress.sh