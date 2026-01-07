#!/bin/bash

echo "📁 Ensuring we are in the home directory..."
cd ~ || exit
pwd

echo -e "\n🔢 1. Counting number of lines in /etc/passwd:"
wc -l /etc/passwd

echo -e "\n🔍 2. Searching for lines with 'not installed' in /var/log/bootstrap.log:"
grep "not installed" /var/log/bootstrap.log

echo -e "\n⬇️ 3. Downloading top-sites.txt and finding lines with 'org':"
wget -q https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/top-sites.txt
grep org top-sites.txt

echo -e "\n📄 4. First 7 lines of top-sites.txt:"
head -n 7 top-sites.txt

echo -e "\n📄 5. Last 7 lines of top-sites.txt:"
tail -n 7 top-sites.txt

echo -e "\n🔠 6. First 3 characters of each line in top-sites.txt:"
cut -c -3 top-sites.txt

echo -e "\n📇 7. Extracting names from names_and_numbers.csv (first column only):"
cd /home/project || exit
cut -d "," -f1 names_and_numbers.csv

echo -e "\n✅ Practice tasks complete!"


# How to Run This Script

# Create the script file:

# nano ~/text_practice_summary.sh

# Paste the script, then press CTRL+O to save and CTRL+X to exit.

# Make it executable:

# chmod +x text_practice_summary.sh

# Run it:


# ./text_practice_summary.sh