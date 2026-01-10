-- Implicit join with multiple conditions
SELECT E.*, D.*
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEP_ID = D.DEPT_ID_DEP
  AND E.SALARY > 50000
  AND D.DEP_NAME LIKE '%Sales%';