#!/bin/bash

# cp-access-log.sh
# This script:
# 1. Downloads a web server access log file (gzipped)
# 2. Extracts timestamp, latitude, longitude, and visitor ID
# 3. Transforms data from '#' to ',' delimited CSV
# 4. Loads the data into PostgreSQL table 'access_log' in 'template1' database

# Download the access log file
wget "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/ETL%20using%20shell%20scripting/web-server-access-log.txt.gz"

# Unzip the file to extract the .txt file
gunzip -f web-server-access-log.txt.gz

# Extract phase
echo "Extracting data"
cut -d"#" -f1-4 web-server-access-log.txt > extracted-data.txt

# Transform phase
echo "Transforming data"
tr "#" "," < extracted-data.txt > transformed-data.csv

# Load phase
echo "Loading data into PostgreSQL"

# Export credentials
export PGPASSWORD="u6gYvtaqGfOHGE1cIjwcBuCY"

# Run COPY command (no \c needed)
psql --username=postgres --host=172.21.173.28 --port=5432 --dbname=template1 -c "\COPY access_log(timestamp, latitude, longitude, visitor_id) FROM '$(pwd)/transformed-data.csv' DELIMITER ',' CSV HEADER;"

# Done
echo "ETL process complete. Run \`SELECT * FROM access_log;\` in psql to verify."

# SELECT from access_log table commands to PostgreSQL via command pipeline
echo "SELECT * FROM access_log;" | psql --username=postgres --host=postgres template1






# Notes

# Create the Table First:

# Before running this script, make sure to create the table from psql:

# \c template1;

# CREATE TABLE access_log (
#   timestamp TIMESTAMP,
#   latitude FLOAT,
#   longitude FLOAT,
#   visitor_id CHAR(37)
# );


# Make the script executable:


# chmod +x cp-access-log.sh

# Run the script:

# ./cp-access-log.sh

# Verify in psql:

# SELECT * FROM access_log;

# Verify Output

# cat extracted-data.txt
# cat transformed-data.csv