-- Analyze view performance with EXPLAIN
EXPLAIN SELECT * FROM COMPLEX_VIEW;

-- Consider creating indexes on underlying tables
CREATE INDEX idx_employees_dep_id ON EMPLOYEES(DEP_ID);
CREATE INDEX idx_employees_salary ON EMPLOYEES(SALARY);