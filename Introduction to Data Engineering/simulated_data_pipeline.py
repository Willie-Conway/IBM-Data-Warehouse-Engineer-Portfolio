# ⚙️ Simulated DataOps Pipeline

# This program simulates a mini DataOps pipeline, demonstrating 
# core concepts of the DataOps methodology such as:

# 📥 Data ingestion

# 🧼 Data validation

# 🔁 Automation of workflows

# 📊 Metadata logging

# 🔍 Data lineage trace

# ✅ Testing

# 📤 Data delivery (to a database or final format)

# This mock pipeline uses CSV data and mimics automation 
# and traceability features.

import pandas as pd
import logging
import os
import datetime
from sqlalchemy import create_engine

# 📊 Setup logging for metadata, lineage, and audit trail
logging.basicConfig(filename='dataops_audit.log', level=logging.INFO, format='%(asctime)s - %(message)s')

# 🔧 Step 1: Ingest Data
def ingest_data(file_path):
    if not os.path.exists(file_path):
        logging.error("Data file not found.")
        raise FileNotFoundError("CSV file is missing.")
    df = pd.read_csv(file_path)
    logging.info(f"Data ingested from {file_path}")
    return df

# 🔍 Step 2: Validate Data
def validate_data(df):
    if df.isnull().sum().sum() > 0:
        logging.warning("Missing values detected in the dataset.")
    else:
        logging.info("No missing values. Dataset looks clean.")
    logging.info(f"Columns: {list(df.columns)} | Row Count: {len(df)}")

# 🔁 Step 3: Transform Data (e.g., calculate new columns)
def transform_data(df):
    df["price_usd"] = df["price"] * 1.0  # Mock conversion
    logging.info("Transformation applied: price_usd column created.")
    return df

# 💽 Step 4: Load Data (Simulate delivery to SQLite)
def load_to_sqlite(df, db_name="dataops_demo.db"):
    engine = create_engine(f"sqlite:///{db_name}")
    df.to_sql("car_sales", con=engine, if_exists='replace', index=False)
    logging.info(f"Transformed data loaded to database {db_name} in table 'car_sales'.")

# 🧪 Step 5: Test Data Output
def test_data_quality(df):
    assert "price" in df.columns, "Price column missing!"
    assert df["price"].min() >= 0, "Negative price found!"
    logging.info("Test passed: Data quality checks successful.")

# 🚀 Simulate Pipeline Execution
def run_dataops_pipeline():
    try:
        source_file = "exercise03_car_sales_data.csv"
        logging.info("📍 DataOps Pipeline Initiated")

        df = ingest_data(source_file)
        validate_data(df)
        df_transformed = transform_data(df)
        test_data_quality(df_transformed)
        load_to_sqlite(df_transformed)

        logging.info("✅ DataOps Pipeline completed successfully.")
    except Exception as e:
        logging.error(f"❌ Pipeline failed: {str(e)}")

if __name__ == "__main__":
    run_dataops_pipeline()




# 🧠 Features Demonstrated:

# Automation: Runs a full pipeline from ingest to delivery.

# Testing: Includes basic data quality checks.

# Logging: Captures metadata, validation steps, and data lineage.

# Extensible: Could be adapted into an Airflow DAG or CI/CD 
# pipeline for real-world use.