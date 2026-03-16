-- 1. Using the employee table, find the average salary per department, 
-- and then display only the departments where the average salary is greater than 4000. 
-- Use a CTE (WITH clause).
WITH dept_avg_salary AS (
    SELECT e.dept_id, ROUND(AVG(salary),2) AS avg_salary
    FROM employee e
    WHERE e.dept_id IS NOT NULL
    GROUP BY e.dept_id
    HAVING AVG(salary) > 4000
)

SELECT d.dept_name, avg_salary
FROM department d
JOIN dept_avg_salary USING (dept_id);

-- 2. List employees who do not work in the 'IT' department. Use the EXCEPT clause.
SELECT e.emp_name, d.dept_name
FROM employee e JOIN department d USING (dept_id)
EXCEPT
SELECT e.emp_name, d.dept_name
FROM employee e JOIN department d USING (dept_id)
WHERE d.dept_name = 'IT'

-- 3. Find employees who are in both the 'Sales' and 'Marketing' projects 
-- (assuming works_on table). Use INTERSECT.
SELECT e.emp_name
FROM employee e
JOIN works_on w USING (emp_id)
JOIN projects p USING (project_id)
WHERE p.project_name = 'Sales'

INTERSECT

SELECT e.emp_name
FROM employee e
JOIN works_on w USING (emp_id)
JOIN projects p USING (project_id)
WHERE p.project_name = 'Marketing';

-- 4. Update the salary of employee emp_id = 5 to 6000. 
-- Then update department of emp_id = 5 to 3. If any error occurs, 
-- rollback the changes. Write the SQL commands.
BEGIN;

UPDATE employee
SET salary = 6000
WHERE emp_id = 105;

UPDATE employee
SET dept_id = 3
WHERE emp_id = 105;

COMMIT;
--ROLLBACK;

-- 5. Show employees who work in the Sales department.
SELECT e.emp_name, d.dept_id
FROM employee e 
JOIN department d USING(dept_id)
WHERE d.dept_name = 'Sales'

-- OTHER 

WITH sales_dept AS (
    SELECT dept_id , dept_name
    FROM department
    WHERE dept_name = 'Sales'
)

SELECT e.emp_name, e.dept_id , dept_name
FROM employee e
JOIN sales_dept USING (dept_id);

-- 6. Show employees who have tasks with priority 'High'.
WITH high_priority_tasks AS (
	SELECT priority , emp_id
	FROM tasks
	WHERE priority = 'High'
)

SELECT emp_id, emp_name
FROM employee 
JOIN high_priority_tasks USING (emp_id)

-- 7. Show employees who have tasks due today.
WITH tasks_due_today AS (
	SELECT due_date , emp_id
	FROM tasks
	WHERE due_date = CURRENT_DATE
)

SELECT emp_id, emp_name
FROM employee 
JOIN tasks_due_today USING (emp_id)

-- 8. Show employees who do not have any tasks with status 'Completed'.
WITH completed_tasks AS (
	SELECT emp_id
	FROM tasks
	WHERE status = 'Completed'
)

SELECT emp_name, emp_id
FROM employee
WHERE emp_id NOT IN (
    SELECT emp_id FROM completed_tasks
);

-- 9. Show employees who have more than 2 tasks.
WITH more_than_two_tasks AS (
	SELECT emp_id
	FROM tasks
	GROUP BY emp_id
	HAVING COUNT(task_id)>2
)

SELECT emp_name, emp_id
FROM employee
JOIN more_than_two_tasks USING (emp_id)

-- 10. Show tasks that have a due date later than the latest completed task.
WITH latest_completed_task AS (
	SELECT due_date
	FROM tasks
	WHERE status = 'Completed'
	ORDER BY due_date DESC
	LIMIT 1
)

SELECT task_id, task_name
FROM tasks
WHERE status != 'Completed' AND due_date > (SELECT due_date FROM latest_completed_task)

-- 11. Show employee names who are assigned High priority tasks.
WITH high_priority_tasks AS (
	SELECT priority , emp_id
	FROM tasks
	WHERE priority = 'High'
)

SELECT emp_id, emp_name
FROM employee 
JOIN high_priority_tasks USING (emp_id)

-- 12. Show employees who have at least one completed task.
WITH completed_task AS (
	SELECT emp_id
	FROM tasks
	WHERE status= 'Completed'
)

SELECT emp_name, emp_id
FROM employee
JOIN completed_task USING (emp_id)

