#!/bin/bash

# Step 1: Export password for PostgreSQL
export PGPASSWORD='your_postgres_password'  # Replace with actual password

# Step 2: Create the database named 'practice'
createdb -h postgres -U postgres -p 5432 practice
echo "Database 'practice' created."

# Step 3: Create schema using star-schema.sql
psql -h postgres -U postgres -p 5432 -d practice < star-schema.sql
echo "Schema created using star-schema.sql."

# Step 4: Load data into tables
psql -h postgres -U postgres -p 5432 -d practice < DimMonth.sql
echo "Data loaded into DimMonth."

psql -h postgres -U postgres -p 5432 -d practice < DimCustomer.sql
echo "Data loaded into DimCustomer."

psql -h postgres -U postgres -p 5432 -d practice < FactBilling.sql
echo "Data loaded into FactBilling."

# Step 5: Verify the data using verify.sql
psql -h postgres -U postgres -p 5432 -d practice < verify.sql
echo "Data verification complete."

echo "🎉 Congratulations! The staging server setup lab is complete."
