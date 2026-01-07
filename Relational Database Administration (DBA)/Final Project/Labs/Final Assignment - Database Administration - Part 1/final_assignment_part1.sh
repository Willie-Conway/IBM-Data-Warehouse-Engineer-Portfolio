#!/bin/bash

# Final Assignment - Database Administration - Part 1
# Author: Willie Conway
# Purpose: Automate setup and user management tasks on PostgreSQL server

echo "==> Starting PostgreSQL server..."
sudo service postgresql start

echo "==> Checking PostgreSQL server status..."
sudo service postgresql status

echo "==> Downloading lab setup file..."
wget -O postgres-setup.sh "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/-o-CVNqamn9K4hGlSpFCYg/postgres-setup.sh"

echo "==> REMINDER: Edit 'postgres-setup.sh' manually and insert password for PostgreSQL where needed before running."
echo "Once edited, run the script with: bash postgres-setup.sh"
echo "Sleeping for 5 seconds to let you read the message..."
sleep 5

echo "==> Showing max_connections setting:"
sudo -u postgres psql -c "SHOW max_connections;" > max_connections_output.txt
cat max_connections_output.txt

echo "==> Creating user 'backup_operator'..."
sudo -u postgres psql -c "CREATE USER backup_operator WITH PASSWORD 'SecurePass123';"

echo "==> Creating role 'backup'..."
sudo -u postgres psql -c "CREATE ROLE backup;"

echo "==> Granting privileges to role 'backup'..."
sudo -u postgres psql -d tolldata -c "GRANT CONNECT ON DATABASE tolldata TO backup;"
sudo -u postgres psql -d tolldata -c "GRANT SELECT ON ALL TABLES IN SCHEMA toll TO backup;"

echo "==> Granting role 'backup' to user 'backup_operator'..."
sudo -u postgres psql -c "GRANT backup TO backup_operator;"

echo "==> DONE. For backup task, please use PGAdmin to create 'tolldatabackup.tar' and take a screenshot."

echo "==> Script complete. Don't forget to take screenshots of each command/output."


# Instructions for Use:

# Copy the above script into your project directory as:

# final_assignment_part1.sh

# Give it execution permissions:


# chmod +x final_assignment_part1.sh

# Run it:

# ./final_assignment_part1.sh
# Manually edit the downloaded postgres-setup.sh file and insert the PostgreSQL password where prompted before running it:


# bash postgres-setup.sh

# After the script finishes:

# Use PGAdmin GUI to perform the .tar format backup of tolldata and name it tolldatabackup.tar.

# Take screenshots of:

# max_connections

# user creation

# role creation

# privilege grants

# role grants

# backup dialog in PGAdmin

