# 🧠 Data Engineer – Responsibilities & Skills

# ✅ Key Responsibilities
# Collect data from multiple sources (APIs, files, databases)

# Build and maintain ETL/ELT pipelines

# Clean, transform, and integrate data

# Ensure high availability and scalability of data infrastructure

# Manage data storage and delivery to end users

# 🛠️ Core Skillsets
# Technical: Python, SQL, Linux, Docker, Airflow, Spark, cloud 
# platforms (AWS/GCP/Azure), databases (PostgreSQL, MongoDB)

# Functional: Data modeling, data quality, business needs translation, 
# data governance

# Soft: Communication, collaboration, problem-solving, project management

# This example simulates the responsibilities of a Data Engineer: 
# ingestion, transformation, validation, and storage.

import pandas as pd
import requests

# 1. Ingest data from a simulated external API
def fetch_api_data():
    # Simulated JSON response from an API
    data = {
        'users': [
            {'id': 1, 'name': 'Alice', 'signup_date': '2024-01-01', 'plan': 'premium'},
            {'id': 2, 'name': 'Bob', 'signup_date': '2024-02-15', 'plan': 'basic'},
            {'id': 3, 'name': 'Charlie', 'signup_date': 'invalid-date', 'plan': 'premium'}
        ]
    }
    return pd.DataFrame(data['users'])

# 2. Data validation and cleaning
def validate_and_clean(df):
    df['signup_date'] = pd.to_datetime(df['signup_date'], errors='coerce')
    df.dropna(subset=['signup_date'], inplace=True)
    df['plan'] = df['plan'].str.title()
    return df

# 3. Transformation logic (business logic)
def transform(df):
    df['days_since_signup'] = (pd.Timestamp.now() - df['signup_date']).dt.days
    return df

# 4. Simulated storage step
def save_cleaned_data(df, filename="clean_users.csv"):
    df.to_csv(filename, index=False)
    print(f"Saved cleaned data to {filename}")

# Main orchestration function
def run_pipeline():
    print("🚀 Starting ETL Pipeline")
    raw_data = fetch_api_data()
    print("✅ Data fetched")
    
    cleaned_data = validate_and_clean(raw_data)
    print("🧹 Data cleaned and validated")

    transformed_data = transform(cleaned_data)
    print("🔄 Data transformed")

    save_cleaned_data(transformed_data)
    print("🏁 Pipeline complete")

run_pipeline()


# 🌟 Highlights

# Ingestion from a simulated API.

# Validation & Cleaning of malformed data (invalid-date).

# Transformation with business logic (days_since_signup).

# Storage in a CSV, mimicking a data warehouse insert.

# This shows a small-scale but realistic end-to-end Data 
# Engineering flow.