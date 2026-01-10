select EMP_ID, F_NAME, L_NAME, SALARY 
from EMPLOYEES 
where SALARY < 
	(select AVG(SALARY) 
	from EMPLOYEES)
;

select EMP_ID, SALARY, ( select MAX(SALARY) from employees ) AS MAX_SALARY 
from EMPLOYEES
;

select * 
from ( select EMP_ID, F_NAME, L_NAME, DEP_ID from EMPLOYEES) AS EMP4ALL 
;