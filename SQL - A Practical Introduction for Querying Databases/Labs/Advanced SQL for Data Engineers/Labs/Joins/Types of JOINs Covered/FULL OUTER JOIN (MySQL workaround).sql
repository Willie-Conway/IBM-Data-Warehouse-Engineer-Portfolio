-- FULL OUTER JOIN (Combines LEFT and RIGHT joins using UNION.)
SELECT column_name(s) FROM table1 LEFT OUTER JOIN table2
UNION
SELECT column_name(s) FROM table1 RIGHT OUTER JOIN table2