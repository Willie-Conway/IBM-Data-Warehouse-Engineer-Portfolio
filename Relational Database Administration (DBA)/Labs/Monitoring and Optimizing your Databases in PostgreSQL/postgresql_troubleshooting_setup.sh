#!/bin/bash

# Title: PostgreSQL Troubleshooting Lab Setup Script
# Description: Automates steps to set up and troubleshoot a PostgreSQL instance in Cloud IDE
# Author: [Your Name]
# Date: 2025-07-29

echo "===== PostgreSQL Troubleshooting Lab Setup ====="

# Step 1: Download Flights Database SQL File
echo "📦 Downloading flight demo database SQL file..."
wget -q https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/example-guided-project/flights_RUSSIA_small.sql && \
echo "✅ flights_RUSSIA_small.sql downloaded." || \
{ echo "❌ Failed to download flights_RUSSIA_small.sql"; exit 1; }

# Step 2: Download new PostgreSQL configuration file
echo "⚙️ Downloading custom postgresql.conf file for performance testing..."
wget -q https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0231EN-SkillsNetwork/labs/PostgreSQL/Lab%20-%20Troubleshooting/postgresql.conf && \
echo "✅ postgresql.conf downloaded." || \
{ echo "❌ Failed to download postgresql.conf"; exit 1; }

# Step 3: Replace old postgresql.conf file
echo "🗑️ Replacing existing postgresql.conf file..."
DATA_DIR=postgres/data
if [ -f "$DATA_DIR/postgresql.conf" ]; then
    rm "$DATA_DIR/postgresql.conf" && \
    echo "🗂️ Old postgresql.conf removed."
else
    echo "⚠️ No existing postgresql.conf found to delete."
fi

mv postgresql.conf "$DATA_DIR/" && \
echo "✅ New postgresql.conf moved into $DATA_DIR" || \
{ echo "❌ Failed to move new config file"; exit 1; }

# Step 4: Instructions for manual steps
cat <<EOF

===============================================
✅ SCRIPT COMPLETE - MANUAL STEPS REMAINING
===============================================

Please complete the following steps manually in Cloud IDE:

1. 🧠 Start PostgreSQL from the PostgreSQL tab in the Cloud IDE.
2. 🖥️ Open PostgreSQL CLI and run:
   \i flights_RUSSIA_small.sql
3. 📝 Edit $DATA_DIR/postgresql.conf:
   - Set: logging_collector = on
   - Set: max_connections = 100
   - Set: shared_buffers = 128MB
   - Set: work_mem = 4MB
   - Set: maintenance_work_mem = 64MB
   - Save and close the file.
4. 🔁 Stop and restart PostgreSQL server to apply configuration.
5. 🧪 Open PostgreSQL CLI and connect to 'demo' database:
   \connect demo
6. 📈 Run performance tests:
   - \timing
   - SELECT * FROM aircrafts_data;
   - UPDATE boarding_passes SET ticket_no = ticket_no, ...;

7. 🔌 Open 4+ PostgreSQL CLI terminals to test connection limits.
8. 📂 Check logs in: postgres/data/log/

✨ DONE! You have successfully configured and tested PostgreSQL performance and logging.
EOF


# How to Use

# Save this content to a file named postgresql_troubleshooting_setup.sh.

# Make it executable:

# chmod +x postgresql_troubleshooting_setup.sh

# Run it in the terminal:

# ./postgresql_troubleshooting_setup.sh