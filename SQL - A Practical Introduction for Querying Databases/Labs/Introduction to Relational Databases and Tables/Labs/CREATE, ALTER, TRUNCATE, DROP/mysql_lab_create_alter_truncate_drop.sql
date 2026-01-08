-- Lab: CREATE, ALTER, TRUNCATE, DROP into Tables in MySQL using phpMyAdmin
-- Database: Mysql_Learners

-- ============================================
-- TASK A: CREATE TABLES
-- ============================================

-- Create PETSALE table
CREATE TABLE PETSALE (
    ID INTEGER NOT NULL,
    PET CHAR(20),
    SALEPRICE DECIMAL(6,2),
    PROFIT DECIMAL(6,2),
    SALEDATE DATE
);

-- Create PET table
CREATE TABLE PET (
    ID INTEGER NOT NULL,
    ANIMAL VARCHAR(20),
    QUANTITY INTEGER
);

-- Insert sample data into PETSALE table
INSERT INTO PETSALE VALUES
    (1, 'Cat', 450.09, 100.47, '2018-05-29'),
    (2, 'Dog', 666.66, 150.76, '2018-06-01'),
    (3, 'Parrot', 50.00, 8.9, '2018-06-04'),
    (4, 'Hamster', 60.60, 12, '2018-06-11'),
    (5, 'Goldfish', 48.48, 3.5, '2018-06-14');

-- Insert sample data into PET table
INSERT INTO PET VALUES
    (1, 'Cat', 3),
    (2, 'Dog', 4),
    (3, 'Hamster', 2);

-- View all records from both tables
SELECT * FROM PETSALE;
SELECT * FROM PET;

/*
Expected Output for PETSALE:
+----+----------+-----------+--------+------------+
| ID | PET      | SALEPRICE | PROFIT | SALEDATE   |
+----+----------+-----------+--------+------------+
|  1 | Cat      |    450.09 | 100.47 | 2018-05-29 |
|  2 | Dog      |    666.66 | 150.76 | 2018-06-01 |
|  3 | Parrot   |     50.00 |   8.90 | 2018-06-04 |
|  4 | Hamster  |     60.60 |  12.00 | 2018-06-11 |
|  5 | Goldfish |     48.48 |   3.50 | 2018-06-14 |
+----+----------+-----------+--------+------------+

Expected Output for PET:
+----+---------+----------+
| ID | ANIMAL  | QUANTITY |
+----+---------+----------+
|  1 | Cat     |        3 |
|  2 | Dog     |        4 |
|  3 | Hamster |        2 |
+----+---------+----------+
*/

-- ============================================
-- TASK B: ALTER TABLE OPERATIONS
-- ============================================

-- Task B1: ALTER using ADD COLUMN
-- Add a new QUANTITY column to the PETSALE table
ALTER TABLE PETSALE
ADD COLUMN QUANTITY INTEGER;

-- View the altered table structure
DESCRIBE PETSALE;

-- Update the QUANTITY column with values
UPDATE PETSALE SET QUANTITY = 9 WHERE ID = 1;
UPDATE PETSALE SET QUANTITY = 3 WHERE ID = 2;
UPDATE PETSALE SET QUANTITY = 2 WHERE ID = 3;
UPDATE PETSALE SET QUANTITY = 6 WHERE ID = 4;
UPDATE PETSALE SET QUANTITY = 24 WHERE ID = 5;

-- View all records with the new column
SELECT * FROM PETSALE;

/*
Expected Output:
+----+----------+-----------+--------+------------+----------+
| ID | PET      | SALEPRICE | PROFIT | SALEDATE   | QUANTITY |
+----+----------+-----------+--------+------------+----------+
|  1 | Cat      |    450.09 | 100.47 | 2018-05-29 |        9 |
|  2 | Dog      |    666.66 | 150.76 | 2018-06-01 |        3 |
|  3 | Parrot   |     50.00 |   8.90 | 2018-06-04 |        2 |
|  4 | Hamster  |     60.60 |  12.00 | 2018-06-11 |        6 |
|  5 | Goldfish |     48.48 |   3.50 | 2018-06-14 |       24 |
+----+----------+-----------+--------+------------+----------+
*/

-- Task B2: ALTER using DROP COLUMN
-- Delete the PROFIT column from the PETSALE table
ALTER TABLE PETSALE
DROP COLUMN PROFIT;

-- View the altered table structure
DESCRIBE PETSALE;
SELECT * FROM PETSALE;

/*
Expected Output:
+----+----------+-----------+------------+----------+
| ID | PET      | SALEPRICE | SALEDATE   | QUANTITY |
+----+----------+-----------+------------+----------+
|  1 | Cat      |    450.09 | 2018-05-29 |        9 |
|  2 | Dog      |    666.66 | 2018-06-01 |        3 |
|  3 | Parrot   |     50.00 | 2018-06-04 |        2 |
|  4 | Hamster  |     60.60 | 2018-06-11 |        6 |
|  5 | Goldfish |     48.48 | 2018-06-14 |       24 |
+----+----------+-----------+------------+----------+
*/

-- Task B3: ALTER using ALTER COLUMN (CHANGE in MySQL)
-- Change the data type of PET column from CHAR(20) to VARCHAR(20)
ALTER TABLE PETSALE 
CHANGE PET PET VARCHAR(20);

-- View the altered table structure
DESCRIBE PETSALE;

-- Task B4: ALTER using RENAME COLUMN (CHANGE in MySQL)
-- Rename the column PET to ANIMAL
ALTER TABLE PETSALE 
CHANGE PET ANIMAL VARCHAR(20);

-- View the altered table structure and data
DESCRIBE PETSALE;
SELECT * FROM PETSALE;

/*
Expected Output:
+----+----------+-----------+------------+----------+
| ID | ANIMAL   | SALEPRICE | SALEDATE   | QUANTITY |
+----+----------+-----------+------------+----------+
|  1 | Cat      |    450.09 | 2018-05-29 |        9 |
|  2 | Dog      |    666.66 | 2018-06-01 |        3 |
|  3 | Parrot   |     50.00 | 2018-06-04 |        2 |
|  4 | Hamster  |     60.60 | 2018-06-11 |        6 |
|  5 | Goldfish |     48.48 | 2018-06-14 |       24 |
+----+----------+-----------+------------+----------+
*/

-- ============================================
-- TASK C: TRUNCATE TABLE
-- ============================================

-- Remove all rows from the PET table
TRUNCATE TABLE PET;

-- Verify the table is empty
SELECT * FROM PET;

/*
Expected Output:
Empty set (0 rows)
*/

-- Note: Table structure remains intact, only data is removed
DESCRIBE PET;

-- ============================================
-- TASK D: DROP TABLE
-- ============================================

-- Delete the PET table completely
DROP TABLE PET;

-- Try to select from the dropped table (will show error)
-- SELECT * FROM PET;  -- This will fail because table doesn't exist

-- Verify table doesn't exist by checking information_schema
SELECT 
    TABLE_NAME
FROM 
    information_schema.TABLES
WHERE 
    TABLE_SCHEMA = 'Mysql_Learners' 
    AND TABLE_NAME = 'PET';

/*
Expected Output:
Empty set (table doesn't exist)
*/

-- ============================================
-- ADDITIONAL PRACTICE AND VERIFICATION
-- ============================================

-- 1. Check what tables exist in the database
SHOW TABLES;

/*
Expected Output (only PETSALE should exist):
+------------------------+
| Tables_in_Mysql_Learners |
+------------------------+
| PETSALE                |
+------------------------+
*/

-- 2. View detailed information about remaining table
SHOW CREATE TABLE PETSALE;

-- 3. Count remaining records
SELECT COUNT(*) as Total_Records FROM PETSALE;

-- 4. Summary of operations performed
SELECT 
    'CREATE TABLE' as Operation,
    'PETSALE and PET tables created' as Description
UNION ALL
SELECT 
    'ALTER TABLE ADD COLUMN',
    'Added QUANTITY column to PETSALE'
UNION ALL
SELECT 
    'ALTER TABLE DROP COLUMN',
    'Dropped PROFIT column from PETSALE'
UNION ALL
SELECT 
    'ALTER TABLE CHANGE COLUMN',
    'Changed PET column data type to VARCHAR(20)'
UNION ALL
SELECT 
    'ALTER TABLE RENAME COLUMN',
    'Renamed PET column to ANIMAL'
UNION ALL
SELECT 
    'TRUNCATE TABLE',
    'Removed all rows from PET table'
UNION ALL
SELECT 
    'DROP TABLE',
    'Deleted PET table completely';

-- ============================================
-- CLEANUP AND FINAL VERIFICATION
-- ============================================

-- Final view of the database state
SELECT 
    'Database State Summary' as Summary
UNION ALL
SELECT CONCAT('Tables: ', COUNT(*)) 
FROM information_schema.TABLES 
WHERE TABLE_SCHEMA = 'Mysql_Learners'
UNION ALL
SELECT CONCAT('Total Records in PETSALE: ', COUNT(*)) 
FROM PETSALE;

-- Show final table structure
SELECT 
    'PETSALE Table Structure' as Table_Info
UNION ALL
SELECT '-----------------------'
UNION ALL
SELECT CONCAT(
    'Column: ', COLUMN_NAME, ' | ',
    'Type: ', COLUMN_TYPE, ' | ',
    'Nullable: ', IS_NULLABLE
) 
FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = 'Mysql_Learners' 
  AND TABLE_NAME = 'PETSALE'
ORDER BY ORDINAL_POSITION;

-- ============================================
-- EXTRA PRACTICE: RECREATE AND MANIPULATE TABLES
-- ============================================

-- Optional: Recreate the PET table for additional practice
CREATE TABLE PET (
    ID INTEGER NOT NULL,
    ANIMAL VARCHAR(20),
    QUANTITY INTEGER
);

-- Insert new data
INSERT INTO PET VALUES
    (1, 'Rabbit', 5),
    (2, 'Turtle', 3),
    (3, 'Snake', 2);

-- Show both tables
SELECT 'PETSALE Table:' as Table_Name;
SELECT * FROM PETSALE;

SELECT 'PET Table (recreated):' as Table_Name;
SELECT * FROM PET;

-- ============================================
-- LAB COMPLETION SUMMARY
-- ============================================

/*
Lab Learning Outcomes:
1. ✓ Created a database (Mysql_Learners)
2. ✓ Created tables using CREATE statement
3. ✓ Modified table structure using ALTER statement:
   - ADD COLUMN
   - DROP COLUMN  
   - CHANGE data type
   - RENAME COLUMN
4. ✓ Removed all data using TRUNCATE statement
5. ✓ Deleted table using DROP statement
6. ✓ Verified operations through SELECT queries
*/

SELECT 'Lab Completed Successfully!' as Status;