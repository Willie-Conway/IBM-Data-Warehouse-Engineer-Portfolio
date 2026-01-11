-- Clean data during query execution
SELECT REPLACE(column, 'unwanted_char', ''),
       CAST(cleaned_string AS type)
FROM table;