# 🧠 Data Engineer’s Ecosystem

# ✅ Key Takeaways


# Data Types:

# Structured (e.g., SQL tables)

# Semi-structured (e.g., JSON, XML)

# Unstructured (e.g., PDFs, images)

# Data Sources: APIs, databases, files, IoT, social platforms, etc.

# Data Repositories: Data Lakes, Warehouses, NoSQL stores, Cloud Storage


# ⚙️ Languages & Tools:

# SQL for querying

# Python/R/Java for processing

# ETL frameworks, data pipelines, and BI/reporting tools


# 🖥️ Handling Structured, Semi-Structured, and Unstructured Data
#    This simple ETL simulation uses:

# CSV (structured)

# JSON (semi-structured)

# TXT (unstructured, like log entries)

import pandas as pd
import json

# Structured data (CSV - sales data)
def load_structured_data():
    df = pd.DataFrame({
        'OrderID': [1, 2, 3],
        'Product': ['Laptop', 'Shirt', 'Apples'],
        'Amount': [999.99, 49.99, 12.50]
    })
    print("✅ Structured Data (CSV Simulation):\n", df)
    return df

# Semi-structured data (JSON - customer profiles)
def load_semi_structured_data():
    raw_json = '''
    [
        {"CustomerID": 101, "Name": "Alice", "Preferences": {"Color": "Blue", "Size": "M"}},
        {"CustomerID": 102, "Name": "Bob", "Preferences": {"Color": "Red", "Size": "L"}}
    ]
    '''
    data = json.loads(raw_json)
    df = pd.json_normalize(data, sep='_')
    print("\n🌀 Semi-Structured Data (JSON Simulation):\n", df)
    return df

# Unstructured data (TXT - user reviews or logs)
def load_unstructured_data():
    reviews = """
    Alice: Loved the laptop! Fast and reliable.
    Bob: Shirt quality is okay, but delivery was late.
    Charlie: The apples were fresh and delicious.
    """
    lines = [line.strip() for line in reviews.strip().split('\n') if line]
    print("\n🗒️ Unstructured Data (TXT Simulation):")
    for line in lines:
        print("-", line)
    return lines

# Simulate staging data for analysis
def stage_data():
    print("🚀 Starting Data Staging Process...\n")
    structured = load_structured_data()
    semi_structured = load_semi_structured_data()
    unstructured = load_unstructured_data()
    print("\n📦 Data staged for analysis.\n")

stage_data()


# 🌟 Highlights
# | Data Type       | File Format | Simulated With      |
# | --------------- | ----------- | ------------------- |
# | Structured      | CSV         | Pandas DataFrame    |
# | Semi-Structured | JSON        | `json_normalize()`  |
# | Unstructured    | TXT/Logs    | Raw text processing |
