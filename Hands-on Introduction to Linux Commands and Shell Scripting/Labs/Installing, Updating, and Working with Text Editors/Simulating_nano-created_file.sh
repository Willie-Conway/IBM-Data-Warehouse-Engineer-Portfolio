#!/bin/bash

echo "==========================================="
echo "Exercise 2 - Creating and Editing Files with nano"
echo "==========================================="

# Step 1: Navigate to /home/project
echo
echo "Step 1: Changing directory to /home/project..."
cd /home/project || { echo "❌ Failed to change directory to /home/project"; exit 1; }
echo "✅ Current directory: $(pwd)"

# Step 2: Create and edit file (simulated instead of interactive nano)
echo
echo "Step 2: Creating and writing to hello_world.txt..."
cat <<EOF > hello_world.txt
Hello world!
This is the second line of my first-ever text file created with nano.
EOF
echo "✅ File hello_world.txt created with sample content."

# Step 3: Verifying contents
echo
echo "Step 3: Verifying the content of hello_world.txt..."
echo "-------------------------------------------"
cat hello_world.txt
echo "-------------------------------------------"
echo "✅ Verification complete."

echo
echo "🎉 Exercise complete!"


#  How to Use the Script

# Save the script to a file:

# nano Simulating_nano-created_file.sh

# Make it executable:

# chmod +x Simulating_nano-created_file.sh

# Run it:

# ./Simulating_nano-created_file.sh