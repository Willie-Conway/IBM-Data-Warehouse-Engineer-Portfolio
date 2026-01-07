#!/bin/bash

# 🎯 Set up environment variables
export PGPASSWORD='<your_postgres_password>'  # Replace with your actual password

# 🏁 Step 1: Count rows in FactBilling
echo "🔎 Counting rows in FactBilling..."
psql -h postgres -U postgres -p 5432 -d practice -c 'SELECT COUNT(*) FROM public."FactBilling";'

# 🧱 Step 2: Create Materialized View avg_customer_bill
echo "🏗️ Creating materialized view avg_customer_bill..."
psql -h postgres -U postgres -p 5432 -d practice -c '
CREATE MATERIALIZED VIEW avg_customer_bill (customerid, averagebillamount) AS
SELECT customerid, AVG(billedamount)
FROM public."FactBilling"
GROUP BY customerid;
'

# 🔄 Step 3: Refresh Materialized View
echo "🔁 Refreshing materialized view..."
psql -h postgres -U postgres -p 5432 -d practice -c 'REFRESH MATERIALIZED VIEW avg_customer_bill;'

# 🔍 Step 4: Query customers with average bill > 11000
echo "📊 Customers with average billing > 11000:"
psql -h postgres -U postgres -p 5432 -d practice -c '
SELECT * FROM avg_customer_bill WHERE averagebillamount > 11000;
'

echo "🎉 Lab Completed: Populating a Data Warehouse"
