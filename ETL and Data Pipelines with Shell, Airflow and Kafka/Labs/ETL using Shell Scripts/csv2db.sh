#!/bin/bash

# This script
# Extracts data from /etc/passwd file into a CSV file.
# The csv data file contains the user name, user id and
# home directory of each user account defined in /etc/passwd
# Transforms the text delimiter from ":" to ",".
# Loads the data from the CSV file into a table in PostgreSQL database.

# Extract phase
echo "Extracting data"
cut -d":" -f1,3,6 /etc/passwd > extracted-data.txt

# Transform phase
echo "Transforming data"
tr ":" "," < extracted-data.txt > transformed-data.csv

# Load phase
echo "Loading data"
# Set the PostgreSQL password environment variable.
# Replace <yourpassword> with your actual PostgreSQL password.
export PGPASSWORD=u6gYvtaqGfOHGE1cIjwcBuCY

# Send SQL commands to PostgreSQL via command pipeline
echo "\c template1; \COPY users FROM '/home/project/transformed-data.csv' DELIMITERS ',' CSV;" | psql --username=postgres --host=postgres

# SELECT from users table commands to PostgreSQL via command pipeline
echo "SELECT * FROM users;" | psql --username=postgres --host=postgres template1


# How to Use

# Save this script:

# touch csv2db.sh

# nano csv2db.sh  # or open it with your editor

# Paste the above contents into the file.

# Make it executable:

# chmod +x csv2db.sh

# Run the script:

# ./csv2db.sh


# Verify Output

# cat extracted-data.txt
# cat transformed-data.csv