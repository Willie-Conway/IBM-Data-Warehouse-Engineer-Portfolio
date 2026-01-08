-- ============================================
-- HR Database Creation Script
-- Database: HR
-- ============================================

-- Create HR database if it doesn't exist
CREATE DATABASE IF NOT EXISTS HR 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_0900_ai_ci;

USE HR;

-- ============================================
-- CREATE TABLES
-- ============================================

-- Table 1: LOCATIONS
CREATE TABLE IF NOT EXISTS LOCATIONS (
    LOCATION_ID INT PRIMARY KEY,
    STREET_ADDRESS VARCHAR(40),
    POSTAL_CODE VARCHAR(12),
    CITY VARCHAR(30) NOT NULL,
    STATE_PROVINCE VARCHAR(25),
    COUNTRY_ID CHAR(2)
);

-- Table 2: DEPARTMENTS
CREATE TABLE IF NOT EXISTS DEPARTMENTS (
    DEPARTMENT_ID INT PRIMARY KEY,
    DEPARTMENT_NAME VARCHAR(30) NOT NULL,
    MANAGER_ID INT,
    LOCATION_ID INT,
    FOREIGN KEY (LOCATION_ID) REFERENCES LOCATIONS(LOCATION_ID)
);

-- Table 3: JOBS
CREATE TABLE IF NOT EXISTS JOBS (
    JOB_ID VARCHAR(10) PRIMARY KEY,
    JOB_TITLE VARCHAR(35) NOT NULL,
    MIN_SALARY DECIMAL(8,2),
    MAX_SALARY DECIMAL(8,2)
);

-- Table 4: EMPLOYEES
CREATE TABLE IF NOT EXISTS EMPLOYEES (
    EMPLOYEE_ID INT PRIMARY KEY,
    FIRST_NAME VARCHAR(20),
    LAST_NAME VARCHAR(25) NOT NULL,
    EMAIL VARCHAR(25) NOT NULL UNIQUE,
    PHONE_NUMBER VARCHAR(20),
    HIRE_DATE DATE NOT NULL,
    JOB_ID VARCHAR(10) NOT NULL,
    SALARY DECIMAL(8,2),
    COMMISSION_PCT DECIMAL(2,2),
    MANAGER_ID INT,
    DEPARTMENT_ID INT,
    FOREIGN KEY (JOB_ID) REFERENCES JOBS(JOB_ID),
    FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPARTMENTS(DEPARTMENT_ID),
    FOREIGN KEY (MANAGER_ID) REFERENCES EMPLOYEES(EMPLOYEE_ID)
);

-- Table 5: JOB_HISTORY
CREATE TABLE IF NOT EXISTS JOB_HISTORY (
    EMPLOYEE_ID INT NOT NULL,
    START_DATE DATE NOT NULL,
    END_DATE DATE NOT NULL,
    JOB_ID VARCHAR(10) NOT NULL,
    DEPARTMENT_ID INT NOT NULL,
    PRIMARY KEY (EMPLOYEE_ID, START_DATE),
    FOREIGN KEY (EMPLOYEE_ID) REFERENCES EMPLOYEES(EMPLOYEE_ID),
    FOREIGN KEY (JOB_ID) REFERENCES JOBS(JOB_ID),
    FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPARTMENTS(DEPARTMENT_ID),
    CHECK (END_DATE > START_DATE)
);

-- ============================================
-- INSERT SAMPLE DATA
-- ============================================

-- Insert data into LOCATIONS table
INSERT INTO LOCATIONS (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID) VALUES
(1000, '1297 Via Cola di Rie', '00989', 'Roma', NULL, 'IT'),
(1100, '93091 Calle della Testa', '10934', 'Venice', NULL, 'IT'),
(1200, '2017 Shinjuku-ku', '1689', 'Tokyo', 'Tokyo Prefecture', 'JP'),
(1300, '9450 Kamiya-cho', '6823', 'Hiroshima', NULL, 'JP'),
(1400, '2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 'US'),
(1500, '2011 Interiors Blvd', '99236', 'South San Francisco', 'California', 'US'),
(1600, '2007 Zagora St', '50090', 'South Brunswick', 'New Jersey', 'US'),
(1700, '2004 Charade Rd', '98199', 'Seattle', 'Washington', 'US'),
(1800, '147 Spadina Ave', 'M5V 2L7', 'Toronto', 'Ontario', 'CA'),
(1900, '6092 Boxwood St', 'YSW 9T2', 'Whitehorse', 'Yukon', 'CA');

-- Insert data into DEPARTMENTS table
INSERT INTO DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) VALUES
(10, 'Administration', 200, 1700),
(20, 'Marketing', 201, 1800),
(30, 'Purchasing', 114, 1700),
(40, 'Human Resources', 203, 2400),
(50, 'Shipping', 121, 1500),
(60, 'IT', 103, 1400),
(70, 'Public Relations', 204, 2700),
(80, 'Sales', 145, 2500),
(90, 'Executive', 100, 1700),
(100, 'Finance', 108, 1700),
(110, 'Accounting', 205, 1700),
(120, 'Treasury', NULL, 1700),
(130, 'Corporate Tax', NULL, 1700),
(140, 'Control And Credit', NULL, 1700),
(150, 'Shareholder Services', NULL, 1700),
(160, 'Benefits', NULL, 1700),
(170, 'Manufacturing', NULL, 1700),
(180, 'Construction', NULL, 1700),
(190, 'Contracting', NULL, 1700),
(200, 'Operations', NULL, 1700),
(210, 'IT Support', NULL, 1700),
(220, 'NOC', NULL, 1700),
(230, 'IT Helpdesk', NULL, 1700),
(240, 'Government Sales', NULL, 1700),
(250, 'Retail Sales', NULL, 1700),
(260, 'Recruiting', NULL, 1700),
(270, 'Payroll', NULL, 1700);

-- Insert data into JOBS table
INSERT INTO JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY) VALUES
('AD_PRES', 'President', 20000, 40000),
('AD_VP', 'Administration Vice President', 15000, 30000),
('AD_ASST', 'Administration Assistant', 3000, 6000),
('FI_MGR', 'Finance Manager', 8200, 16000),
('FI_ACCOUNT', 'Accountant', 4200, 9000),
('AC_MGR', 'Accounting Manager', 8200, 16000),
('AC_ACCOUNT', 'Public Accountant', 4200, 9000),
('SA_MAN', 'Sales Manager', 10000, 20000),
('SA_REP', 'Sales Representative', 6000, 12000),
('PU_MAN', 'Purchasing Manager', 8000, 15000),
('PU_CLERK', 'Purchasing Clerk', 2500, 5500),
('ST_MAN', 'Stock Manager', 5500, 8500),
('ST_CLERK', 'Stock Clerk', 2000, 5000),
('SH_CLERK', 'Shipping Clerk', 2500, 5500),
('IT_PROG', 'Programmer', 4000, 10000),
('MK_MAN', 'Marketing Manager', 9000, 15000),
('MK_REP', 'Marketing Representative', 4000, 9000),
('HR_REP', 'Human Resources Representative', 4000, 9000),
('PR_REP', 'Public Relations Representative', 4500, 10500);

-- Insert data into EMPLOYEES table
INSERT INTO EMPLOYEES (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) VALUES
(100, 'Steven', 'King', 'SKING', '515.123.4567', '1987-06-17', 'AD_PRES', 24000, NULL, NULL, 90),
(101, 'Neena', 'Kochhar', 'NKOCHHAR', '515.123.4568', '1989-09-21', 'AD_VP', 17000, NULL, 100, 90),
(102, 'Lex', 'De Haan', 'LDEHAAN', '515.123.4569', '1993-01-13', 'AD_VP', 17000, NULL, 100, 90),
(103, 'Alexander', 'Hunold', 'AHUNOLD', '590.423.4567', '1990-01-03', 'IT_PROG', 9000, NULL, 102, 60),
(104, 'Bruce', 'Ernst', 'BERNST', '590.423.4568', '1991-05-21', 'IT_PROG', 6000, NULL, 103, 60),
(105, 'David', 'Austin', 'DAUSTIN', '590.423.4569', '1997-06-25', 'IT_PROG', 4800, NULL, 103, 60),
(106, 'Valli', 'Pataballa', 'VPATABAL', '590.423.4560', '1998-02-05', 'IT_PROG', 4800, NULL, 103, 60),
(107, 'Diana', 'Lorentz', 'DLORENTZ', '590.423.5567', '1999-02-07', 'IT_PROG', 4200, NULL, 103, 60),
(108, 'Nancy', 'Greenberg', 'NGREENBE', '515.124.4569', '1994-08-17', 'FI_MGR', 12000, NULL, 101, 100),
(109, 'Daniel', 'Faviet', 'DFAVIET', '515.124.4169', '1994-08-16', 'FI_ACCOUNT', 9000, NULL, 108, 100),
(110, 'John', 'Chen', 'JCHEN', '515.124.4269', '1997-09-28', 'FI_ACCOUNT', 8200, NULL, 108, 100),
(111, 'Ismael', 'Sciarra', 'ISCIARRA', '515.124.4369', '1997-09-30', 'FI_ACCOUNT', 7700, NULL, 108, 100),
(112, 'Jose Manuel', 'Urman', 'JMURMAN', '515.124.4469', '1998-03-07', 'FI_ACCOUNT', 7800, NULL, 108, 100),
(113, 'Luis', 'Popp', 'LPOPP', '515.124.4567', '1999-12-07', 'FI_ACCOUNT', 6900, NULL, 108, 100),
(114, 'Den', 'Raphaely', 'DRAPHEAL', '515.127.4561', '1994-12-07', 'PU_MAN', 11000, NULL, 100, 30),
(115, 'Alexander', 'Khoo', 'AKHOO', '515.127.4562', '1995-05-18', 'PU_CLERK', 3100, NULL, 114, 30),
(116, 'Shelli', 'Baida', 'SBAIDA', '515.127.4563', '1997-12-24', 'PU_CLERK', 2900, NULL, 114, 30),
(117, 'Sigal', 'Tobias', 'STOBIAS', '515.127.4564', '1997-07-24', 'PU_CLERK', 2800, NULL, 114, 30),
(118, 'Guy', 'Himuro', 'GHIMURO', '515.127.4565', '1998-11-15', 'PU_CLERK', 2600, NULL, 114, 30),
(119, 'Karen', 'Colmenares', 'KCOLMENA', '515.127.4566', '1999-08-10', 'PU_CLERK', 2500, NULL, 114, 30),
(120, 'Matthew', 'Weiss', 'MWEISS', '650.123.1234', '1996-07-18', 'ST_MAN', 8000, NULL, 100, 50),
(121, 'Adam', 'Fripp', 'AFRIPP', '650.123.2234', '1997-04-10', 'ST_MAN', 8200, NULL, 100, 50),
(122, 'Payam', 'Kaufling', 'PKAUFLIN', '650.123.3234', '1995-05-01', 'ST_MAN', 7900, NULL, 100, 50),
(123, 'Shanta', 'Vollman', 'SVOLLMAN', '650.123.4234', '1997-10-10', 'ST_MAN', 6500, NULL, 100, 50),
(124, 'Kevin', 'Mourgos', 'KMOURGOS', '650.123.5234', '1999-11-16', 'ST_MAN', 5800, NULL, 100, 50),
(125, 'Julia', 'Nayer', 'JNAYER', '650.124.1214', '1997-07-16', 'ST_CLERK', 3200, NULL, 120, 50),
(126, 'Irene', 'Mikkilineni', 'IMIKKILI', '650.124.1224', '1998-09-28', 'ST_CLERK', 2700, NULL, 120, 50),
(127, 'James', 'Landry', 'JLANDRY', '650.124.1334', '1999-01-14', 'ST_CLERK', 2400, NULL, 120, 50),
(128, 'Steven', 'Markle', 'SMARKLE', '650.124.1434', '2000-03-08', 'ST_CLERK', 2200, NULL, 120, 50),
(129, 'Laura', 'Bissot', 'LBISSOT', '650.124.5234', '1997-08-20', 'ST_CLERK', 3300, NULL, 121, 50),
(130, 'Mozhe', 'Atkinson', 'MATKINSO', '650.124.6234', '1997-10-30', 'ST_CLERK', 2800, NULL, 121, 50);

-- Insert data into JOB_HISTORY table
INSERT INTO JOB_HISTORY (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID) VALUES
(101, '1989-09-21', '1993-10-27', 'AC_ACCOUNT', 110),
(101, '1993-10-28', '1997-03-15', 'AC_MGR', 110),
(102, '1993-01-13', '1998-07-24', 'IT_PROG', 60),
(114, '1998-03-24', '1999-12-31', 'ST_CLERK', 50),
(122, '1999-01-01', '1999-12-31', 'ST_CLERK', 50),
(200, '1987-09-17', '1993-06-17', 'AD_ASST', 90),
(176, '1998-03-24', '1998-12-31', 'SA_REP', 80),
(176, '1999-01-01', '1999-12-31', 'SA_MAN', 80),
(200, '1994-07-01', '1998-12-31', 'AC_ACCOUNT', 90);

-- ============================================
-- VERIFICATION QUERIES
-- ============================================

-- Verify all tables were created
SHOW TABLES;

-- Count records in each table
SELECT 'LOCATIONS' as TABLE_NAME, COUNT(*) as RECORD_COUNT FROM LOCATIONS
UNION ALL
SELECT 'DEPARTMENTS', COUNT(*) FROM DEPARTMENTS
UNION ALL
SELECT 'JOBS', COUNT(*) FROM JOBS
UNION ALL
SELECT 'EMPLOYEES', COUNT(*) FROM EMPLOYEES
UNION ALL
SELECT 'JOB_HISTORY', COUNT(*) FROM JOB_HISTORY;

-- Display sample data from each table
SELECT '=== LOCATIONS TABLE (First 5 rows) ===' as '';
SELECT * FROM LOCATIONS LIMIT 5;

SELECT '=== DEPARTMENTS TABLE (First 5 rows) ===' as '';
SELECT * FROM DEPARTMENTS LIMIT 5;

SELECT '=== JOBS TABLE (First 5 rows) ===' as '';
SELECT * FROM JOBS LIMIT 5;

SELECT '=== EMPLOYEES TABLE (First 5 rows) ===' as '';
SELECT * FROM EMPLOYEES LIMIT 5;

SELECT '=== JOB_HISTORY TABLE (All rows) ===' as '';
SELECT * FROM JOB_HISTORY;

-- ============================================
-- DATABASE SCHEMA INFORMATION
-- ============================================

-- Show table structures
SELECT 'Table Structures:' as '';
DESCRIBE LOCATIONS;
DESCRIBE DEPARTMENTS;
DESCRIBE JOBS;
DESCRIBE EMPLOYEES;
DESCRIBE JOB_HISTORY;

-- ============================================
-- SAMPLE ANALYSIS QUERIES
-- ============================================

-- 1. Employees by Department
SELECT 
    d.DEPARTMENT_NAME,
    COUNT(e.EMPLOYEE_ID) as EMPLOYEE_COUNT,
    ROUND(AVG(e.SALARY), 2) as AVG_SALARY
FROM DEPARTMENTS d
LEFT JOIN EMPLOYEES e ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
GROUP BY d.DEPARTMENT_ID, d.DEPARTMENT_NAME
HAVING COUNT(e.EMPLOYEE_ID) > 0
ORDER BY EMPLOYEE_COUNT DESC;

-- 2. Highest Paid Employees
SELECT 
    CONCAT(FIRST_NAME, ' ', LAST_NAME) as FULL_NAME,
    JOB_TITLE,
    DEPARTMENT_NAME,
    SALARY
FROM EMPLOYEES e
JOIN JOBS j ON e.JOB_ID = j.JOB_ID
JOIN DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
ORDER BY SALARY DESC
LIMIT 10;

-- 3. Departments by Location
SELECT 
    d.DEPARTMENT_NAME,
    l.CITY,
    l.COUNTRY_ID,
    COUNT(e.EMPLOYEE_ID) as EMPLOYEE_COUNT
FROM DEPARTMENTS d
JOIN LOCATIONS l ON d.LOCATION_ID = l.LOCATION_ID
LEFT JOIN EMPLOYEES e ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
GROUP BY d.DEPARTMENT_ID, d.DEPARTMENT_NAME, l.CITY, l.COUNTRY_ID
ORDER BY l.COUNTRY_ID, l.CITY;

-- 4. Employee Job History
SELECT 
    CONCAT(e.FIRST_NAME, ' ', e.LAST_NAME) as EMPLOYEE_NAME,
    jh.START_DATE,
    jh.END_DATE,
    j.JOB_TITLE as PREVIOUS_JOB,
    d.DEPARTMENT_NAME as PREVIOUS_DEPARTMENT
FROM JOB_HISTORY jh
JOIN EMPLOYEES e ON jh.EMPLOYEE_ID = e.EMPLOYEE_ID
JOIN JOBS j ON jh.JOB_ID = j.JOB_ID
JOIN DEPARTMENTS d ON jh.DEPARTMENT_ID = d.DEPARTMENT_ID
ORDER BY e.LAST_NAME, jh.START_DATE;

-- ============================================
-- CSV FORMAT FOR IMPORT (Sample data)
-- ============================================

/*
To create CSV files for import, you can use the following format:

1. departments.csv:
DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID
10,Administration,200,1700
20,Marketing,201,1800
30,Purchasing,114,1700
...

2. employees.csv:
EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID
100,Steven,King,SKING,515.123.4567,1987-06-17,AD_PRES,24000,,,90
101,Neena,Kochhar,NKOCHHAR,515.123.4568,1989-09-21,AD_VP,17000,,100,90
...

3. jobs.csv:
JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY
AD_PRES,President,20000,40000
AD_VP,Administration Vice President,15000,30000
...

4. locations.csv:
LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID
1000,1297 Via Cola di Rie,00989,Roma,,IT
1100,93091 Calle della Testa,10934,Venice,,IT
...

5. job_history.csv:
EMPLOYEE_ID,START_DATE,END_DATE,JOB_ID,DEPARTMENT_ID
101,1989-09-21,1993-10-27,AC_ACCOUNT,110
101,1993-10-28,1997-03-15,AC_MGR,110
...
*/

-- ============================================
-- IMPORT INSTRUCTIONS FOR phpMyAdmin
-- ============================================

/*
Steps to import this script in phpMyAdmin:

1. Create a new database named "HR"
2. Select the "HR" database
3. Go to the "SQL" tab
4. Copy and paste this entire script
5. Click "Go" to execute

OR to import via file:

1. Save this script as "HR_Database_Create_Tables_Script.sql"
2. In phpMyAdmin, select "HR" database
3. Go to "Import" tab
4. Click "Choose File" and select the .sql file
5. Click "Go" to import

For CSV import (alternative method):

1. Export data from each table as CSV:
   SELECT * FROM LOCATIONS INTO OUTFILE 'locations.csv' ...;
   
2. In phpMyAdmin, select table
3. Go to "Import" tab
4. Choose CSV file and set format
5. Click "Go" to import
*/

-- ============================================
-- FINAL VERIFICATION
-- ============================================

SELECT 'HR Database Created Successfully!' as STATUS;
SELECT 'Total Tables: 5' as SUMMARY;
SELECT '1. LOCATIONS' as TABLES;
SELECT '2. DEPARTMENTS';
SELECT '3. JOBS';
SELECT '4. EMPLOYEES';
SELECT '5. JOB_HISTORY';

-- Display database schema diagram info
SELECT 
    'Database Schema Relationships:' as '';
SELECT 
    '1. DEPARTMENTS ← LOCATIONS (LOCATION_ID)' as RELATIONSHIPS;
SELECT '2. EMPLOYEES ← DEPARTMENTS (DEPARTMENT_ID)';
SELECT '3. EMPLOYEES ← JOBS (JOB_ID)';
SELECT '4. EMPLOYEES ← EMPLOYEES (MANAGER_ID)';
SELECT '5. JOB_HISTORY ← EMPLOYEES (EMPLOYEE_ID)';
SELECT '6. JOB_HISTORY ← JOBS (JOB_ID)';
SELECT '7. JOB_HISTORY ← DEPARTMENTS (DEPARTMENT_ID)';