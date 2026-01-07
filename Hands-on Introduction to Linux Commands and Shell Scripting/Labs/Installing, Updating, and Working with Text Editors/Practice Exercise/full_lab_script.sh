#!/bin/bash

# ----------------------------------
# Step 1: Navigate to project folder
# ----------------------------------
cd /home/project || { echo "Failed to access /home/project"; exit 1; }
echo "[✔] Navigated to /home/project"

# ----------------------------------
# Step 2: Create hello_world.txt with 3 lines
# ----------------------------------
echo "Hello world!" > hello_world.txt
echo "This is the second line of my first-ever text file created with nano." >> hello_world.txt
echo "This is line three of my new file." >> hello_world.txt
echo "[✔] Created hello_world.txt with 3 lines"

# ----------------------------------
# Step 3: Create done.txt using echo (simulating Vim entry)
# ----------------------------------
echo 'echo "I am done with the lab!"' > done.txt
echo "[✔] Created done.txt with echo command"

# ----------------------------------
# Step 4: Run done.txt using Bash
# ----------------------------------
echo "[▶] Running done.txt:"
bash done.txt

# ----------------------------------
# Step 5: Show contents of both files
# ----------------------------------
echo -e "\n📄 hello_world.txt:"
cat hello_world.txt

echo -e "\n📄 done.txt:"
cat done.txt

echo -e "\n[✅] Lab script completed successfully!"



# Instructions to Use

# Create the script:

# nano full_lab_script.sh

# Paste the entire script above. Then press CTRL+X, Y, Enter.

# Make it executable:

# chmod +x full_lab_script.sh

# Run it:

# ./full_lab_script.sh