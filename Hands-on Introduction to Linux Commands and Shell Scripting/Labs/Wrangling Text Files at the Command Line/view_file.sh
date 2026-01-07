#!/bin/bash

echo "📂 Enter the path to the file you want to view:"
read filepath

# Check if the file exists
if [[ ! -f "$filepath" ]]; then
  echo "❌ File not found: $filepath"
  exit 1
fi

echo "🔍 Choose how to view the file:"
echo "1. cat (entire file at once)"
echo "2. more (view one page at a time)"
echo "3. less (scroll freely up/down)"
read -p "Enter choice (1/2/3): " choice

case $choice in
  1)
    echo "📄 Displaying file with cat..."
    cat "$filepath"
    ;;
  2)
    echo "📄 Displaying file with more..."
    more "$filepath"
    ;;
  3)
    echo "📄 Displaying file with less..."
    less "$filepath"
    ;;
  *)
    echo "⚠️ Invalid choice. Exiting."
    exit 1
    ;;
esac



# How to use it:

# Save it:


# nano view_file.sh

# Paste the script into nano, save with CTRL+O, then exit with CTRL+X.

# Make it executable:

# chmod +x view_file.sh

# Run it:


# ./view_file.sh
