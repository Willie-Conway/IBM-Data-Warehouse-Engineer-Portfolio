#!/bin/bash

echo "📂 Navigating to /home/project..."
cd /home/project || exit

### 6.1 - Merging text files with paste

# Download zoo.txt if missing
if [[ ! -f "zoo.txt" ]]; then
  echo "⬇️ Downloading zoo.txt..."
  wget -q https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-LX0117EN-SkillsNetwork/labs/module%201/zoo.txt
fi

# Download zoo_ages.txt if missing
if [[ ! -f "zoo_ages.txt" ]]; then
  echo "⬇️ Downloading zoo_ages.txt..."
  wget -q https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-LX0117EN-SkillsNetwork/labs/module%201/zoo_ages.txt
fi

echo -e "\n🔗 Merging zoo.txt and zoo_ages.txt using TAB delimiter:"
paste zoo.txt zoo_ages.txt

echo -e "\n🔗 Merging zoo.txt and zoo_ages.txt using COMMA delimiter:"
paste -d "," zoo.txt zoo_ages.txt

echo -e "\n✅ Line merging complete!"



# How to Use

# Create the script:

# nano text_merge.sh

# Paste the code, save with CTRL+O, and exit with CTRL+X.

# Make it executable:


# chmod +x text_merge.sh

# Run the script:


# ./text_merge.sh