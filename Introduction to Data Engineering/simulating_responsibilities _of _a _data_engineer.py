# Responsibilities and Skillsets of a Data Engineer
# 🧠 Core Responsibilities:
# Data Gathering: Pulling raw data from APIs, databases, logs, sensors, etc.


# Integration: Combining structured and unstructured data into unified datasets.

# Preparation: Cleaning and transforming data for analytics/reporting.

# Pipeline Management: Ensuring continuous and reliable data flow.

# Infrastructure Management: Handling storage systems, VMs, networking, and cloud platforms.


# 💻 Technical Skills:
# Linux/Unix, Networking, VMs, Cloud (AWS, GCP, Azure)

# SQL, Python, Bash

# Databases (PostgreSQL, MySQL), Data Warehouses (Snowflake, BigQuery)

# ETL Tools (Apache Airflow, Talend), Big Data (Spark, Hadoop)

# APIs, Kafka, and data serialization (JSON, Avro, Parquet)


# 📊 Functional Skills:
# Translating business needs to pipelines

# Ensuring data quality, privacy, security, compliance

# Understanding SDLC and CI/CD practices


# 🧠 Soft Skills:
# Communication & collaboration with cross-functional teams

# Teamwork in agile/DevOps environments

# Documenting processes and mentoring junior engineers


# This program simulates:

# Gathering data from APIs

# Preparing and integrating it

# Managing a mini pipeline from ingest to storage


import requests
import pandas as pd

# Step 1: Data Gathering (from mock API)
def fetch_user_data():
    response = requests.get("https://jsonplaceholder.typicode.com/users")
    if response.status_code == 200:
        return pd.DataFrame(response.json())
    else:
        raise Exception("Failed to fetch data")

# Step 2: Data Preparation & Cleaning
def clean_user_data(df):
    df = df[['id', 'name', 'email', 'address']]
    df['city'] = df['address'].apply(lambda x: x['city'] if isinstance(x, dict) else None)
    df.drop(columns=['address'], inplace=True)
    return df

# Step 3: Transformation (Add business logic)
def transform_user_data(df):
    df['email_domain'] = df['email'].apply(lambda x: x.split('@')[-1])
    return df

# Step 4: Store (Save locally or send to data warehouse in real apps)
def store_user_data(df, path='processed_users.csv'):
    df.to_csv(path, index=False)
    print(f"Cleaned data stored at {path}")

# Simulate data pipeline
def user_data_pipeline():
    print("Starting data pipeline...")
    raw_data = fetch_user_data()
    cleaned_data = clean_user_data(raw_data)
    transformed_data = transform_user_data(cleaned_data)
    store_user_data(transformed_data)
    print("Pipeline executed successfully.")

user_data_pipeline()


# 🔍 Highlights from the Code:

# | Step                    | Role                     | Skill Demonstrated                             |
# | ----------------------- | ------------------------ | ---------------------------------------------- |
# | `fetch_user_data()`     | Data Gathering           | API usage (requests)                           |
# | `clean_user_data()`     | Data Prep                | Pandas, JSON flattening                        |
# | `transform_user_data()` | Business Logic           | Data enrichment                                |
# | `store_user_data()`     | Infrastructure & Storage | CSV as output (can be replaced with SQL/Cloud) |
# | `user_data_pipeline()`  | Pipeline Management      | Orchestration, modular design                  |
