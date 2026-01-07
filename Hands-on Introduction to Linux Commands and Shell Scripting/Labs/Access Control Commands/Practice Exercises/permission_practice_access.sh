#!/bin/bash

echo "➡️ Navigating to /home/project"
cd /home/project || exit

echo -e "\n📄 Checking initial permissions of usdoi.txt:"
ls -l usdoi.txt

echo -e "\n✂️ Revoking user write permission on usdoi.txt..."
chmod u-w usdoi.txt
ls -l usdoi.txt

echo -e "\n❌ Attempting to delete write-protected usdoi.txt..."
rm usdoi.txt

echo -e "\n🔍 Verifying deletion of usdoi.txt..."
ls usdoi.txt 2>/dev/null || echo "✅ usdoi.txt successfully deleted."

echo -e "\n📁 Creating tmp_dir in home directory..."
cd ~ || exit
mkdir -p tmp_dir

echo -e "\n🔍 Viewing permissions of tmp_dir:"
ls -ld tmp_dir

echo -e "\n✂️ Revoking user write permission on tmp_dir..."
chmod u-w tmp_dir
ls -ld tmp_dir

echo -e "\n🚶 Attempting to create sub_dir inside tmp_dir..."
mkdir tmp_dir/sub_dir 2>/dev/null || echo "❌ Permission denied as expected."

echo -e "\n🏁 Practice complete."



# Instructions to Run:

# Open terminal.

# Navigate to your home directory:

# cd ~

# Create the script file:


# nano permission_practice_access.sh

# Paste the full script above, then press Ctrl + X, then Y, then Enter.

# Make it executable:

# chmod +x permission_practice_access.sh

# Run the script:

# ./permission_practice_access.sh
