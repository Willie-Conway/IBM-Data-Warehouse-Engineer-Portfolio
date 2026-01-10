-- Find employees earning more than their department average
SELECT E.EMP_ID, E.F_NAME, E.L_NAME, E.SALARY, E.DEP_ID,
       (SELECT AVG(SALARY) 
        FROM EMPLOYEES 
        WHERE DEP_ID = E.DEP_ID) AS DEP_AVG
FROM EMPLOYEES E
WHERE E.SALARY > (SELECT AVG(SALARY) 
                  FROM EMPLOYEES 
                  WHERE DEP_ID = E.DEP_ID);