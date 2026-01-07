#!/bin/bash

# Exit on error
set -e

echo "🎯 Restoring PostgreSQL backup to a new database..."

# Ensure PostgreSQL is running
sudo systemctl start postgresql

# Drop and recreate target database
sudo -u postgres psql -c "DROP DATABASE IF EXISTS restored_demo;"
sudo -u postgres psql -c "CREATE DATABASE restored_demo WITH OWNER=postgres;"

# Restore from backup file
sudo -u postgres pg_restore -d restored_demo /path/to/demo_backup.tar --verbose

echo "✅ Backup restored successfully into 'restored_demo'."


# Replace /path/to/demo_backup.tar with the actual backup file path.