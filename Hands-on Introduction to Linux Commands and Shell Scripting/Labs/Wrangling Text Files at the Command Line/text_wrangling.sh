#!/bin/bash

echo "📂 Navigating to /home/project..."
cd /home/project || exit

### PART 1: SORTING usdoi.txt
FILE1="usdoi.txt"

# Check and download usdoi.txt if needed
if [[ ! -f "$FILE1" ]]; then
  echo "⬇️ Downloading $FILE1..."
  wget -q https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/usdoi.txt
fi

echo -e "\n🔡 Sorting lines of $FILE1 alphabetically:"
sort "$FILE1" | head -n 10

echo -e "\n🔁 Sorting lines of $FILE1 in reverse order:"
sort -r "$FILE1" | head -n 10

### PART 2: UNIQ with zoo.txt
FILE2="zoo.txt"

# Download zoo.txt
if [[ ! -f "$FILE2" ]]; then
  echo "⬇️ Downloading $FILE2..."
  wget -q https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-LX0117EN-SkillsNetwork/labs/module%201/zoo.txt
fi

echo -e "\n📄 Contents of $FILE2:"
cat "$FILE2"

echo -e "\n🧹 Contents of $FILE2 with consecutive duplicates removed:"
uniq "$FILE2"

echo -e "\n✅ Text wrangling complete!"





# How to Run

# Create the script:


# nano text_wrangling.sh

# Paste the script above, save with CTRL+O, then exit with CTRL+X.

# Make it executable:


# chmod +x text_wrangling.sh

# Run it:


# ./text_wrangling.sh