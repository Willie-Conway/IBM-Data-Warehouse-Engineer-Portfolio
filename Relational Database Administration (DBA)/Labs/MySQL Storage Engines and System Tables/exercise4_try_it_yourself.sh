#!/bin/bash

# ------------------------------------------------------------
# Exercise 4: Try it Yourself – Use MyISAM Engine + Metadata
# Author: Willie Conway
# ------------------------------------------------------------

echo "🚀 Starting Exercise 4: Practice Using MyISAM and Metadata..."

# Step 1: Reminder to activate MySQL CLI
echo "🔔 Please ensure your MySQL service is ACTIVE and launch the CLI."
echo "📌 Have your MySQL password ready for login."
read -p "Press [Enter] when ready to proceed with commands..."

echo ""
echo "📥 Step 1: Connect to the 'world' database in the MySQL CLI:"
echo "------------------------------------------------------------"

cat <<'EOF'
USE world;
EOF

echo ""
echo "🛠️ Step 2: Create a new table named 'MyISAM_test' using the MyISAM storage engine:"
echo "----------------------------------------------------------------------------------"

cat <<'EOF'
CREATE TABLE MyISAM_test (
    i INT NOT NULL,
    c CHAR(10) NOT NULL
) ENGINE = MYISAM;
EOF

echo ""
echo "📥 Step 3: Connect to the 'information_schema' database to query table metadata:"
echo "-------------------------------------------------------------------------------"

cat <<'EOF'
USE information_schema;
EOF

echo ""
echo "🔍 Step 4: Confirm the storage engine used by your 'MyISAM_test' table:"
echo "------------------------------------------------------------------------"

cat <<'EOF'
SELECT table_name, engine 
FROM INFORMATION_SCHEMA.TABLES 
WHERE table_schema = 'world';
EOF

echo ""
echo "📌 You should see 'MyISAM_test' listed with engine = 'MyISAM'."
echo "🧠 This confirms your ability to control storage engine types and query MySQL metadata using INFORMATION_SCHEMA."
echo ""
echo "✅ Exercise 4 Complete! You've practiced creating a non-default engine table and verifying metadata."


# How to Use:

# Save the script as exercise4_try_it_yourself.sh

# Make it executable:

# chmod +x exercise4_try_it_yourself.sh

# Run the script:

# ./exercise4_try_it_yourself.sh