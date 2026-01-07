# 🏚️ ETL to Warehouse

#  program simulating a basic data warehousing workflow, modeled on what 
#  a Data Warehousing Specialist might do in real life. 
#  This example covers:

# ✅ Designing a star schema-like structure (fact + dimension tables)

# ✅ ETL (Extract, Transform, Load) from raw CSV into a normalized SQLite warehouse

# ✅ Performing business intelligence-style aggregation

# ✅ Creating metadata logs for traceability


# 🏗️ Example: Sales Data Warehousing Workflow

# Assumptions:
# You have raw sales data: sales_data.csv with columns: 
# 
# transaction_id, product_name, category, quantity, unit_price, timestamp



# You'll build:

# ✔️ fact_sales

# ✔️ dim_product

# ✔️ dim_time

# You’ll log actions in a metadata table.

import pandas as pd
import sqlite3
from datetime import datetime

# Step 1: Load raw CSV (Extract)
df = pd.read_csv("sales_data.csv")
df['timestamp'] = pd.to_datetime(df['timestamp'])
df['total_price'] = df['quantity'] * df['unit_price']

# Step 2: Transform - create dimension and fact data
dim_product = df[['product_name', 'category']].drop_duplicates().reset_index(drop=True)
dim_product['product_id'] = dim_product.index + 1

dim_time = df[['timestamp']].drop_duplicates().reset_index(drop=True)
dim_time['time_id'] = dim_time.index + 1
dim_time['date'] = dim_time['timestamp'].dt.date
dim_time['month'] = dim_time['timestamp'].dt.month
dim_time['year'] = dim_time['timestamp'].dt.year

# Merge IDs into fact table
fact_sales = df.merge(dim_product, on=['product_name', 'category'])
fact_sales = fact_sales.merge(dim_time, on='timestamp')
fact_sales = fact_sales[['transaction_id', 'product_id', 'time_id', 'quantity', 'unit_price', 'total_price']]

# Step 3: Load into SQLite Warehouse
conn = sqlite3.connect("data_warehouse.db")
cur = conn.cursor()

# Create tables
cur.execute("""CREATE TABLE IF NOT EXISTS dim_product (
    product_id INTEGER PRIMARY KEY, product_name TEXT, category TEXT
)""")

cur.execute("""CREATE TABLE IF NOT EXISTS dim_time (
    time_id INTEGER PRIMARY KEY, timestamp TEXT, date TEXT, month INTEGER, year INTEGER
)""")

cur.execute("""CREATE TABLE IF NOT EXISTS fact_sales (
    transaction_id TEXT PRIMARY KEY, product_id INTEGER, time_id INTEGER,
    quantity INTEGER, unit_price REAL, total_price REAL
)""")

cur.execute("""CREATE TABLE IF NOT EXISTS metadata_log (
    log_id INTEGER PRIMARY KEY AUTOINCREMENT, step TEXT, status TEXT, timestamp TEXT
)""")

# Load data
dim_product.to_sql("dim_product", conn, if_exists='replace', index=False)
dim_time.to_sql("dim_time", conn, if_exists='replace', index=False)
fact_sales.to_sql("fact_sales", conn, if_exists='replace', index=False)

# Log success
cur.execute("INSERT INTO metadata_log (step, status, timestamp) VALUES (?, ?, ?)",
            ("ETL Load", "Success", datetime.now().isoformat()))
conn.commit()

# Step 4: Run business query (BI-style aggregation)
query = """
SELECT dp.category, dt.year, dt.month, SUM(fs.total_price) as monthly_revenue
FROM fact_sales fs
JOIN dim_product dp ON fs.product_id = dp.product_id
JOIN dim_time dt ON fs.time_id = dt.time_id
GROUP BY dp.category, dt.year, dt.month
ORDER BY monthly_revenue DESC
"""
result = pd.read_sql_query(query, conn)
print(result)

conn.close()


# 🧠 Concepts Demonstrated:

# Data modeling: Simulates a normalized star schema

# ETL process: Extract from CSV → Transform into dims/facts → Load into warehouse

# Data integrity: Key merges and ID management

# Analytics: Monthly revenue per product category

# Metadata logging: Ensures audit trail and traceability

