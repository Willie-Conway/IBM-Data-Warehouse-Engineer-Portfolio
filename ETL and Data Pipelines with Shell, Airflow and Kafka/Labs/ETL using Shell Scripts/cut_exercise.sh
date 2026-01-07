#!/bin/bash

echo "Exercise 1 - Extracting data using 'cut' command"
echo

# Extracting characters
echo "Extracting characters from the word 'database':"

# First 4 characters
echo -n "First 4 characters: "
echo "database" | cut -c1-4

# 5th to 8th characters
echo -n "5th to 8th characters: "
echo "database" | cut -c5-8

# 1st and 5th characters
echo -n "1st and 5th characters: "
echo "database" | cut -c1,5

echo
echo "Extracting fields from /etc/passwd file:"
echo

# Extract usernames (1st field)
echo "Usernames (1st field):"
cut -d":" -f1 /etc/passwd | head

# Extract 1st, 3rd, and 6th fields (username, userid, home directory)
echo
echo "Username, User ID, and Home Directory (fields 1, 3, and 6):"
cut -d":" -f1,3,6 /etc/passwd | head

# Extract 3rd to 6th fields (userid, groupid, description, home directory)
echo
echo "User ID to Home Directory (fields 3 to 6):"
cut -d":" -f3-6 /etc/passwd | head

echo
echo "Exercise complete."



# How to use:

# Save it as cut_exercise.sh

# Make it executable:

# chmod +x cut_exercise.sh

# Run it:

# ./cut_exercise.sh