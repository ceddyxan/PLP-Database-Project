-- CREATE DATABASE frauddetectiondb; 

USE frauddetectiondb;

-- Create Table Users
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Create Table Accounts
CREATE TABLE Accounts (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    account_number VARCHAR(20) UNIQUE NOT NULL,
    account_type ENUM('checking', 'savings', 'credit') NOT NULL,
    balance DECIMAL(15,2) DEFAULT 0.00,
    status ENUM('active', 'suspended', 'closed') DEFAULT 'active',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Create Table Merchants
CREATE TABLE Merchants (
    merchant_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    country VARCHAR(50),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Create Table Devices
CREATE TABLE Devices (
    device_id INT AUTO_INCREMENT PRIMARY KEY,
    device_type VARCHAR(50),
    os VARCHAR(50),
    ip_address VARCHAR(45),
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Create Table Locations
CREATE TABLE Locations (
    location_id INT AUTO_INCREMENT PRIMARY KEY,
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6),
    city VARCHAR(100),
    country VARCHAR(100)
);

-- Create Table Transactions
CREATE TABLE Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT NOT NULL,
    merchant_id INT,
    device_id INT,
    location_id INT,
    amount DECIMAL(15,2) NOT NULL,
    currency VARCHAR(10) DEFAULT 'USD',
    transaction_time DATETIME NOT NULL,
    status ENUM('pending', 'completed', 'failed') DEFAULT 'completed',
    is_fraud BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id),
    FOREIGN KEY (merchant_id) REFERENCES Merchants(merchant_id),
    FOREIGN KEY (device_id) REFERENCES Devices(device_id),
    FOREIGN KEY (location_id) REFERENCES Locations(location_id)
);

-- Create Table Alerts
CREATE TABLE Alerts (
    alert_id INT AUTO_INCREMENT PRIMARY KEY,
    transaction_id INT NOT NULL,
    alert_type VARCHAR(50),
    description TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    resolved BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (transaction_id) REFERENCES Transactions(transaction_id)
);

-- Create Table Fraud_Cases
CREATE TABLE Fraud_Cases (
    case_id INT AUTO_INCREMENT PRIMARY KEY,
    transaction_id INT NOT NULL,
    reported_by VARCHAR(100),
    report_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    resolution_status ENUM('open', 'investigating', 'resolved') DEFAULT 'open',
    notes TEXT,
    FOREIGN KEY (transaction_id) REFERENCES Transactions(transaction_id)
);

-- Create Table Transaction_Tags
CREATE TABLE Transaction_Tags (
    tag_id INT AUTO_INCREMENT PRIMARY KEY,
    tag_name VARCHAR(50) UNIQUE NOT NULL
);

-- Create Table Transaction_Tag_Map
CREATE TABLE Transaction_Tag_Map (
    transaction_id INT NOT NULL,
    tag_id INT NOT NULL,
    PRIMARY KEY (transaction_id, tag_id),
    FOREIGN KEY (transaction_id) REFERENCES Transactions(transaction_id),
    FOREIGN KEY (tag_id) REFERENCES Transaction_Tags(tag_id)
);

-- Sample Data for Users
INSERT INTO Users (name, email, phone) VALUES
('Alice Mwangi', 'alice@example.com', '+2547123456780'),
('Brian Otieno', 'brian@example.com', '+2547334567891'),
('James Wafula', 'waf@example.com', '+2547133472780'),
('Mary Wakesho', 'mary@example.com', '+2547394567892');
  
-- Sample Data for Accounts
INSERT INTO Accounts (user_id, account_number, account_type, balance, status) VALUES
(1, 'ACC1001', 'checking', 15000.00, 'active'),
(1, 'ACC1002', 'savings', 30000.00, 'active'),
(2, 'ACC2001', 'credit', 5000.00, 'active');
  
-- Sample Data for Merchants
INSERT INTO Merchants (name, category, country) VALUES
('Jumia Kenya', 'e-commerce', 'Kenya'),
('Naivas Supermarket', 'retail', 'Kenya'),
('Uber Nairobi', 'transport', 'Kenya');

-- Sample Data for Devices
INSERT INTO Devices (device_type, os, ip_address, user_id) VALUES
('Smartphone', 'Android', '192.168.1.10', 1),
('Laptop', 'Windows', '192.168.1.20', 2);
  
-- Sample Data for Locations
INSERT INTO Locations (latitude, longitude, city, country) VALUES
(-1.2921, 36.8219, 'Nairobi', 'Kenya'),
(-0.0236, 37.9062, 'Machakos', 'Kenya');
  
-- Sample Data for Transactions
INSERT INTO Transactions (account_id, merchant_id, device_id, location_id, amount, currency, transaction_time, status, is_fraud) VALUES
(1, 1, 1, 1, 2500.00, 'KES', '2025-05-09 10:15:00', 'completed', FALSE),
(2, 2, 2, 2, 150.00, 'KES', '2025-05-09 11:00:00', 'completed', FALSE),
(3, 3, 2, 1, 500.00, 'KES', '2025-05-09 12:30:00', 'completed', TRUE);

-- Sample Data for Alerts
INSERT INTO Alerts (transaction_id, alert_type, description, resolved) VALUES
(3, 'Suspicious Activity', 'Transaction flagged due to unusual location.', FALSE);

-- Sample Data for Fraud Cases
INSERT INTO Fraud_Cases (transaction_id, reported_by, resolution_status, notes) VALUES
(3, 'System', 'investigating', 'User reported unfamiliar transaction.');

-- Sample Data for Transaction Tags
INSERT INTO Transaction_Tags (tag_name) VALUES
('High Risk'),
('International'),
('Large Amount');

-- Sample Data for Transaction Tag Map
INSERT INTO Transaction_Tag_Map (transaction_id, tag_id) VALUES
(3, 1),
(3, 3);
