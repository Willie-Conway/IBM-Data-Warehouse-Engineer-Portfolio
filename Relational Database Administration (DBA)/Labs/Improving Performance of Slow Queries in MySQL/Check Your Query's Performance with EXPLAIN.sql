-- Step 1: Make sure you're using the correct database
USE employees;

-- Step 2: Run the initial SELECT query
SELECT * FROM employees;

-- Step 3: Use EXPLAIN to analyze the query performance
EXPLAIN SELECT * FROM employees;

-- Optional: Limit your results to make it faster for testing
EXPLAIN SELECT * FROM employees LIMIT 10;

-- Optional: Run a filtered query and examine again
EXPLAIN SELECT * FROM employees WHERE emp_no = 10001;
