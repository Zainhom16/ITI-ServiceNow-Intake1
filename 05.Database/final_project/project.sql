-- =====================================================
-- ============= 1. TABLES CREATION =====================
-- =====================================================

CREATE TABLE role (
    role_id SERIAL PRIMARY KEY,
    role_name VARCHAR(20) NOT NULL CHECK (role_name IN ('admin','customer'))
);

CREATE TABLE user_account (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    password VARCHAR(50) NOT NULL,
    role_id INT REFERENCES role(role_id) ON DELETE SET NULL
);

CREATE TABLE hotel (
    hotel_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    rating DECIMAL(2,1) CHECK (rating >= 0.0 AND rating <= 5.0),
    description TEXT
);

CREATE TABLE room (
    room_id SERIAL PRIMARY KEY,
    room_type VARCHAR(50),
    price DECIMAL(10,2) CHECK (price >= 0.0),
    availability BOOLEAN DEFAULT TRUE,
    hotel_id INT NOT NULL REFERENCES hotel(hotel_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE airline (
    airline_id SERIAL PRIMARY KEY,
    airline_name VARCHAR(100) NOT NULL
);

CREATE TABLE flight (
    flight_id SERIAL PRIMARY KEY,
    departure_city VARCHAR(100) NOT NULL,
    arrival_city VARCHAR(100) NOT NULL,
    departure_date DATE NOT NULL,
    arrival_date DATE NOT NULL,
    price DECIMAL(10,2) CHECK (price >= 0.0),
    available_seats INT CHECK (available_seats >= 0),
    airline_id INT REFERENCES airline(airline_id) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE reservation_room (
    reservation_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES user_account(user_id) ON DELETE CASCADE,
    room_id INT REFERENCES room(room_id) ON DELETE CASCADE,
    check_in DATE NOT NULL,
    check_out DATE NOT NULL,
    status VARCHAR(20) CHECK (status IN ('Pending','Confirmed','Cancelled')) DEFAULT 'pending'
);

CREATE TABLE booking_flight (
    booking_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES user_account(user_id) ON DELETE CASCADE,
    flight_id INT NOT NULL REFERENCES flight(flight_id) ON DELETE CASCADE,
    booking_date DATE,
    status VARCHAR(20) DEFAULT 'Pending' CHECK (status IN ('Pending','Confirmed','Cancelled'))
);

CREATE TABLE review (
    review_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES user_account(user_id) ON DELETE CASCADE,
    entity_id INT NOT NULL,
    type VARCHAR(10) CHECK (type IN ('hotel','flight')),
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT
);

CREATE TABLE payment (
    payment_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES user_account(user_id) ON DELETE CASCADE,
    entity_id INT NOT NULL,
    type VARCHAR(10) CHECK (type IN ('hotel','flight')),
    amount DECIMAL(10,2) NOT NULL CHECK (amount >= 0),
    payment_method VARCHAR(20) CHECK (payment_method IN ('Card','Cash')),
    payment_date DATE DEFAULT CURRENT_DATE
);

-- =====================================================
-- ============= 2. INSERTING DATA =====================
-- =====================================================

-- ROLES
INSERT INTO role (role_name) VALUES
('admin'),
('customer');

-- USERS
INSERT INTO user_account (name, email, phone, password, role_id) VALUES
('Ahmed Hassan', 'ahmed.hassan@example.com', '01012345678', 'pass123', 2),
('Mona Ali', 'mona.ali@example.com', '01198765432', 'pass456', 2),
('Omar Mostafa', 'omar.mostafa@example.com', '01234567890', 'pass789', 1);

-- HOTELS
INSERT INTO hotel (name, location, rating, description) VALUES
('Cairo Grand Hotel', 'Cairo', 4.5, 'Luxury hotel in downtown Cairo'),
('Alexandria Beach Resort', 'Alexandria', 4.0, 'Beachfront hotel with sea view'),
('Luxor Nile Hotel', 'Luxor', 4.2, 'Hotel near the Nile with excellent services');

-- ROOMS
INSERT INTO room (room_type, price, availability, hotel_id) VALUES
('Single', 1200.00, TRUE, 1),
('Double', 2000.00, TRUE, 1),
('Suite', 3500.00, TRUE, 2),
('Standard', 1500.00, TRUE, 3);

-- AIRLINES
INSERT INTO airline (airline_name) VALUES
('EgyptAir'),
('Nile Air'),
('Air Cairo');

-- FLIGHTS
INSERT INTO flight (departure_city, arrival_city, departure_date, arrival_date, price, available_seats, airline_id) VALUES
('Cairo', 'Alexandria', '2026-04-01', '2026-04-01', 1500.00, 50, 1),
('Cairo', 'Luxor', '2026-04-05', '2026-04-05', 2500.00, 30, 2),
('Alexandria', 'Cairo', '2026-04-10', '2026-04-10', 1400.00, 60, 3);

-- RESERVATIONS (Rooms)
INSERT INTO reservation_room (user_id, room_id, reservation_date, status) VALUES
(1, 1, '2026-04-01', 'Confirmed'),
(2, 3, '2026-04-05', 'Pending'),
(1, 2, '2026-04-10', 'Confirmed'),
(2, 1, '2026-04-12', 'Pending'),
(3, 2, '2026-04-15', 'Confirmed'),
(1, 3, '2026-04-18', 'Cancelled'),
(3, 4, '2026-04-20', 'Confirmed');

-- BOOKINGS (Flight)
INSERT INTO booking_flight (user_id, flight_id, booking_date, status) VALUES
(1, 1, '2026-03-20', 'Confirmed'),
(2, 3, '2026-03-22', 'Pending'),
(3, 1, '2026-03-23', 'Confirmed'),
(1, 1, '2026-03-24', 'Confirmed'),
(2, 1, '2026-03-25', 'Pending'),
(3, 1, '2026-03-26', 'Confirmed'),
(1, 1, '2026-03-27', 'Confirmed');

-- REVIEWS
INSERT INTO review (user_id, entity_id, type, rating, comment) VALUES
(1, 1, 'hotel', 5, 'Excellent stay, very comfortable!'),
(2, 3, 'flight', 4, 'Good flight, on time.');

-- PAYMENTS
INSERT INTO payment (user_id, entity_id, type, amount, payment_method, payment_date) VALUES
-- Hotel payments (entity_id = reservation_room_id)
(1, 1, 'hotel', 1200.00, 'card', '2026-03-25'),
(2, 2, 'hotel', 1400.00, 'cash', '2026-03-26'),

-- Flight payments (entity_id = booking_flight_id)
(1, 1, 'flight', 1500.00, 'card', '2026-03-27'),
(3, 3, 'flight', 2500.00, 'cash', '2026-03-28');


-- =====================================================
-- ============= 3. QUERIES =====================
-- =====================================================

-- 1. List all hotel bookings for each user
SELECT 
    u.name AS user_name,
    h.name AS hotel_name,
    rr.reservation_date
FROM user_account u
JOIN reservation_room rr USING (user_id)
JOIN room r USING (room_id)
JOIN hotel h USING (hotel_id);

-- 2. Total revenue from each user
SELECT u.name AS user_name,p.payment_method, sum(p.amount) AS user_spent
FROM user_account u
JOIN  payment p USING (user_id)
GROUP BY u.name, p.payment_method
ORDER BY user_spent DESC

-- 3. Hotels with average rating >= 3.5.
SELECT h.name AS hotel_name , rating
FROM hotel h
WHERE rating >= 3.5

-- 4. Users who have never made a booking for flights
WITH users_made_flights AS (
    SELECT DISTINCT u.name, u.user_id
    FROM user_account u
    JOIN booking_flight bf USING(user_id)
)

SELECT u.name, u.user_id
FROM user_account u
EXCEPT
SELECT name, user_id
FROM users_made_flights;

-- 5. Top 3 most booked hotels (by number of reservations).
SELECT *
FROM (
    SELECT 
        h.name,
        COUNT(*) AS total_reservations,
        DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS rank
    FROM hotel h
    JOIN room r USING (hotel_id)
    JOIN reservation_room rr USING (room_id)
    GROUP BY h.hotel_id, h.name
) t
WHERE rank <= 3;

-- 6. Upcoming flights in the next 3 weeks and listing users who booked them.
SELECT 
    u.name AS user_name,
    f.departure_city,
    f.arrival_city,
    f.departure_date
FROM user_account u
JOIN booking_flight bf USING (user_id)
JOIN flight f USING (flight_id)
WHERE f.departure_date BETWEEN CURRENT_DATE AND CURRENT_DATE + 21;

-- 7. Users who booked both a hotel and a flight for the same trip (same date range)
SELECT 
    u.name,
    h.name AS hotel_name,
    f.departure_city,
    f.arrival_city
FROM user_account u
JOIN reservation_room rr USING (user_id)
JOIN room r USING (room_id)
JOIN hotel h USING (hotel_id)
JOIN booking_flight bf USING (user_id)
JOIN flight f USING (flight_id)
WHERE rr.reservation_date = f.departure_date;

-- 8. Top 3 busiest routes
SELECT departure_city, arrival_city, COUNT(*) AS total_bookings
FROM flight f
JOIN booking_flight bf USING (flight_id)
GROUP BY departure_city, arrival_city
ORDER BY total_bookings DESC
LIMIT 3;

-- 9. Available rooms in a hotel today
SELECT
    r.room_id,
    r.room_type,
    h.name
FROM room r
JOIN hotel h USING (hotel_id)
WHERE r.room_id NOT IN (
    SELECT room_id
    FROM reservation_room
    WHERE reservation_date = CURRENT_DATE
);

-- 10. Airline has the highest number of bookings?
SELECT 
    airline_name, 
    COUNT(*) AS number_of_booking
FROM airline 
JOIN flight USING (airline_id)
JOIN booking_flight USING (flight_id)
GROUP BY airline_name
ORDER BY number_of_booking DESC
LIMIT 1;

-- 11. Hotel Name Contains Cairo
SELECT 
    name,
    location,
    rating,
    CASE 
        WHEN rating >= 4.5 THEN 'Excellent'
        WHEN rating >= 3 THEN 'Good'
        ELSE 'Poor'
    END AS rating_category
FROM hotel
WHERE name ILIKE '%cairo%';

-- 12. Hotels in Cairo + Room Prices
SELECT 
    h.name AS hotel_name,
    r.room_type,
    r.price,
    CASE 
        WHEN r.price > 3000 THEN 'Luxury'
        WHEN r.price >= 1500 THEN 'Standard'
        ELSE 'Budget'
    END AS room_class
FROM hotel h
JOIN room r USING (hotel_id)
WHERE h.location ILIKE '%cairo%';