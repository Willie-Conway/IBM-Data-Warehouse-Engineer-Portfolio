#!/bin/bash

echo "==============================="
echo " Exercise 2 - Navigating Directories"
echo "==============================="

echo
echo "→ 2.1: Change to home directory (~)"
cd ~
pwd

echo
echo "→ 2.2: Change to parent directory (..)"
cd ..
pwd

echo
echo "→ 2.3: Change to root directory (/)"
cd /
pwd

echo
echo "→ 2.4: Change to /bin (child of root)"
cd bin
pwd

echo
echo "→ Going back to root before next step"
cd /

echo
echo "→ Try alternative path: cd ./bin from root"
cd ./bin
pwd

echo
echo "→ 2.5: Return to home directory using absolute path"
cd /home/theia
pwd

echo
echo "→ 2.5 (alternative): Return to home using ~"
cd ~
pwd

echo
echo "→ 2.6: Change from /home/theia to sibling project directory (/home/project)"
cd ../project
pwd

echo
echo "✅ Directory navigation complete."


# How to Use:

# # Save it:

# nano navigate_dirs.sh

# # Make it executable:


# chmod +x navigate_dirs.sh

# # Run it:

# ./navigate_dirs.sh