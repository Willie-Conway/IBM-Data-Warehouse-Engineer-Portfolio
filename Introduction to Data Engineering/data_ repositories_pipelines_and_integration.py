# 🧠 Data Repositories, Pipelines, and Integration

# ✅ Key Concepts

# Data Repository: Central location to store, organize, and manage data for analytics or archiving.

# Relational/Non-relational Databases (PostgreSQL, MongoDB)

# Data Warehouses (Snowflake, BigQuery)

# Data Marts (Department-specific analytics)

# Data Lakes (Raw, large-volume storage)

# Big Data Stores (HDFS, Spark, Hadoop)


# ETL Process:

# Extract from APIs, databases, files

# Transform (clean, standardize, enrich)

# Load into repositories (DW, DL, etc.)


# ELT Process:

# Extract → Load → Transform (within the target system; ideal for Data Lakes/Big Data)

# Data Pipeline: Automates ETL/ELT and routes data from sources to targets.

# Data Integration Platforms: Tools that merge data from multiple sources (e.g., Talend, Informatica, Apache NiFi, IBM DataStage).


# 🔁 Simulated ETL Data Pipeline

# This script mimics a basic pipeline that:

# Extracts data from a mock source

# Transforms it (cleans, enriches)

# Loads it into a simulated "Data Warehouse" (CSV)

# Logs staging in a "Data Lake" (JSON)

import pandas as pd
import json

# Step 1: Extract from simulated API or source
def extract_data():
    print("📥 Extracting raw data...")
    data = [
        {"id": 1, "name": "Alice", "amount": "100", "region": "North"},
        {"id": 2, "name": "Bob", "amount": "200", "region": "East"},
        {"id": 3, "name": "Charlie", "amount": "NaN", "region": "West"},
    ]
    return pd.DataFrame(data)

# Step 2: Transform the raw data
def transform_data(df):
    print("🔧 Transforming data...")
    df['amount'] = pd.to_numeric(df['amount'], errors='coerce').fillna(0)
    df['region'] = df['region'].str.upper()
    df['status'] = df['amount'].apply(lambda x: 'High' if x >= 150 else 'Low')
    return df

# Step 3A: Load into Data Warehouse (CSV)
def load_to_data_warehouse(df):
    print("🏢 Loading data into Data Warehouse (CSV)...")
    df.to_csv("data_warehouse.csv", index=False)
    print("✅ Data stored in data_warehouse.csv")

# Step 3B: Stage raw data into Data Lake (JSON)
def stage_to_data_lake(df):
    print("🌊 Staging raw data into Data Lake (JSON)...")
    with open("data_lake.json", "w") as f:
        json.dump(df.to_dict(orient="records"), f, indent=4)
    print("✅ Raw data staged in data_lake.json")

# Main pipeline function
def run_pipeline():
    raw = extract_data()
    stage_to_data_lake(raw)  # Data Lake for raw staging
    transformed = transform_data(raw)
    load_to_data_warehouse(transformed)

run_pipeline()


# 🌟 Highlights

# | Component      | Simulated With    | Real-World Equivalent               |
# | -------------- | ----------------- | ----------------------------------- |
# | Source Data    | Python dictionary | APIs, Flat files, Databases         |
# | Data Lake      | JSON file         | Amazon S3, HDFS, Azure Blob Storage |
# | Data Warehouse | CSV file          | Snowflake, BigQuery, Redshift       |
# | Pipeline Logic | Python functions  | Airflow, Luigi, Prefect             |
