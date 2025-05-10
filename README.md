# PLP-Database-Project WEEK 8

# Fraud Detection Database

## Description

This project implements a relational database schema for a fraud detection system. It manages users, accounts, merchants, devices, locations, transactions, alerts, fraud cases, and transaction tags. The schema is designed to support the detection and investigation of fraudulent financial activities.

The schema is implemented in MySQL and includes sample data for testing and demonstration.

## Features

- **User Management:** Store user details and contact information.
- **Account Tracking:** Manage multiple account types and statuses.
- **Merchant & Device Logging:** Record merchant and device details involved in transactions.
- **Location Awareness:** Track transaction locations for anomaly detection.
- **Transaction Monitoring:** Store detailed transaction records, including fraud status.
- **Alert System:** Generate and resolve alerts for suspicious transactions.
- **Fraud Case Management:** Track reported fraud cases and their resolution status.
- **Tagging System:** Tag transactions with risk indicators for advanced analytics.

## Schema Overview

- **Users:** Stores Basic user information.
- **Accounts:** Stores accounts details linked to users.
- **Merchants:** Stores information of Businesses where transactions occur.
- **Devices:** Devices used to perform transactions.
- **Locations:** Geographic data for transactions.
- **Transactions:** Recordes All financial transactions.
- **Alerts:** Alerts generated for suspicious activities.
- **Fraud_Cases:** Management/Tracking of reported fraud incidents.
- **Transaction_Tags & Transaction_Tag_Map:** Tagging system for transactions.

## How to Run / Setup

1. **Create the Database:**
   Uncomment and run the following line in your SQL client if the database does not exist:
   ```sql
   -- CREATE DATABASE frauddetectiondb;
   
   Select the Database:
    USE frauddetectiondb;
2. **Run the Schema Script:**
   Execute the `FraudDetection.sql` file in your SQL client (e.g. MySQL Workbench, phpMyAdmin, or the MySQL command line).

   This will:
   
   - Create all necessary tables with relationships.
   - Insert sample data for testing and demonstration.

3. **Explore the Data:**
   Use SQL queries to analyze transactions, detect fraud, and review alerts and cases.

## Sample Data

The script includes sample users, accounts, merchants, devices, locations, transactions, alerts, fraud cases, and transaction tags to help you get started quickly.

## Entity Relationship Diagram (ERD)

![alt text](<Fraud ERD Chart.drawio.png>)

## Example Query

Find all transactions flagged as fraud:
```sql
SELECT t.transaction_id, u.name, t.amount, t.transaction_time
FROM Transactions t
JOIN Accounts a ON t.account_id = a.account_id
JOIN Users u ON a.user_id = u.user_id
WHERE t.is_fraud = TRUE;
```
## Requirements

- MySQL 5.7+ or compatible database system

## File Structure

- `FraudDetection.sql` — Main schema and sample data

## License

This project is for educational purposes.

---

**Author:** Cedrick Shikoli  
**Date:** May 2025