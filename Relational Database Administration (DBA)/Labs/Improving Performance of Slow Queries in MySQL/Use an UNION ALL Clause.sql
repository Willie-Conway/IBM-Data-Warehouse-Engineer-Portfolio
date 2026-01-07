-- Step 1: Original query using OR
SELECT * 
FROM employees 
WHERE first_name LIKE 'C%' OR last_name LIKE 'C%';

-- Step 2: Check performance with EXPLAIN
EXPLAIN SELECT * 
FROM employees 
WHERE first_name LIKE 'C%' OR last_name LIKE 'C%';

-- Step 3: Create indexes to optimize LIKE with trailing wildcards
CREATE INDEX idx_first_name ON employees(first_name);
CREATE INDEX idx_last_name ON employees(last_name);

-- Step 4: Show indexes on the employees table
SHOW INDEX FROM employees;

-- Step 5: Re-run EXPLAIN after indexes
EXPLAIN SELECT * 
FROM employees 
WHERE first_name LIKE 'C%' OR last_name LIKE 'C%';

-- Step 6: Use UNION ALL instead of OR
SELECT * 
FROM employees 
WHERE first_name LIKE 'C%' 
UNION ALL 
SELECT * 
FROM employees 
WHERE last_name LIKE 'C%';

-- Step 7: Check EXPLAIN for UNION ALL version
EXPLAIN SELECT * 
FROM employees 
WHERE first_name LIKE 'C%' 
UNION ALL 
SELECT * 
FROM employees 
WHERE last_name LIKE 'C%';

-- Step 8: Show that leading wildcard disables index usage
SELECT * 
FROM employees 
WHERE first_name LIKE '%C';

-- Step 9: EXPLAIN on leading wildcard to verify full table scan
EXPLAIN SELECT * 
FROM employees 
WHERE first_name LIKE '%C';
