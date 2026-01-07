#!/bin/bash

echo "=============================================="
echo "Linux Navigation Practice - Exercises 1 to 5"
echo "=============================================="
echo

# Exercise 1
echo "Exercise 1: List the contents of the root directory"
echo "---------------------------------------------------"
echo "Command: ls /"
ls /
echo
read -p "✅ Press Enter to continue to Exercise 2..."

# Exercise 2
echo
echo "Exercise 2: Change to your home directory"
echo "----------------------------------------"
echo "Command: cd ~"
cd ~
echo "✅ Now in your home directory."
echo
read -p "✅ Press Enter to continue to Exercise 3..."

# Exercise 3
echo
echo "Exercise 3: Verify your current working directory"
echo "-------------------------------------------------"
echo "Command: pwd"
pwd
echo
read -p "✅ Press Enter to continue to Exercise 4..."

# Exercise 4
echo
echo "Exercise 4: Use tab completion to change directory to /bin"
echo "-----------------------------------------------------------"
echo "🧠 This step must be done manually in your terminal."
echo "   Try typing: cd /b and press [TAB] twice."
echo "   You'll see: bin/  boot/"
echo "   Then type: cd /bi and press [TAB] → should autocomplete to: cd /bin"
echo
read -p "✅ Try it manually, then press Enter to continue to Exercise 5..."

# Exercise 5
echo
echo "Exercise 5: Use your terminal history to go back to home"
echo "---------------------------------------------------------"
echo "🧠 Press the [UP ARROW] key until you see: cd ~"
echo "   Then press [Enter] to run it."
echo "   This is how you use your shell's command history."
echo
echo "✅ Done! You've completed the basic Linux navigation exercises."

# # Instructions to Use

# # Save the script:


# nano linux_navigation_practice.sh

# # Make it executable:

# chmod +x linux_navigation_practice.sh

# # Run it:

# ./linux_navigation_practice.sh