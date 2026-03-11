-- 1. Delete Patient 
DELETE FROM patients
WHERE patient_id=105;

-- 2. Display doctors works in Cardiology with salaries >12000
SELECT * 
FROM doctors
WHERE specialization= 'Cardiology' AND salary>12000

--3. Doctors with first-name starts with M (Case Sensitive)
SELECT *
FROM doctors
WHERE first_name LIKE 'M%';

--4. Doctors with salary between 10000 and 20000
SELECT * 
FROM doctors
WHERE salary BETWEEN 10000 AND 20000;

--5. Doctors with specialize in Cardiology or Dermatology
SELECT *
FROM doctors
WHERE specialization= 'Cardiology' OR specialization= 'Dermatology'

-- OTHER SOLUTION
SELECT *
FROM doctors
WHERE specialization IN ('Cardiology','Dermatology');

--6. Doctors do not work in Neurology department
SELECT *
FROM doctors
WHERE specialization NOT IN ('Neurology');

-- OTHER SOLUTION
SELECT *
FROM doctors
WHERE specialization != 'Neurology';

--7. Find all patients who did not enter their phone number.
SELECT * 
FROM patients
WHERE phone_number is NULL;

--8. Display doctor name and salary, and create a new column called salary_status:
--If salary > 15000 → "High Salary"
--Otherwise → "Normal Salary"
SELECT first_name, middle_name, last_name , salary,
CASE
	WHEN salary> 15000 THEN 'High Salary'
	ELSE 'Normal Salary'
END AS salary_status
FROM doctors;

--9. Display all patients who have appointments with doctor_id = 1.
SELECT *
FROM patients AS p, doctor_treats_patient AS dtp
WHERE p.patient_id = dtp.patient_id AND dtp.doctor_id = 1;

--10. Create a new table called high_salary_doctors and insert doctors whose salary is greater than 15000.
CREATE TABLE high_salary_doctors (
    doctor_id INT PRIMARY KEY,
    first_name VARCHAR(30),
    middle_name VARCHAR(30),
    last_name VARCHAR(30),
    specialization VARCHAR(50),
    qualification VARCHAR(50),
    salary NUMERIC(10,2)
);

INSERT INTO high_salary_doctors (doctor_id, first_name, middle_name, last_name, specialization, qualification, salary)
SELECT doctor_id, first_name, middle_name, last_name, specialization, qualification, salary
FROM doctors
WHERE salary > 15000;

--11. Display the doctors who have at least one appointment with a patient in the system.
SELECT d.doctor_id
FROM doctors d
JOIN doctor_treats_patient dtp
  ON d.doctor_id = dtp.doctor_id
GROUP BY d.doctor_id
HAVING COUNT(dtp.patient_id) >= 1;

--12. Display doctors whose salary is greater than the salary of at least one doctor in the Cardiology department.
SELECT *
FROM doctors
WHERE salary > ANY (
    SELECT salary
    FROM doctors
    WHERE specialization = 'Cardiology'
);

--13. Display all doctors whose name starts with "A" or "M" using pattern matching.
SELECT *
FROM doctors
WHERE first_name SIMILAR TO 'A%|M%';

--14. Show a list of all unique doctor specializations.
SELECT DISTINCT specialization
FROM doctors;

--15. Display patient name and age (calculated from dob assuming today’s date).
SELECT patient_id,
       EXTRACT(YEAR FROM AGE(dob)) AS age
FROM patients;

--16. UPPER / LOWER / INITCAP
SELECT UPPER(first_name)
FROM doctors;

SELECT LOWER(first_name)
FROM doctors;

SELECT INITCAP(first_name || ' ' || last_name) AS doctor_name
FROM doctors;


--17.TRIM / LTRIM / RTRIM
UPDATE patients
SET phone_number = TRIM(phone_number);

--18. Display full doctor info combining name and phone as a single column called contact_info.
SELECT CONCAT(first_name, ' ', last_name) AS doctor_name
FROM doctors;

--19. Extract the first 3 letters of doctors names and find the position of letter "a" in the name.
SELECT 
    SUBSTR(first_name, 1, 3) AS first_three_letters,
    POSITION('a' IN first_name) AS position_of_a
FROM doctors;

--20 In doctor names, replace "Ahmed" with "Ahmad".
SELECT Replace(first_name,'Ahmed','Ahmad') as new_name
FROM doctors;

--21 Display doctor salary as integer and as text in separate columns.
SELECT salary::INT as int_salary , salary::Text as text_salary
FROM doctors;

