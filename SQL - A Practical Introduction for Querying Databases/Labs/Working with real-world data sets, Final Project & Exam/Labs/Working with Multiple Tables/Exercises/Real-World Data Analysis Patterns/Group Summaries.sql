-- Summarize by category
SELECT category_column, 
       AGGREGATE_FUNCTION(metric_column)
FROM table
GROUP BY category_column;