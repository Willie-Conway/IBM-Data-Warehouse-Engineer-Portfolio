-- This would be the failing attempt:
SELECT EMP_ID, SALARY, MAX(SALARY) AS MAX_SALARY
FROM EMPLOYEES;