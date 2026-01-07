-- Task 3.1 - Restore Table (Assumes table already created and CSV loaded externally)
-- Count rows in billing
SELECT COUNT(*) FROM billing;

-- Task 3.2 - Create View
CREATE VIEW basicbilldetails AS
SELECT customerid, month, billedamount
FROM billing;

-- Task 3.3 - Baseline Query Performance
SELECT strftime('%Y-%m-%d %H:%M:%f', 'now');
SELECT * FROM billing WHERE billedamount = 19929;
SELECT strftime('%Y-%m-%d %H:%M:%f', 'now');

-- Task 3.4 - Create Index
CREATE INDEX billingamount ON billing (billedamount);

-- Task 3.5 - Measure Performance After Index
SELECT strftime('%Y-%m-%d %H:%M:%f', 'now');
SELECT * FROM billing WHERE billedamount = 19929;
SELECT strftime('%Y-%m-%d %H:%M:%f', 'now');
