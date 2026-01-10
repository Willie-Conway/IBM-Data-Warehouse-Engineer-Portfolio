-- Employees who have changed jobs (have records in JOB_HISTORY)
SELECT * FROM EMPLOYEES E
WHERE EXISTS (
    SELECT 1 FROM JOB_HISTORY JH
    WHERE JH.EMP_ID = E.EMP_ID
);