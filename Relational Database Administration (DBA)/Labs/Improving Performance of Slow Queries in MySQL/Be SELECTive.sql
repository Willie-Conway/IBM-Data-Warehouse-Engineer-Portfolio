-- Practice Exercise 1: View all columns from the salaries table
SELECT * FROM salaries;

-- Check how many rows were scanned
EXPLAIN SELECT * FROM salaries;

-- Practice Exercise 1: Select only emp_no and salary
SELECT emp_no, salary FROM salaries;

-- Check how many rows were scanned for selective columns
EXPLAIN SELECT emp_no, salary FROM salaries;


-- Practice Exercise 2: Select only emp_no and title from titles table
SELECT emp_no, title FROM titles;

-- Check how many rows were scanned
EXPLAIN SELECT emp_no, title FROM titles;

-- (Optional) For comparison: Select all from titles
SELECT * FROM titles;

-- Explain for full SELECT on titles
EXPLAIN SELECT * FROM titles;
