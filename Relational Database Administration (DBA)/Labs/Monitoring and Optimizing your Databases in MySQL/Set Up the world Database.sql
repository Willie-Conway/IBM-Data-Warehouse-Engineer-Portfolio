--  Step 1: Download the SQL script file
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0231EN-SkillsNetwork/datasets/World/world_mysql_script.sql

-- Step 2: Launch MySQL CLI (you do this from the SN Labs GUI)

-- Step 3: Create the database
CREATE DATABASE world;

-- Step 4: Use the world database
USE world;

-- Step 5: Execute the script to create tables and insert data
SOURCE world_mysql_script.sql;

-- Step 6: Confirm tables were created
SHOW TABLES;
