#!/bin/bash

# Configuration Script to Set wal_level to 'logical' in PostgreSQL

# 1. Set environment variables (modify as needed)
PGUSER="postgres"
PGHOST="localhost"
PGPORT="5432"
PGDATABASE="postgres"

# Optional: export these so psql can pick them up
export PGUSER PGHOST PGPORT PGDATABASE

# 2. Display current wal_level setting
echo "Current wal_level setting:"
psql -c "SHOW wal_level;"

# 3. Set wal_level to 'logical'
echo "Setting wal_level to 'logical'..."
psql -c "ALTER SYSTEM SET wal_level = 'logical';"

# 4. Restart PostgreSQL service (for local installations)
# Modify based on your environment (systemctl, service, pg_ctl, etc.)
echo "Restarting PostgreSQL server..."
# Example for Linux systemd-based systems:
sudo systemctl restart postgresql

# Wait a few seconds for the server to fully restart
sleep 5

# 5. Show the updated wal_level setting
echo "Updated wal_level setting:"
psql -c "SHOW wal_level;"

echo "Configuration complete."




# How to Use

# Save the script as configure_postgres.sh.

# Make it executable:

# chmod +x configure_postgres.sh

# Run it:

# ./configure_postgres.sh