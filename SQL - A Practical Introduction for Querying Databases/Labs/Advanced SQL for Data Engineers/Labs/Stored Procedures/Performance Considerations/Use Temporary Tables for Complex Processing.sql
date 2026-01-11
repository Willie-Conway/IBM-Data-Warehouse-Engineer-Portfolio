CREATE TEMPORARY TABLE temp_results AS
SELECT ... FROM ... WHERE ...;

-- Process temp table
UPDATE temp_results SET ...;

-- Use results
SELECT * FROM temp_results;

DROP TEMPORARY TABLE temp_results;