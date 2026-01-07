# 📘 Summary and Highlights


# Modern data ecosystem includes a network of interconnected and continually 
# evolving entities that include:

# Data, that is available in a host of different formats, structures, and sources. 

# Enterprise Data Environment, in which raw data is staged so it can be organized, 
# cleaned, and optimized for use by end-users.

# End-users, such as business stakeholders, analysts, and programmers 
# who consume data for various purposes.

# Emerging technologies such as Cloud Computing, Machine Learning, and 
# Big Data, are continually reshaping the data ecosystem and the 
# possibilities it offers.

# Data Engineers, Data Analysts, Data Scientists, Business Analysts, 
# and Business Intelligence Analysts, all play a vital role in the 
# ecosystem for deriving insights and business results from data.

# The goal of Data Engineering is to make quality data available 
# for analytics and decision-making. And it does this by collecting 
# raw source data, processing data so it becomes usable, storing data, 
# and making quality data available to users securely.  


import pandas as pd

# Simulating raw data ingestion from multiple sources
sales_data = pd.DataFrame({
    'transaction_id': [1, 2, 3],
    'customer': ['Alice', 'Bob', 'Charlie'],
    'amount': [120.50, 85.00, 99.99],
    'date': ['2024-01-01', '2024-01-03', '2024-01-05']
})

# Simulated data quality check
def clean_data(df):
    df['date'] = pd.to_datetime(df['date'])
    df['amount'] = df['amount'].astype(float)
    return df

# Transforming and enriching data
def transform_data(df):
    df['discount_applied'] = df['amount'] > 100
    df['amount_with_tax'] = df['amount'] * 1.08  # 8% tax
    return df

# Simulated storage step (e.g., into a database)
def store_data(df, path='clean_sales_data.csv'):
    df.to_csv(path, index=False)
    print(f"Data stored at {path}")

# Main pipeline
def data_pipeline():
    print("Starting ETL Pipeline...")
    cleaned = clean_data(sales_data)
    transformed = transform_data(cleaned)
    store_data(transformed)
    print("Pipeline complete.")

data_pipeline()
