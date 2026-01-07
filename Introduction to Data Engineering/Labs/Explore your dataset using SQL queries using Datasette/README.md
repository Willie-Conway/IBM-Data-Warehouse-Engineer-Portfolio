
# 🧪 Lab: Explore Your Dataset Using SQL Queries with Datasette

## 🧭 Lab Overview

Now that you have learned how querying techniques can help explore and analyze data, this lab guides you through running **basic SQL queries** using **Datasette** on your loaded dataset.

⏱️ **Estimated time needed**: *15 minutes*

---

## 🎯 Objectives

After completing this lab, you will be able to:

✅ Execute basic SQL queries on data loaded into a Datasette database  
✅ Explore records using SELECT, DISTINCT, and aggregate functions  

---

## 🗃️ Database Used in This Lab

We are using an internal **preloaded** `CarSalesdata` database that contains the table:

📄 `exercise03_car_sales_data`

---

## 🧩 Exercise 1: Execute Basic SQL Queries

### 🔍 1. Find the Maximum Price

```sql
SELECT MAX(price) AS max_price FROM exercise03_car_sales_data;
````

📊 This query returns the highest price value from the dataset.

---

### 🚗 2. Display Distinct Car Models

```sql
SELECT DISTINCT(model) FROM exercise03_car_sales_data;
```

📋 This query lists all **unique** car models in the dataset.

---

## 🎉 Congratulations!

You have successfully executed SQL queries to explore and understand your loaded dataset using Datasette! 💪




