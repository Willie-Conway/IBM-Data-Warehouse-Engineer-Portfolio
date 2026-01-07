#!/bin/bash

echo "📂 Navigating to /home/project..."
cd /home/project || exit

### 5.1 - GREP (Extract lines matching a criterion)
FILE1="usdoi.txt"

# Download usdoi.txt if not present
if [[ ! -f "$FILE1" ]]; then
  echo "⬇️ Downloading $FILE1..."
  wget -q https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/usdoi.txt
fi

echo -e "\n🔍 Lines containing the word 'people':"
grep people "$FILE1"

echo -e "\n📍 Lines NOT containing 'login' from /etc/passwd:"
grep -v login /etc/passwd | head -n 5

### 5.2 - CUT (Extract fields or characters from lines)
FILE2="zoo.txt"

# Download zoo.txt if not present
if [[ ! -f "$FILE2" ]]; then
  echo "⬇️ Downloading $FILE2..."
  wget -q https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-LX0117EN-SkillsNetwork/labs/module%201/zoo.txt
fi

echo -e "\n✂️ First 2 characters of each line in $FILE2:"
cut -c -2 "$FILE2"

echo -e "\n✂️ Characters from position 2 onward in each line of $FILE2:"
cut -c 2- "$FILE2"

### Extracting fields from CSV
CSVFILE="names_and_numbers.csv"

# Download CSV if not present
if [[ ! -f "$CSVFILE" ]]; then
  echo "⬇️ Downloading $CSVFILE..."
  wget -q https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-LX0117EN-SkillsNetwork/labs/v4_new_content/labs/names_and_numbers.csv
fi

echo -e "\n📄 Extracted phone numbers from $CSVFILE:"
cut -d "," -f2 "$CSVFILE"

echo -e "\n✅ Field and line extraction complete!"



# How to Use

# Create the script:


# nano text_extracting.sh

# Paste the code, then save and exit with CTRL+O, then CTRL+X.

# Make it executable:


# chmod +x text_extracting.sh

# Run the script:


# ./text_extracting.sh