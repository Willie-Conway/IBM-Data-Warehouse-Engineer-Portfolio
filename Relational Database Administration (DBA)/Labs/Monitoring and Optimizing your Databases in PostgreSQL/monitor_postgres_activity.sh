#!/bin/bash

# Script: monitor_postgres_activity.sh
# Purpose: Automate PostgreSQL monitoring queries and setup pg_stat_statements
# Note: pgAdmin steps and some PostgreSQL tab controls must be done manually

echo "=== PostgreSQL Monitoring Script ==="

# Task A: Monitor Current Activity
echo ""
echo "📍 Task A: Monitor Server and Database Activity"

echo "📌 Querying current server activity (pg_stat_activity)..."
psql -d demo -c "SELECT pid, usename, datname, state, state_change FROM pg_stat_activity;"

echo ""
echo "📌 Querying with last executed query..."
psql -d demo -c "SELECT pid, usename, datname, state, state_change, query FROM pg_stat_activity;"

echo ""
echo "📌 Filtering to show only active states..."
psql -d demo -c "SELECT pid, usename, datname, state, state_change, query FROM pg_stat_activity WHERE state = 'active';"

# Database-level activity
echo ""
echo "📌 Checking rows inserted, updated, deleted per database (pg_stat_database)..."
psql -d demo -c "SELECT datname, tup_inserted, tup_updated, tup_deleted FROM pg_stat_database;"

echo ""
echo "📌 Checking rows fetched and returned per database..."
psql -d demo -c "SELECT datname, tup_fetched, tup_returned FROM pg_stat_database;"

echo ""
echo "📌 Filtering stats for demo database only..."
psql -d demo -c "SELECT datname, tup_inserted, tup_updated, tup_deleted, tup_fetched, tup_returned FROM pg_stat_database WHERE datname = 'demo';"

# Task B: Enable pg_stat_statements
echo ""
echo "📍 Task B: Enable and Use pg_stat_statements Extension"
echo "⚠️ This will attempt to enable pg_stat_statements and restart your PostgreSQL session."

echo "📌 Creating pg_stat_statements extension..."
psql -d demo -c "CREATE EXTENSION IF NOT EXISTS pg_stat_statements;"

echo "📌 Updating shared_preload_libraries setting..."
psql -d demo -c "ALTER SYSTEM SET shared_preload_libraries = 'pg_stat_statements';"

echo ""
echo "🛑 Please now manually stop and restart your PostgreSQL session using the Skills Network Toolbox UI."
echo "After restarting:"
echo " - Open PostgreSQL CLI"
echo " - Run: \\connect demo"
echo " - Then return to this script or continue manually."
read -p "Press [Enter] when you've restarted PostgreSQL and connected to the demo DB..."

echo ""
echo "📌 Verifying installed extensions..."
psql -d demo -c "\dx"

echo "📌 Checking shared_preload_libraries value..."
psql -d demo -c "SHOW shared_preload_libraries;"

echo "📌 Turning on expanded table display mode..."
psql -d demo -c "\x"

echo ""
echo "📌 Viewing aggregated query stats from pg_stat_statements..."
psql -d demo -c "SELECT dbid, query, total_exec_time FROM pg_stat_statements;"

echo ""
echo "📌 Matching dbid to database name..."
psql -d demo -c "SELECT oid, datname FROM pg_database;"

echo ""
echo "✅ Monitoring setup complete. You can now analyze query execution over time."

echo ""
echo "🧹 (Optional Cleanup)"
echo "To remove the extension and reset config:"
echo "  psql -d demo -c \"DROP EXTENSION pg_stat_statements;\""
echo "  psql -d demo -c \"ALTER SYSTEM RESET shared_preload_libraries;\""
echo "  (Then restart your PostgreSQL session again.)"




# Instructions to Use:

# Save the above content into a file called monitor_postgres_activity.sh.

# In the terminal, run:

# chmod +x monitor_postgres_activity.sh

# ./monitor_postgres_activity.sh