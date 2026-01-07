--  Step 1: Download the zipped database
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0231EN-SkillsNetwork/datasets/employeesdb.zip

--  Step 2: Unzip the contents
unzip employeesdb.zip

--  Step 3: Move into the extracted folder
cd employeesdb

--  Step 4: Load the data into MySQL
mysql --host=mysql --port=3306 --user=root --password -t < employees.sql

-- Step 5: Select the database
USE employees;

-- Step 6: View all available tables
SHOW TABLES;
