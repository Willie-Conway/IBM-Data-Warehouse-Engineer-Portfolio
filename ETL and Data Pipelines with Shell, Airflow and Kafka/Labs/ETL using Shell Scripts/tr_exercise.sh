#!/bin/bash

echo "Exercise 2 - Transforming data using 'tr'"

# Translate lowercase to uppercase
echo -e "\n1. Translate lowercase to uppercase:"
echo "Shell Scripting" | tr '[a-z]' '[A-Z]'

# Using predefined character sets
echo -e "\n2. Translate lowercase to uppercase using predefined character sets:"
echo "Shell Scripting" | tr '[:lower:]' '[:upper:]'

# Translate uppercase to lowercase
echo -e "\n3. Translate uppercase to lowercase:"
echo "Shell Scripting" | tr '[A-Z]' '[a-z]'

# Squeeze repeated spaces
echo -e "\n4. Squeeze repeated spaces in 'ps' output:"
ps | tr -s " "

# Delete digits from a string
echo -e "\n5. Delete digits from string:"
echo "My login pin is 5634" | tr -d "[:digit:]"


# To run this script:

# Save it as tr_exercise.sh

# Make it executable:

# chmod +x tr_exercise.sh

# Run it:

# ./tr_exercise.sh