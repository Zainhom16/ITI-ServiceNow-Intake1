CREATE TABLE departments (
    dept_id SERIAL PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL
);


CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    salary NUMERIC(10, 2) CHECK (salary > 0),
    dept_id INT,
    hire_date DATE
);

ALTER TABLE employees
ADD CONSTRAINT fk_emp_dept
FOREIGN KEY (dept_id)
REFERENCES departments(dept_id)
ON DELETE CASCADE
ON UPDATE CASCADE;

CREATE TABLE projects (
    project_id SERIAL PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    dept_id INT
);

ALTER TABLE projects
ADD CONSTRAINT fk_proj_dept
FOREIGN KEY (dept_id)
REFERENCES departments(dept_id)
ON DELETE SET NULL
ON UPDATE CASCADE;

INSERT INTO departments (dept_name) VALUES
('Accounting'),
('Human Resources'),
('Information Technology');

INSERT INTO employees (emp_name, salary, dept_id, hire_date) VALUES
('Ahmed Mohamed', 8500.00, 1, '2021-03-15'),
('Fatma Ali', 7200.00, 2, '2020-07-01'),
('Mahmoud Hassan', 9300.00, 3, '2019-11-20'),
('Nora Ibrahim', 6800.00, 1, '2022-01-10'),
('Omar Khaled', 11000.00, 3, '2018-05-30');

INSERT INTO projects (project_name, dept_id) VALUES
('Payroll Management System', 1),
('Online Recruitment Platform', 2),
('Infrastructure Development', 3);

UPDATE employees
SET salary = salary + 1000
WHERE emp_id = 1;

UPDATE employees
SET dept_id = 2
WHERE emp_id = 3;

ALTER TABLE employees
ADD COLUMN email VARCHAR(150) UNIQUE;

ALTER TABLE departments
ADD COLUMN phone VARCHAR(20);

ALTER TABLE employees
ALTER COLUMN salary SET NOT NULL;

UPDATE departments
SET dept_id = 10
WHERE dept_id = 1;
