#!/bin/bash

echo "📥 Navigating to /home/project and downloading usdoi.txt..."
cd /home/project || exit
wget -q https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/usdoi.txt

# Check if download succeeded
if [[ ! -f "usdoi.txt" ]]; then
  echo "❌ Failed to download usdoi.txt."
  exit 1
fi

echo -e "\n✅ File downloaded successfully!"

echo -e "\n🔹 First 10 lines of usdoi.txt (default head):"
head usdoi.txt

echo -e "\n🔹 First 3 lines of usdoi.txt:"
head -3 usdoi.txt

echo -e "\n🔹 Last 10 lines of usdoi.txt (default tail):"
tail usdoi.txt

echo -e "\n🔹 Last 2 lines of usdoi.txt:"
tail -2 usdoi.txt

echo -e "\n✅ Done viewing file content with head and tail!"





# How to Use It:

# Create the script:


# nano view_lines.sh

# Paste the script above, save with CTRL+O, and exit with CTRL+X.

# Make it executable:


# chmod +x view_lines.sh

# Run it:


# ./view_lines.sh