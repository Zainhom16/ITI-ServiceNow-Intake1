CREATE TABLE doctors (
  doctor_id SERIAL PRIMARY KEY,
  first_name VARCHAR(20) NOT NULL,
  middle_name VARCHAR(20),
  last_name VARCHAR(20) NOT NULL,
  specialization TEXT,
  qualification TEXT
);

CREATE TABLE patients (
  patient_id SERIAL PRIMARY KEY,
  first_name VARCHAR(20) NOT NULL,
  last_name VARCHAR(20) NOT NULL,
  dob DATE NOT NULL,
  locality TEXT,
  city VARCHAR(25),
  doctor_id INT,
  FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE medicines (
  code SERIAL PRIMARY KEY,
  medicine_name VARCHAR(50) NOT NULL,
  price NUMERIC(5,2) NOT NULL,
  quantity INT,
  CHECK (quantity >= 0)
);

CREATE TABLE patient_medicine (
  bill_id SERIAL PRIMARY KEY,
  patient_id INT NOT NULL,
  medicine_code INT NOT NULL,
  quantity INT,
  bill_date DATE NOT NULL,
  FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (medicine_code) REFERENCES medicines(code)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

INSERT INTO doctors (first_name, middle_name, last_name, specialization, qualification)
VALUES
('Hazem', 'Zainhom', 'Abdelalim', 'Cardiology', 'PhD'),
('Ahmed', 'Ali', 'Hassan', 'Dermatology', 'MD'),
('Sara', 'Mahmoud', 'Ibrahim', 'Neurology', 'MBBS');

INSERT INTO patients (first_name, last_name, dob, locality, city, doctor_id)
VALUES
('Omar', 'Hassan', '1995-04-12', 'Nasr City', 'Cairo', 1),
('Mona', 'Adel', '1998-09-21', 'Maadi', 'Cairo', 2),
('Khaled', 'Samir', '1992-01-30', 'Dokki', 'Giza', 1),
('Nour', 'Fathy', '2000-06-18', 'Smouha', 'Alexandria', 3),
('Youssef', 'Tarek', '1997-11-05', 'Mohandessin', 'Giza', 2);

INSERT INTO medicines (medicine_name, price, quantity)
VALUES
('Paracetamol', 10.50, 100),
('Amoxicillin', 25.75, 60),
('Ibuprofen', 15.30, 80),
('Aspirin', 8.40, 120),
('Cough Syrup', 35.00, 40);

INSERT INTO patient_medicine (patient_id, medicine_code, quantity, bill_date)
VALUES
(1, 1, 2, '2026-03-10'),
(2, 3, 1, '2026-03-10'),
(3, 2, 3, '2026-03-11'),
(4, 5, 1, '2026-03-11'),
(5, 4, 2, '2026-03-12');

UPDATE medicines
SET price = price * 1.5
WHERE code = 1;

UPDATE patients
SET doctor_id=1
WHERE patient_id=2;

ALTER TABLE doctors
ADD COLUMN phone_number VARCHAR(11);

ALTER TABLE patients
ADD COLUMN email VARCHAR(25) UNIQUE;

ALTER TABLE medicines
ADD CONSTRAINT price_positive CHECK (price > 0);

UPDATE doctors
SET doctor_id=5
WHERE doctor_id=3;

