CREATE DATABASE BankingSystem;
SHOW DATABASES;
USE BankingSystem;
SELECT DATABASE();


-- task 2 --
USE BankingSystem;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15),
    City VARCHAR(50),
    CreatedDate DATETIME DEFAULT CURRENT_TIMESTAMP
);

DESCRIBE Customers;

CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    AccountType VARCHAR(20) NOT NULL,
    Balance DECIMAL(12,2) NOT NULL,
    CreatedDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

DESCRIBE Accounts;

CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY AUTO_INCREMENT,
    AccountID INT,
    TransactionType VARCHAR(20) NOT NULL,
    Amount DECIMAL(12,2) NOT NULL,
    TransactionDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);
DESCRIBE Transactions;

-- task 3 --
USE BankingSystem;
INSERT INTO Customers (FirstName, LastName, Email, Phone, City)
VALUES
('Rahul', 'Sharma', 'rahul.sharma@gmail.com', '9876543210', 'Delhi'),
('Priya', 'Mehta', 'priya.mehta@gmail.com', '8765432109', 'Mumbai'),
('Amit', 'Verma', 'amit.verma@gmail.com', '7654321098', 'Bangalore');

INSERT INTO Accounts (CustomerID, AccountType, Balance)
VALUES
(1, 'Savings', 15000.00),
(2, 'Current', 25000.00),
(3, 'Savings', 10000.00);

INSERT INTO Transactions (AccountID, TransactionType, Amount)
VALUES
(1, 'Deposit', 5000.00),
(2, 'Deposit', 10000.00),
(1, 'Withdrawal', 2000.00);

-- task 4 --
SELECT * FROM Customers;
SELECT * FROM Accounts;
SELECT * FROM Transactions;
