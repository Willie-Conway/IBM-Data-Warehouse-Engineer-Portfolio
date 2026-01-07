#!/bin/bash

# 🔐 Export password for PostgreSQL
export PGPASSWORD='<your_postgres_password>'  # Replace with actual password

DB_NAME="practice"

echo "📊 Problem 1: GROUPING SETS (year, quartername)"
psql -h postgres -U postgres -p 5432 -d $DB_NAME -c '
SELECT year, quartername, SUM(billedamount) AS totalbilledamount
FROM "FactBilling"
LEFT JOIN "DimCustomer"
ON "FactBilling".customerid = "DimCustomer".customerid
LEFT JOIN "DimMonth"
ON "FactBilling".monthid = "DimMonth".monthid
GROUP BY GROUPING SETS (year, quartername);
'

echo "📈 Problem 2: ROLLUP (country, category)"
psql -h postgres -U postgres -p 5432 -d $DB_NAME -c '
SELECT country, category, SUM(billedamount) AS totalbilledamount
FROM "FactBilling"
LEFT JOIN "DimCustomer"
ON "FactBilling".customerid = "DimCustomer".customerid
LEFT JOIN "DimMonth"
ON "FactBilling".monthid = "DimMonth".monthid
GROUP BY ROLLUP(country, category)
ORDER BY country, category;
'

echo "📦 Problem 3: CUBE (year, country, category)"
psql -h postgres -U postgres -p 5432 -d $DB_NAME -c '
SELECT year, country, category, SUM(billedamount) AS totalbilledamount
FROM "FactBilling"
LEFT JOIN "DimCustomer"
ON "FactBilling".customerid = "DimCustomer".customerid
LEFT JOIN "DimMonth"
ON "FactBilling".monthid = "DimMonth".monthid
GROUP BY CUBE(year, country, category);
'

echo "🏗️ Problem 4: Create Materialized View average_billamount"
psql -h postgres -U postgres -p 5432 -d $DB_NAME -c '
CREATE MATERIALIZED VIEW average_billamount (year, quarter, category, country, average_bill_amount) AS
SELECT year, quarter, category, country, AVG(billedamount) AS average_bill_amount
FROM "FactBilling"
LEFT JOIN "DimCustomer"
ON "FactBilling".customerid = "DimCustomer".customerid
LEFT JOIN "DimMonth"
ON "FactBilling".monthid = "DimMonth".monthid
GROUP BY year, quarter, category, country;
'

echo "🔄 Refreshing Materialized View..."
psql -h postgres -U postgres -p 5432 -d $DB_NAME -c 'REFRESH MATERIALIZED VIEW average_billamount;'

echo "🎉 Lab Completed: Querying the Data Warehouse with Cubes, Rollups, Grouping Sets, and Materialized Views"
