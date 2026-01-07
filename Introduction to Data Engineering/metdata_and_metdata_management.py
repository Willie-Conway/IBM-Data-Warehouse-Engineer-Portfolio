# 📘 Metadata and Metadata Management

# ✅ What is Metadata?
# Metadata = Data about data.

# Types:

# Technical Metadata: Data structures, column types, system catalogs.

# Process Metadata: ETL jobs, logs, performance metrics.

# Business Metadata: Meaning of data, source, and business rules.

# 🛠️ What is Metadata Management?
# Managing metadata through policies, tools, and catalogs to ensure data usability, traceability, and governance.

# Core tool: Data Catalog (enables users to find and understand enterprise data).

# 💡 Why It Matters:
# Enhances data discovery, lineage tracking, and governance.

# Supports data quality, security, and consistency across systems.

# 🧰 Popular Tools:
# IBM InfoSphere, Azure Data Catalog, Alation, Informatica, Talend, SAP Info Steward, Watson Knowledge Catalog, Oracle OEMM, and more.

# Simulating a Metadata Management System
# The example below simulates a basic data 
# catalog system with metadata tracking.

import pandas as pd

# Simulated data warehouse table
sales_data = pd.DataFrame({
    'OrderID': [101, 102, 103],
    'CustomerName': ['Alice', 'Bob', 'Charlie'],
    'ProductType': ['Electronics', 'Clothing', 'Grocery'],
    'Amount': [250.0, 80.0, 45.0]
})

# Simulated metadata catalog (business + technical metadata)
data_catalog = pd.DataFrame([
    {
        'ColumnName': 'OrderID',
        'DataType': 'Integer',
        'BusinessDescription': 'Unique ID for each customer order',
        'IsSensitive': False
    },
    {
        'ColumnName': 'CustomerName',
        'DataType': 'String',
        'BusinessDescription': 'Name of the customer placing the order',
        'IsSensitive': True
    },
    {
        'ColumnName': 'ProductType',
        'DataType': 'String',
        'BusinessDescription': 'Type/category of the product sold',
        'IsSensitive': False
    },
    {
        'ColumnName': 'Amount',
        'DataType': 'Float',
        'BusinessDescription': 'Total value of the order',
        'IsSensitive': False
    }
])

# Function to simulate metadata search
def search_metadata(term):
    print(f"🔍 Searching metadata catalog for '{term}':\n")
    results = data_catalog[data_catalog['BusinessDescription'].str.contains(term, case=False)]
    print(results.to_string(index=False) if not results.empty else "No matches found.")

# Function to show full metadata catalog
def show_metadata():
    print("📘 Data Catalog Metadata:\n")
    print(data_catalog.to_string(index=False))

# Simulate user interaction
if __name__ == "__main__":
    show_metadata()
    print("\n---\n")
    search_metadata("customer")


# ✅ What This Code Demonstrates:

# | Feature              | Type                          | Purpose                                  |
# | -------------------- | ----------------------------- | ---------------------------------------- |
# | `data_catalog`       | Business + Technical Metadata | Simulates a metadata repository          |
# | `search_metadata()`  | Data Discovery                | Allows users to find columns by purpose  |
# | `IsSensitive` column | Data Governance               | Flags data for compliance/security needs |
