#!/bin/bash

echo "📂 Navigating to /home/project..."
cd /home/project || exit

# Check for the file
FILE="usdoi.txt"
if [[ ! -f "$FILE" ]]; then
  echo "❌ $FILE not found! Downloading now..."
  wget -q https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/usdoi.txt
fi

echo -e "\n📄 File: $FILE"
echo "📊 Running wc for full statistics (lines, words, characters):"
wc $FILE

echo -e "\n🔢 Number of lines:"
wc -l $FILE

echo -e "\n📝 Number of words:"
wc -w $FILE

echo -e "\n🔡 Number of characters:"
wc -c $FILE

echo -e "\n✅ Done gathering basic text file stats!"





# How to Use It

# Create the script:


# nano file_stats.sh

# Paste the script above into the editor, then save with CTRL+O and exit with CTRL+X.

# Make it executable:


# chmod +x file_stats.sh

# Run the script:


# ./file_stats.sh