
# 🚀 Hands-on Lab: Setting up a Staging Area with PostgreSQL

## 🧠 Purpose of the Lab

The goal of this lab is to give you **practical skills** in setting up a **staging server** for a data warehouse using **PostgreSQL**. You'll learn how to:

- 🏗️ Create and design a schema
- 🗂️ Load data into dimension and fact tables
- 📊 Run queries to validate and explore the data

---

## 📝 Lab Exercises Overview

### 🔧 Exercise 1: Start the PostgreSQL Server
- Start the PostgreSQL service from the **Skills Network Toolbox**
- 🐳 Environment is run inside a **Docker** container
- ⚠️ **Note**: Sessions are **non-persistent** — finish in one sitting!

---

### 🗃️ Exercise 2: Create Database
```bash
export PGPASSWORD=<your_password>
createdb -h postgres -U postgres -p 5432 billingDW
````

---

### 🧱 Exercise 3: Create Data Warehouse Schema

```bash
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0260EN-SkillsNetwork/labs/Setting%20up%20a%20staging%20area/billing-datawarehouse.tgz
tar -xvzf billing-datawarehouse.tgz
psql -h postgres -U postgres -p 5432 billingDW < star-schema.sql
```

---

### 📥 Exercise 4: Load Dimension Tables

```bash
psql -h postgres -U postgres -p 5432 billingDW < DimCustomer.sql
psql -h postgres -U postgres -p 5432 billingDW < DimMonth.sql
```

---

### 🧮 Exercise 5: Load Fact Table

```bash
psql -h postgres -U postgres -p 5432 billingDW < FactBilling.sql
```

---

### 🔍 Exercise 6: Run a Sample Query

```bash
psql -h postgres -U postgres -p 5432 billingDW < verify.sql
```

✔️ Output shows row counts to verify correct loading.

---

## 🧪 Practice Exercises

### 🛠️ Create a New Practice Database

```bash
createdb -h postgres -U postgres -p 5432 practice
```

### 🧬 Create Schema in Practice Database

```bash
psql -h postgres -U postgres -p 5432 practice < star-schema.sql
```

### 📦 Load All Tables in Practice Database

```bash
psql -h postgres -U postgres -p 5432 practice < DimMonth.sql
psql -h postgres -U postgres -p 5432 practice < DimCustomer.sql
psql -h postgres -U postgres -p 5432 practice < FactBilling.sql
```

### ✅ Verify Table Data in Practice Database

```bash
psql -h postgres -U postgres -p 5432 practice < verify.sql
```

---

## 🏁 Conclusion

🎉 Congratulations! You've successfully:

* Set up a staging server
* Loaded a data warehouse schema
* Inserted data into dimension and fact tables
* Verified data integrity with SQL queries

🛠️ These are **real-world skills** that form the backbone of data warehousing and business intelligence systems.

