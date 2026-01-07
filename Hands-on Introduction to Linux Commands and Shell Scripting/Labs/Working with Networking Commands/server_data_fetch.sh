#!/bin/bash

# server_data_fetch.sh - View and download data from a server using curl and wget

URL="https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/usdoi.txt"
FILENAME="usdoi.txt"

echo "📥 Fetching from: $URL"
echo "--------------------------------------------"

# 1. Use curl to view contents
echo -e "\n🔎 Viewing file content with curl:"
curl $URL

# 2. Use curl -O to download the file
echo -e "\n💾 Downloading file using curl..."
curl -O $URL

# 3. Verify file exists
if [ -f "$FILENAME" ]; then
  echo "✅ File '$FILENAME' downloaded successfully using curl."
else
  echo "❌ Failed to download file with curl."
fi

# 4. Remove file for wget demo
echo -e "\n🗑️ Removing file to demonstrate wget download..."
rm -f $FILENAME

# 5. Download file using wget
echo -e "\n🌐 Downloading file again using wget..."
wget $URL

# 6. Final check
if [ -f "$FILENAME" ]; then
  echo "✅ File '$FILENAME' downloaded successfully using wget."
else
  echo "❌ Failed to download file with wget."
fi


# How to Run the Script:

# Create the script file:

# nano server_data_fetch.sh

# Paste the script, save (Ctrl+O, Enter), and exit (Ctrl+X).

# Make it executable:

# chmod +x server_data_fetch.sh

# Run it:

# ./server_data_fetch.sh