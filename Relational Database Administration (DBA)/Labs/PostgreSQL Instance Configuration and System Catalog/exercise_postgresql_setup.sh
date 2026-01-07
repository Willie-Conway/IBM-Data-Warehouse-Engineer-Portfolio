#!/bin/bash

# -------------------------------------------------------------
# PostgreSQL Setup: Download & Restore Russia Flight Dataset
# Author: Willie Conway
# -------------------------------------------------------------

echo "🚀 Starting PostgreSQL setup in IBM Cloud IDE..."

# Step 1: Manual Instructions
echo "🔔 Please follow these manual steps to launch PostgreSQL:"
echo "----------------------------------------------------------"
echo "1. Click the 'Skills Network' extension icon in the left pane."
echo "2. Open the DATABASES dropdown and click on 'PostgreSQL'."
echo "3. Click the 'Start' button. Wait for the database to become ACTIVE."
echo "4. If it fails to start, click 'Stop' and try again."
read -p "Once PostgreSQL is active, press [Enter] to continue..."

# Step 2: Open terminal & download SQL file
echo ""
echo "⬇️ Downloading flight data backup file..."
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/example-guided-project/flights_RUSSIA_small.sql

if [ -f "flights_RUSSIA_small.sql" ]; then
    echo "✅ Download complete: flights_RUSSIA_small.sql"
else
    echo "❌ Download failed. Please check your internet connection and try again."
    exit 1
fi

# Step 3: Instructions for PostgreSQL CLI
echo ""
echo "🧠 Now, open the PostgreSQL CLI by clicking the 'Postgres CLI' button in the IDE."
echo "🔑 Then enter the following command inside the CLI to restore the dataset:"
echo "----------------------------------------------------------"

cat <<'EOF'
\i flights_RUSSIA_small.sql
EOF

echo "----------------------------------------------------------"
echo ""
echo "📊 Once the restoration is complete, list the tables with:"
echo "----------------------------------------------------------"

cat <<'EOF'
\dt
EOF

echo "----------------------------------------------------------"
echo ""
echo "📌 You should now see tables under the 'bookings' schema in the 'demo' database."
echo "🛫 This dataset includes a month of flight data in Russia."

echo "✅ PostgreSQL setup complete!"



# How to Run This Script:

# Save it as: exercise_postgresql_setup.sh

# Make it executable:

# chmod +x exercise_postgresql_setup.sh

# Run it:

# ./exercise_postgresql_setup.sh