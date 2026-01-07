# 📊 Querying, Transforming & Monitoring a Car Sales Dataset

# This program simulates a real-world data engineer task using:

# SQL for querying

# Pandas for transformation

# Logging for monitoring

# Basic troubleshooting simulation

# We'll simulate a CSV-based database query and 
# performance tracking system for a car sales dataset.

import pandas as pd
import sqlite3
import logging
import time

# Setup basic logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# Step 1: Load CSV Data
try:
    df = pd.read_csv("https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0100EN-SkillsNetwork/labs/exercise03_car_sales_data.csv")
    logging.info("CSV data loaded successfully.")
except Exception as e:
    logging.error(f"Failed to load data: {e}")
    exit()

# Step 2: Load data into SQLite for querying
conn = sqlite3.connect(":memory:")
df.to_sql("car_sales", conn, index=False, if_exists='replace')
logging.info("Data loaded into in-memory SQLite database.")

# Step 3: Querying and Transformation
cursor = conn.cursor()

# Max price
try:
    start = time.time()
    cursor.execute("SELECT MAX(price) FROM car_sales")
    max_price = cursor.fetchone()[0]
    end = time.time()
    logging.info(f"Max price: ${max_price} (Query Time: {end - start:.4f}s)")
except Exception as e:
    logging.error(f"Query failed: {e}")

# Group by model and count
try:
    query = "SELECT model, COUNT(*) as count FROM car_sales GROUP BY model ORDER BY count DESC LIMIT 5"
    results = pd.read_sql_query(query, conn)
    print("\nTop 5 Car Models by Frequency:\n", results)
except Exception as e:
    logging.warning(f"Error during model aggregation: {e}")

# Step 4: Simulated Alert
row_count = df.shape[0]
if row_count > 10000:
    logging.warning("Large dataset detected. Consider indexing for performance tuning.")

# Close connection
conn.close()



# 🔍 What This Demonstrates:

# Querying: Using SQL inside Python to explore your data.

# Performance Timing: time.time() used to monitor query duration.

# Error Logging: Helps simulate troubleshooting real ETL issues.

# Transformation: Grouping and counting models for insights.