-- Step 1: Show existing indexes on the 'employees' table
SHOW INDEX FROM employees;

-- Step 2: Run a SELECT query using the 'hire_date' column
SELECT * FROM employees WHERE hire_date >= '2000-01-01';

-- Step 3: Use EXPLAIN to check performance of the above query
EXPLAIN SELECT * FROM employees WHERE hire_date >= '2000-01-01';

-- Step 4: Create an index on the 'hire_date' column
CREATE INDEX hire_date_index ON employees(hire_date);

-- Step 5: Show indexes again to verify the new index exists
SHOW INDEX FROM employees;

-- Step 6: Re-run the SELECT query to observe performance improvement
SELECT * FROM employees WHERE hire_date >= '2000-01-01';

-- Step 7: Use EXPLAIN to confirm improved performance (fewer rows scanned)
EXPLAIN SELECT * FROM employees WHERE hire_date >= '2000-01-01';

-- Step 8: Drop the index if no longer needed
DROP INDEX hire_date_index ON employees;

-- Step 9: Show indexes again to verify the index was removed
SHOW INDEX FROM employees;
