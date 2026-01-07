
# 🧾 Hands-on Lab: Working with Facts and Dimension Tables

## 🧠 Purpose
Design a star schema data warehouse for a cloud service provider using billing data provided in a CSV file. The schema supports complex queries related to billing performance and trends.

---

## 🎯 Objectives

✅ Study the schema of the CSV file  
✅ Design fact tables  
✅ Design dimension tables  
✅ Create a star schema  
✅ Implement schema using PostgreSQL

---

## 🌟 Benefits of the Lab
- Practical skills in organizing and analyzing large datasets 📊  
- Improved data retrieval performance 🚀  
- Real-world experience with billing data 🧾  
- Insightful reporting and data warehouse design 🏗️

---

## 📁 Source File Overview: `cloud-billing-dataset.csv`

| Field Name    | Description                                  |
|---------------|----------------------------------------------|
| `customerid`  | Customer ID                                   |
| `category`    | Customer type (e.g., Individual, Company)     |
| `country`     | Customer's country                            |
| `industry`    | Customer’s industry (e.g., Legal, Engineering)|
| `month`       | Billing month (format: YYYY-MM)              |
| `billedamount`| Amount billed in USD                         |

---

## 📐 Exercise 2: Design the Fact Table

### 🔢 Fact Table: `FactBilling`
| Field Name     | Description                                      |
|----------------|--------------------------------------------------|
| `billid`       | 🔑 Primary Key - Unique ID for each bill         |
| `customerid`   | 🔗 Foreign Key - Refers to customer               |
| `monthid`      | 🔗 Foreign Key - Refers to month                 |
| `billedamount` | 💵 Amount billed in USD                         |

---

## 📘 Exercise 3: Design the Dimension Tables

### 🧾 Dimension Table: `DimCustomer`
| Field Name   | Description                            |
|--------------|----------------------------------------|
| `customerid` | 🔑 Primary Key                          |
| `category`   | Customer type (Individual/Company)     |
| `country`    | Country of customer                    |
| `industry`   | Customer’s industry                    |

### 📆 Dimension Table: `DimMonth`
| Field Name     | Description                                |
|----------------|--------------------------------------------|
| `monthid`      | 🔑 Primary Key                             |
| `year`         | Year derived from billing month            |
| `month`        | Month number (e.g., 1–12)                  |
| `monthname`    | Full month name (e.g., January)            |
| `quarter`      | Quarter number (1–4)                       |
| `quartername`  | Quarter name (e.g., Q1)                    |

---

## 🌟 Exercise 4: Create the Star Schema

### 📊 Star Schema Tables

| Table Name     | Type      | Description                                                |
|----------------|-----------|------------------------------------------------------------|
| `FactBilling`  | Fact      | Links billing to customer and time dimensions             |
| `DimCustomer`  | Dimension | Customer-specific information                             |
| `DimMonth`     | Dimension | Time-based details derived from the month field           |

🔗 Relationships:
- `FactBilling.customerid` → `DimCustomer.customerid`  
- `FactBilling.monthid` → `DimMonth.monthid`

---

## 🛠️ Exercise 5: Create Schema on PostgreSQL

### ✅ Commands Summary
```bash
# Set PostgreSQL password
export PGPASSWORD=<your_password>

# Create database
createdb -h postgres -U postgres -p 5432 billingDW

# Download SQL schema
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0260EN-SkillsNetwork/labs/Working%20with%20Facts%20and%20Dimension%20Tables/star-schema.sql

# Apply schema
psql -h postgres -U postgres -p 5432 billingDW < star-schema.sql
````

---

## 🧪 Practice Exercises

### 🏬 `DimStore`

| Field Name | Description          |
| ---------- | -------------------- |
| `storeid`  | 🔑 Store identifier  |
| `city`     | City of the store    |
| `country`  | Country of the store |

### 📅 `DimDate`

| Field Name    | Description                           |
| ------------- | ------------------------------------- |
| `dateid`      | 🔑 Date identifier                    |
| `day`         | Day number                            |
| `weekday`     | Weekday number (1=Sunday, 7=Saturday) |
| `weekdayname` | Weekday name (e.g., Monday)           |
| `year`        | Year                                  |
| `month`       | Month number                          |
| `monthname`   | Month name                            |
| `quarter`     | Quarter number                        |
| `quartername` | Quarter name                          |

### 💰 `FactSales`

| Field Name   | Description           |
| ------------ | --------------------- |
| `rowid`      | 🔑 Unique identifier  |
| `storeid`    | 🔗 Refers to DimStore |
| `dateid`     | 🔗 Refers to DimDate  |
| `totalsales` | Total sales in USD    |

---

## 🎉 Congratulations!

You’ve successfully designed a star schema and implemented a working data warehouse model. This is a critical real-world skill for data engineers, analysts, and business intelligence professionals!


