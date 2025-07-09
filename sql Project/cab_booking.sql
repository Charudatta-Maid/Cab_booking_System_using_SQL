-- Create Database
CREATE DATABASE cab_booking;
USE cab_booking;

-- Users Table start
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15)
);

-- Users Table end

-- Drivers Table start
CREATE TABLE drivers (
    driver_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    license_number VARCHAR(50),
    phone VARCHAR(15)
);
-- Drivers Table end


-- Vehicles Table start
CREATE TABLE vehicles (
    vehicle_id INT AUTO_INCREMENT PRIMARY KEY,
    driver_id INT,
    model VARCHAR(100),
    plate_number VARCHAR(20),
    FOREIGN KEY (driver_id) REFERENCES drivers(driver_id)
);
-- Vehicles Table end

-- Rides Table start
CREATE TABLE rides (
    ride_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    driver_id INT,
    pickup_location VARCHAR(255),
    drop_location VARCHAR(255),
    ride_date DATETIME,
    fare DECIMAL(10,2),
    status VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (driver_id) REFERENCES drivers(driver_id)
);
-- Rides Table end


-- Payments Table
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    ride_id INT,
    amount DECIMAL(10,2),
    method VARCHAR(50),
    payment_date DATETIME,
    FOREIGN KEY (ride_id) REFERENCES rides(ride_id)
);
-- Payments Table end


-- Sample Data Insert

-- Users
INSERT INTO users (name, email, phone) VALUES 
('Amit Sharma', 'amit@gmail.com', '9876543210'),
('Priya Mehta', 'priya@gmail.com', '9988776655');

-- Drivers
INSERT INTO drivers (name, license_number, phone) VALUES
('Ravi Kumar', 'DL12345', '9123456780'),
('Sunil Verma', 'DL67890', '9876501234');

-- Vehicles
INSERT INTO vehicles (driver_id, model, plate_number) VALUES
(1, 'WagonR', 'MH12AB1234'),
(2, 'Swift', 'MH14CD5678');

-- Rides
INSERT INTO rides (user_id, driver_id, pickup_location, drop_location, ride_date, fare, status) VALUES
(1, 1, 'Pune Station', 'Shivaji Nagar', NOW(), 150.00, 'Completed'),
(2, 2, 'Kothrud', 'Deccan', NOW(), 120.00, 'Ongoing');

-- Payments
INSERT INTO payments (ride_id, amount, method, payment_date) VALUES
(1, 150.00, 'UPI', NOW());

-- Sample Queries

-- Select all users
SELECT * FROM users;

-- Insert a new ride
INSERT INTO rides (user_id, driver_id, pickup_location, drop_location, ride_date, fare, status)
VALUES (1, 2, 'Viman Nagar', 'Hadapsar', NOW(), 200.00, 'Scheduled');

-- Update ride status
UPDATE rides SET status = 'Completed' WHERE ride_id = 2;

-- Delete a user
DELETE FROM users WHERE user_id = 2;

-- Join Query: Ride info with user & driver name
SELECT r.ride_id, u.name AS user_name, d.name AS driver_name, r.pickup_location, r.drop_location, r.fare
FROM rides r
JOIN users u ON r.user_id = u.user_id
JOIN drivers d ON r.driver_id = d.driver_id;

-- Group By: Earnings per driver
SELECT driver_id, COUNT(*) AS total_rides, SUM(fare) AS total_earnings
FROM rides
GROUP BY driver_id;
