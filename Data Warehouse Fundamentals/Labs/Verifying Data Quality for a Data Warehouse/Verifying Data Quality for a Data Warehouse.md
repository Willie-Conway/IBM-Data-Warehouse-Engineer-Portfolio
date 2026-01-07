
# 🧪 Hands-on Lab: Verifying Data Quality for a Data Warehouse

## 🕒 Estimated Time
**30 minutes**

---

## 🎯 Purpose of the Lab

Learn how to perform **automated data quality checks** in a PostgreSQL-based data warehouse using a **Python testing framework**. You'll identify:

- Null values
- Duplicate entries
- Min/Max range violations
- Invalid values

---

## 🌟 Benefits

- Gain hands-on skills in data quality assurance
- Build reusable data validation scripts
- Understand best practices in data warehousing
- Prepare for real-world data science or database admin roles

---

## ✅ Objectives

In this lab, you will:

- Check for null values
- Check for duplicates
- Check min/max value ranges
- Check for valid values
- Generate a full data quality report

---

## 🔧 Setup Instructions

### 1. Start PostgreSQL Server
- Go to **Skills Network Toolbox** → **PostgreSQL** → Click **Start**

### 2. Prepare Staging Area

```bash
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/8ZUkKar_boDbhNgMiwGAWg/setupstagingarea.sh
export PGPASSWORD=<your_postgres_password>
bash setupstagingarea.sh
````

### 3. Download Python Testing Framework

```bash
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0260EN-SkillsNetwork/labs/Verifying%20Data%20Quality%20for%20a%20Data%20Warehouse/dataqualitychecks.py
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/HB0XK4MDrGwigMmVPmPoeQ/dbconnect.py
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0260EN-SkillsNetwork/labs/Verifying%20Data%20Quality%20for%20a%20Data%20Warehouse/mytests.py
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/saTxV8y9Kt-e8Zxe29M0TA/generate-data-quality-report.py
```

### 4. Install Dependencies

```bash
python3 -m pip install psycopg2 pandas tabulate
```

---

## ⚙️ Update Passwords in Scripts

Update:

* `dbconnect.py` (line 3)
* `generate-data-quality-report.py` (line 15)

Use the password from your **PostgreSQL Connection Info**.

---

## 🔌 Test DB Connection

```bash
python3 dbconnect.py
```

You should see: `Successfully connected to database`

---

## 📄 Generate a Sample Report

```bash
python3 generate-data-quality-report.py
```

---

## 🧪 Practice Exercise Tests

Open `mytests.py` and append the following code to the bottom of the file:

```python
test9 = {
    "testname": "Check for nulls in billedamount",
    "test": check_for_nulls,
    "column": "billedamount",
    "table": "FactBilling"
}

test10 = {
    "testname": "Check for duplicates in billid",
    "test": check_for_duplicates,
    "column": "billid",
    "table": "FactBilling"
}

test11 = {
    "testname": "Check for valid values in quarter",
    "test": check_for_valid_values,
    "column": "quarter",
    "table": "DimMonth",
    "valid_values": {1, 2, 3, 4}
}
```

Save the file and rerun:

```bash
python3 generate-data-quality-report.py
```

---

## ✅ Congratulations!

You’ve successfully completed the **Data Quality Verification Lab** and authored your own tests.

