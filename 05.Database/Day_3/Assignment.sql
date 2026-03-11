--1. Display all employees who work in the IT department
SELECT *
FROM employee e JOIN department d on e.dept_id = d.dept_id
WHERE d.name='IT';

--2. Display employees whose salary is BETWEEN 4000 AND 9000
SELECT *
FROM employee
WHERE salary BETWEEN 4000 AND 9000;

--3. Display employees whose name starts with 'A' using SIMILAR TO (PostgreSQL Regex Operators)
SELECT *
FROM employee
WHERE name SIMILAR TO 'A%';

--4. Display employees who do NOT belong to any department
SELECT *
FROM employee
WHERE dept_id IS NULL;

--5. Display employees who work in departments 1, 2, or 3 using IN
SELECT *
FROM employee
WHERE dept_id IN (1,2,3);

--6. Display employee name and salary level using CASE WHEN
-- High if salary > 8000
-- Medium if salary BETWEEN 4000 AND 8000
-- Low if salary < 4000
SELECT *, 
CASE 
	WHEN salary > 8000 THEN 'High' 
	WHEN salary BETWEEN 4000 AND 8000 THEN 'Medium' 
	WHEN salary <4000 THEN 'Low' 
END AS salary_level
FROM employee 

--7. Display employees who are assigned to at least one project using EXISTS
SELECT *
FROM employee e
WHERE EXISTS (
    SELECT 1
    FROM projects p
    WHERE p.dept_id = e.dept_id
);

--8. Display employees whose salary is greater than ANY salary in department 2
SELECT *
FROM employee 
WHERE salary > ANY (
SELECT salary
FROM employee
WHERE dept_id =2  
);

--9. Display the employee who has the HIGHEST salary using a subquery

SELECT *
FROM employee
WHERE salary = (SELECT MAX(salary) FROM employee);

-- OTHER SOLUTION
SELECT *
FROM employee 
Order BY salary desc 
LIMIT 1;

--10. Create a table called High_Salary_Employees and insert employees whose salary > 8000 using INSERT INTO … SELECT
CREATE TABLE High_Salary_Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50) NOT NULL,
    salary NUMERIC(10,2) CHECK (salary > 0),
    hire_date DATE,
    dept_id INT
);

INSERT INTO High_Salary_Employees (emp_id, emp_name, salary, hire_date, dept_id)
SELECT emp_id, emp_name, salary, hire_date, dept_id
FROM employee
WHERE salary > 8000;

--11. Delete employees who are NOT assigned to any project
DELETE FROM employee
WHERE emp_id NOT IN (
    SELECT emp_id FROM employee_projects
);

--12. Display departments that do NOT have any employees using NOT EXISTS
SELECT dept_id, dept_name
FROM department d
WHERE NOT EXISTS (
    SELECT 1
    FROM employee e
    WHERE e.dept_id = d.dept_id
);

-- OTHER SOLUTION
SELECT dept_id, dept_name
FROM department
WHERE dept_id NOT IN (
    SELECT dept_id
    FROM employee
    WHERE dept_id IS NOT NULL
);

--13. Display all DISTINCT department locations
SELECT DISTINCT(location)
FROM department

--14. Create a calculated column showing salary after 10% bonus
SELECT emp_name, salary, ROUND(salary * 1.10, 2) AS salary_after_bonus
from employee

--15. Display employee names in UPPER, LOWER, and INITCAP formats
SELECT UPPER(emp_name)
FROM employee;

SELECT LOWER(emp_name)
FROM employee;

SELECT INITCAP(emp_name)
FROM employee;

--16. Remove spaces from employee names using TRIM, LTRIM, and RTRIM
UPDATE employee
SET emp_name = TRIM(emp_name);

--17. Concatenate first_name and last_name into a single column using CONCAT
SELECT CONCAT(emp_id, ' ', emp_name) AS employee_concat
FROM employee;

--18. Extract a substring of employee names using SUBSTRING
SELECT 
    SUBSTR(emp_name, 1, 5) AS first_five_letters
FROM employee;

--19. Find the POSITION of a character or substring in employee names using POSITION
SELECT 
    emp_name,
    POSITION('a' IN emp_name) AS position_of_a
FROM employee;

--20. Replace a part of employee name using REPLACE
SELECT emp_name, Replace(emp_name,'Alice','Hazem') as new_name
FROM employee;

--21. Change the data type of salary to INTEGER using CAST
SELECT salary::INT as int_salary , salary::Text as text_salary
FROM employee;