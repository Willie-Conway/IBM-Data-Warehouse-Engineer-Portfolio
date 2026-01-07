# 🧠 Big Data Platforms

# ✅ Key Concepts

# Big Data is characterized by:

# Volume – massive data size

# Velocity – data coming in fast

# Variety – structured, semi-structured, and unstructured formats

# Why Big Data Platforms?
# Traditional systems can’t handle the scale and complexity of big data.

# 💡 Popular Big Data Technologies

# ⚙️ Tool	    📄 Purpose

# Hadoop	    Distributed storage + processing; HDFS stores big data across many nodes
# Hive	        SQL-like querying on large datasets stored in Hadoop
# Spark	        In-memory big data processing engine, faster and more versatile than Hadoop MapReduce


# 🛢️ PySpark Program to Process Big Data

# This example:

# Uses PySpark to simulate big data processing

# Loads sample data

# Performs transformations

# Aggregates insights

# 💡 Requires: Apache Spark + PySpark installed. 
# (Use in a Spark-enabled environment like Databricks, 
# or install locally with pip install pyspark)

from pyspark.sql import SparkSession
from pyspark.sql.functions import col, avg

# Step 1: Initialize Spark session
spark = SparkSession.builder \
    .appName("BigDataExample") \
    .getOrCreate()

# Step 2: Load a large simulated dataset (e.g., product sales)
data = [
    ("Electronics", "Laptop", 999.99),
    ("Electronics", "Phone", 599.99),
    ("Clothing", "Shirt", 29.99),
    ("Clothing", "Jeans", 49.99),
    ("Grocery", "Apples", 3.99),
    ("Grocery", "Milk", 2.49),
    ("Electronics", "Tablet", 299.99),
    ("Grocery", "Eggs", 2.99)
]

columns = ["Category", "Product", "Price"]

df = spark.createDataFrame(data, columns)

# Step 3: Data transformation and aggregation
result = df.groupBy("Category") \
           .agg(avg("Price").alias("AveragePrice")) \
           .orderBy("AveragePrice", ascending=False)

# Step 4: Show result
result.show()

# Stop Spark session
spark.stop()


# 🔍 What This Demonstrates

# | Spark Concept     | Demonstrated               |
# | ----------------- | -------------------------- |
# | `SparkSession`    | App initialization         |
# | `DataFrame`       | Large-scale data structure |
# | `groupBy + agg()` | Distributed transformation |
# | `show()`          | Output results             |
