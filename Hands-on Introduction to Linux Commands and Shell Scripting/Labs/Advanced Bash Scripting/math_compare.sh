#!/bin/bash
# This script performs arithmetic on two integers and compares the results

# Prompt the user for input
echo -n "🔢 Enter an integer: "
read n1
echo -n "🔢 Enter another integer: "
read n2

# Perform arithmetic operations
sum=$((n1 + n2))
product=$((n1 * n2))

# Output the results
echo "➕ The sum of $n1 and $n2 is: $sum"
echo "✖️ The product of $n1 and $n2 is: $product"

# Compare and display a logical result
if [ $sum -lt $product ]; then
    echo "📉 The sum is less than the product."
elif [ $sum -eq $product ]; then
    echo "⚖️ The sum is equal to the product."
else
    echo "📈 The sum is greater than the product."
fi



# To create, save, and run the script:

# Create the file:

# nano math_compare.sh

# Paste the script above, then save and exit (Ctrl+O, Enter, then Ctrl+X).

# Make it executable:

# chmod +x math_compare.sh

# Run it:

# ./math_compare.sh