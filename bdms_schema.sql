-- BDMS Database Schema Validated to 3NF
-- Run this script to generate the database structure and initial data.

CREATE DATABASE IF NOT EXISTS bdms_db;
USE bdms_db;

-- 1. users table
CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(15) NOT NULL UNIQUE,
    dob DATE NOT NULL,
    blood_type ENUM('A+','A-','B+','B-','AB+','AB-','O+','O-') NOT NULL,
    address VARCHAR(255) NOT NULL,
    location VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin','user') NOT NULL DEFAULT 'user',
    status ENUM('pending','approved','rejected') NOT NULL DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. donor_profiles table
CREATE TABLE IF NOT EXISTS donor_profiles (
    profile_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,
    is_available BOOLEAN NOT NULL DEFAULT TRUE,
    last_donation_date DATE DEFAULT NULL,
    total_donations INT NOT NULL DEFAULT 0,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- 3. blood_requests table
CREATE TABLE IF NOT EXISTS blood_requests (
    request_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    blood_type_needed ENUM('A+','A-','B+','B-','AB+','AB-','O+','O-') NOT NULL,
    units_required DECIMAL(4,1) NOT NULL,
    urgency_level ENUM('LOW','MEDIUM','HIGH','CRITICAL') NOT NULL,
    patient_name VARCHAR(100) NOT NULL,
    hospital_name VARCHAR(150) NOT NULL,
    reason TEXT,
    status ENUM('pending','approved','fulfilled','rejected','cancelled') NOT NULL DEFAULT 'pending',
    requested_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    resolved_at TIMESTAMP NULL DEFAULT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- 4. blood_inventory table
CREATE TABLE IF NOT EXISTS blood_inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    blood_type ENUM('A+','A-','B+','B-','AB+','AB-','O+','O-') NOT NULL UNIQUE,
    units_available DECIMAL(6,1) NOT NULL DEFAULT 0.0,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 5. wishlists table
CREATE TABLE IF NOT EXISTS wishlists (
    wishlist_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    request_id INT NOT NULL,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (request_id) REFERENCES blood_requests(request_id) ON DELETE CASCADE,
    UNIQUE KEY (user_id, request_id)
);

-- 6. contact_messages table
CREATE TABLE IF NOT EXISTS contact_messages (
    message_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    subject VARCHAR(200) NOT NULL,
    message TEXT NOT NULL,
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_read BOOLEAN NOT NULL DEFAULT FALSE
);

-- Initial Data Seed

-- Add fulfillment columns (issue/return dates)
ALTER TABLE blood_requests ADD COLUMN issue_date DATE NULL AFTER resolved_at;
ALTER TABLE blood_requests ADD COLUMN return_date DATE NULL AFTER issue_date;

-- Indexes for performance
ALTER TABLE blood_requests ADD INDEX idx_status_urgency (status, urgency_level);
ALTER TABLE blood_requests ADD INDEX idx_user_status (user_id, status);
ALTER TABLE users ADD INDEX idx_status_role (status, role);
INSERT IGNORE INTO blood_inventory (blood_type, units_available) VALUES 
('A+', 0.0), ('A-', 0.0), ('B+', 0.0), ('B-', 0.0),
('AB+', 0.0), ('AB-', 0.0), ('O+', 0.0), ('O-', 0.0);

-- Default Admin User (password is 'Admin@123' bcrypt hashed)
INSERT IGNORE INTO users (full_name, email, phone, dob, blood_type, address, location, password, role, status)
VALUES ('System Admin', 'admin@bdms.com', '9800000000', '1990-01-01', 'O+', 'Central HQ', 'Kathmandu', '$2a$12$/RcqlL/d3ywsu1O56hMpzOKm.RbdKDSTR0kk3z4uuTUI6qcyqS1Bq', 'admin', 'approved');
