--- LEFT OUTER JOIN Syntax(Returns all records from left table, matched records from right table.)
SELECT column_name(s)
FROM table1
LEFT OUTER JOIN table2
ON table1.column_name = table2.column_name
WHERE condition;