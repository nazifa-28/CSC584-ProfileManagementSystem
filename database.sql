-- ============================================================
-- CSC584 Assignment 2 – Database Script
-- Student : Nur Nazifa Humairah Binti Yusaidi
-- Student ID: 2025428096
-- Database : StudentProfilesDB
-- ============================================================

-- Step 1: Create the database
CREATE DATABASE IF NOT EXISTS StudentProfilesDB
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

-- Step 2: Select the database
USE StudentProfilesDB;

-- Step 3: Drop table if it already exists (clean slate)
DROP TABLE IF EXISTS Profile;

-- Step 4: Create the Profile table
CREATE TABLE Profile (
    studentID    VARCHAR(20)  NOT NULL,
    name         VARCHAR(100) NOT NULL,
    programme    VARCHAR(100) NOT NULL,
    email        VARCHAR(100) NOT NULL,
    hobbies      VARCHAR(255),
    introduction VARCHAR(500),
    PRIMARY KEY (studentID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Step 5: Insert sample data
INSERT INTO Profile (studentID, name, programme, email, hobbies, introduction) VALUES
('2025428096', 'Nur Nazifa Humairah Binti Yusaidi', 'CS584 – Bachelor of Computer Science',
 'nazifa@student.uitm.edu.my', 'Reading, Coding, Photography',
 'Hi! I am Nazifa, a Computer Science student passionate about web development and UI design.'),

('2025111001', 'Ahmad Farhan Bin Zulkifli', 'CS584 – Bachelor of Computer Science',
 'farhan@student.uitm.edu.my', 'Gaming, Football, Music',
 'I am Farhan, interested in software engineering and mobile app development.'),

('2025222002', 'Siti Aisyah Binti Ramli', 'IS564 – Bachelor of Information Systems',
 'aisyah@student.uitm.edu.my', 'Dancing, Cooking, Travelling',
 'Aisyah here! I love working with data and building smart systems.');

-- Step 6: Verify the data
SELECT * FROM Profile;
