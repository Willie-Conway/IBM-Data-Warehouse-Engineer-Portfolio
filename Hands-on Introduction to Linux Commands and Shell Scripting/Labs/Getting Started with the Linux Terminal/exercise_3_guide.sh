#!/bin/bash

echo "=============================================="
echo "Exercise 3 - Using Tab Completion & History"
echo "=============================================="
echo

echo "3.1 Scrolling Through Command History"
echo "-------------------------------------"
echo "🔁 Press UP ↑ and DOWN ↓ arrow keys in your terminal to:"
echo "   - Scroll through previous commands like:"
echo "       cd /"
echo "       cd bin"
echo "       cd ../project"
echo
echo "💡 Tip: Find and re-run 'cd /bin' using ↑ key."

echo
read -p "Press Enter when you're ready to move to 3.2..."

echo
echo "3.2 Using Tab Completion"
echo "------------------------"
echo "🧠 Practice with tab completion manually:"
echo
echo "👉 Try typing: cd /bi   ...then press [TAB]"
echo "   You should see it auto-completes to: cd /bin"
echo
echo "👉 Now type: cd /b      ...and press [TAB] twice"
echo "   You should see a list like: bin/  boot/"
echo
echo "✅ Then continue typing to disambiguate: cd /bi[TAB] → cd /bin"
echo
echo "🔁 Practice navigating directory paths with [TAB]:"
echo
echo "   - Start with: ls /ho[TAB]  → /home/"
echo "   - Then:       ls /home/th[TAB]  → /home/theia/"
echo "   - Try full path: ls /home/theia/dsdriver/bin"
echo

echo "✏️ Note: This script cannot simulate Tab or Arrow keys. Use them in your terminal!"
echo
echo "✅ End of Exercise 3 Guide"


# How to Use:

# # Save it to a file:


# nano exercise_3_guide.sh

# # Make it executable:


# chmod +x exercise_3_guide.sh

# # Run it:

# ./exercise_3_guide.sh
