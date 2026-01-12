#!/bin/sh

## Write your code here to load the data from sales_data table in Mysql server to a sales.csv.
## Select the data which is not more than 4 hours old from the current time.

# MySQL connection details
MYSQL_USER="root"
MYSQL_PASSWORD="EqEURqStYnyead77t8MAzV8U"  # Fixed: Removed unmatched quote
MYSQL_HOST="mysql"
MYSQL_DB="sales"

# PostgreSQL connection details
PG_USER="postgres"
PG_PASSWORD="O1lkqKAiXdN88evrXy8ETMVo"  # Fixed: Removed unmatched quote
PG_HOST="postgres"  # Changed from localhost to postgres
PG_DB="staging"  # Changed from sales_new to staging

# Define file paths
SALES_CSV="/home/project/sales.csv"
TEMP_CSV="/home/project/temp_sales_commas.csv"
DIMDATE_CSV="/home/project/DimDate.csv"
FACTSALES_CSV="/home/project/FactSales.csv"

echo "=========================================="
echo "Starting ETL Process..."
echo "=========================================="

# STEP 1: Extract data from MySQL (last 4 hours)
echo "Step 1: Extracting data from MySQL (last 4 hours)..."

mysql -h $MYSQL_HOST -P 3306 -u $MYSQL_USER --password=$MYSQL_PASSWORD --database=$MYSQL_DB \
--execute="SELECT rowid, product_id, customer_id, price, quantity, timestamp 
FROM sales_data 
WHERE timestamp >= DATE_SUB(NOW(), INTERVAL 4 HOUR)
ORDER BY timestamp" \
--batch --silent > $SALES_CSV

# Check if data was extracted
if [ -s "$SALES_CSV" ]; then
    echo "Data extracted successfully. Records extracted: $(wc -l < $SALES_CSV)"
else
    echo "No new data found in the last 4 hours."
fi

# Convert tabs to commas
echo "Converting tabs to commas..."
tr '\t' ',' < $SALES_CSV > $TEMP_CSV

# Move the temporary file with commas to the original file location
mv $TEMP_CSV $SALES_CSV
echo "CSV file prepared: $SALES_CSV"

# STEP 2: Load data into PostgreSQL
echo "Step 2: Loading data into PostgreSQL..."
export PGPASSWORD=$PG_PASSWORD

# Create sales_data table if it doesn't exist
psql --username=$PG_USER --host=$PG_HOST --dbname=$PG_DB -c "
CREATE TABLE IF NOT EXISTS sales_data (
    rowid INT,
    product_id INT,
    customer_id INT,
    price DECIMAL(10,2),
    quantity INT,
    timestamp TIMESTAMP
);"

# Load the CSV data
psql --username=$PG_USER --host=$PG_HOST --dbname=$PG_DB -c "\COPY sales_data(rowid,product_id,customer_id,price,quantity,timestamp) FROM '$SALES_CSV' delimiter ',' csv;"
echo "Data loaded into PostgreSQL sales_data table"

# STEP 3: Create and populate DimDate table
echo "Step 3: Creating and populating DimDate table..."

psql --username=$PG_USER --host=$PG_HOST --dbname=$PG_DB -c "
-- Create DimDate table if not exists
CREATE TABLE IF NOT EXISTS DimDate (
    dateid SERIAL PRIMARY KEY,
    date DATE UNIQUE,
    year INT,
    month INT,
    day INT,
    quarter INT,
    dayofweek INT
);

-- Insert distinct dates from sales_data
INSERT INTO DimDate (date, year, month, day, quarter, dayofweek)
SELECT DISTINCT 
    DATE(timestamp),
    EXTRACT(YEAR FROM timestamp),
    EXTRACT(MONTH FROM timestamp),
    EXTRACT(DAY FROM timestamp),
    EXTRACT(QUARTER FROM timestamp),
    EXTRACT(DOW FROM timestamp)
FROM sales_data
ON CONFLICT (date) DO NOTHING;

SELECT 'DimDate records: ' || COUNT(*) FROM DimDate;
"

# STEP 4: Create and populate FactSales table
echo "Step 4: Creating and populating FactSales table..."

psql --username=$PG_USER --host=$PG_HOST --dbname=$PG_DB -c "
-- Create FactSales table if not exists
CREATE TABLE IF NOT EXISTS FactSales (
    salesid SERIAL PRIMARY KEY,
    dateid INT REFERENCES DimDate(dateid),
    product_id INT,
    customer_id INT,
    quantity INT,
    price DECIMAL(10,2),
    total_amount DECIMAL(10,2)
);

-- Insert data into FactSales
INSERT INTO FactSales (dateid, product_id, customer_id, quantity, price, total_amount)
SELECT 
    d.dateid,
    s.product_id,
    s.customer_id,
    s.quantity,
    s.price,
    s.quantity * s.price
FROM sales_data s
JOIN DimDate d ON DATE(s.timestamp) = d.date
ON CONFLICT DO NOTHING;

SELECT 'FactSales records: ' || COUNT(*) FROM FactSales;
"

# STEP 5: Export DimDate table to CSV
echo "Step 5: Exporting DimDate table to CSV..."

psql --username=$PG_USER --host=$PG_HOST --dbname=$PG_DB -c "\COPY DimDate TO '$DIMDATE_CSV' WITH CSV HEADER;"
echo "DimDate exported to: $DIMDATE_CSV"

# STEP 6: Export FactSales table to CSV
echo "Step 6: Exporting FactSales table to CSV..."

psql --username=$PG_USER --host=$PG_HOST --dbname=$PG_DB -c "\COPY FactSales TO '$FACTSALES_CSV' WITH CSV HEADER;"
echo "FactSales exported to: $FACTSALES_CSV"

# STEP 7: Cleanup
echo "Step 7: Performing cleanup..."

# Delete sales.csv
if [ -f "$SALES_CSV" ]; then
    rm $SALES_CSV
    echo "Removed temporary file: $SALES_CSV"
fi

# Optional: Drop temporary tables (uncomment if needed)
# psql --username=$PG_USER --host=$PG_HOST --dbname=$PG_DB -c "DROP TABLE IF EXISTS sales_data CASCADE;"

echo "=========================================="
echo "ETL Process Completed Successfully!"
echo "=========================================="
echo "Generated files:"
echo "1. DimDate.csv: $DIMDATE_CSV"
echo "2. FactSales.csv: $FACTSALES_CSV"
echo "=========================================="

# Display sample of exported files
echo ""
echo "Sample of DimDate.csv:"
head -n 3 $DIMDATE_CSV

echo ""
echo "Sample of FactSales.csv:"
head -n 3 $FACTSALES_CSV