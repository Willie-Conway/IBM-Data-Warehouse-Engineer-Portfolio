# 🚗 Hands-On Lab: Load Data into Datasette from a CSV File

## 🧭 Lab Overview

Now that you’ve learned about importing data into a data repository from varied sources, it’s time to **load data from a CSV file into Datasette**.  

⏱️ **Estimated time needed**: *15 minutes*

🔗 **Dataset source**:  
Original: [Kaggle - Car Sale Advertisements](https://www.kaggle.com/antfarol/car-sale-advertisements) *(CC0: Public Domain)*  
**⚠️ Note**: Please use the modified dataset provided with this lab, not the one from Kaggle.

📥 **Download the dataset used for this lab**:  
[exercise03_car_sales_data.csv](https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0100EN-SkillsNetwork/labs/exercise03_car_sales_data.csv)

---

## 🎯 Objectives

By completing this lab, you will be able to:

✅ Create a table from a CSV file using Datasette  
✅ Load data into the table  
✅ Run queries against the loaded data  

---

## 🧪 Exercise 1: Create a Table by Loading a CSV File using Datasette

Let’s load the CSV file into **Datasette** and create a new table.

### 🚀 Steps:

1. Launch the **Datasette** tool using the **Launch App** button.

2. Click the **☰ (three vertical lines)** at the top-right to open the menu.

3. Select **Add DataSets**.

4. On the redirected page, you'll see a text input box.

5. **Right-click** the CSV file link below and **Copy Link Address**:  
   [exercise03_car_sales_data.csv](https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0100EN-SkillsNetwork/labs/exercise03_car_sales_data.csv)

6. Paste the copied URL into the textbox and click **Create**.

📊 A table named `exercise03_car_sales_data` will be created and populated with data from the CSV file.

---

### 🧠 Query the Data

Once the table loads, a **SELECT** query will appear in the query box.

Click on **Submit Query** to run it and view the results.

![Query Interface](./images/Data_img3.png)

---

### 🔁 Modify the Query

Replace the query with:

```sql
SELECT COUNT(*) FROM exercise03_car_sales_data;
````

Click **Submit Query** again.

✅ The result will show the total number of rows (records) in your table.

---

## 🎉 Congratulations!

You’ve successfully:

* Created a table in Datasette
* Loaded data from a CSV file
* Queried the data using SQL

💡 Keep experimenting with other queries to explore the dataset further!


