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