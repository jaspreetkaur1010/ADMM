CREATE DATABASE demo;

USE demo;
SELECT DATABASE();
SHOW DATABASES;
SHOW TABLES;
DROP DATABASE demo;
DROP DATABASE IF EXISTS ecommerce;
CREATE DATABASE ecommerce;
USE ecommerce;
CREATE TABLE customers (
  customer_id INT PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(20) NOT NULL,
  middle_name VARCHAR(20) NULL,
  last_name VARCHAR(20) NOT NULL,
  email VARCHAR(50) NOT NULL,
  address VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

SHOW TABLES;
DESC customers;
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  order_id INT PRIMARY KEY AUTO_INCREMENT,
  customer_id INT NOT NULL,
  order_date DATE NOT NULL,
  delivery_date DATE NOT NULL,
  total_amount FLOAT(5,2),
  status VARCHAR(10) DEFAULT 'Pending',
  Foreign Key (customer_id) REFERENCES customers(customer_id)
);
DROP TABLE ORDERS;
DESC orders;
SHOW TABLES;
INSERT INTO customers (first_name, middle_name, last_name, email, address)
VALUES ('John', 'Michael', 'Doe', 'john.doe@example.com', '123 Main St, New York, NY');
SELECT * FROM customers;

INSERT INTO customers (first_name, middle_name, last_name, email, address) VALUES
('Jane', NULL, 'Smith', 'jane.smith@example.com', '456 Oak Ave, Los Angeles, CA'),
('Robert', 'Andrew', 'Brown', 'robert.brown@example.com', '789 Pine Rd, Chicago, IL'),
('Emily', 'Grace', 'Johnson', 'emily.johnson@example.com', NULL),
('David', NULL, 'Wilson', 'david.wilson@example.com', '654 Cedar Ln, Phoenix, AZ');
SELECT * FROM ecommerce.customers;

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  order_id INT PRIMARY KEY AUTO_INCREMENT,
  customer_id INT NOT NULL,
  order_date DATE NOT NULL,
  delivery_date DATE NOT NULL,
  total_amount FLOAT(5,2),
  status VARCHAR(10) DEFAULT 'Pending',
  Foreign Key (customer_id) REFERENCES customers(customer_id)
);
INSERT INTO orders (customer_id, order_date, delivery_date, total_amount, status)
VALUES
(1, '2026-02-01', '2026-02-04', 120.50, 'Completed'),
(2, '2026-02-02', '2026-02-06', 75.99, 'Pending'),
(3, '2026-02-03', '2026-02-07', 250.00, 'Shipped'),
(1, '2026-02-04', '2026-02-08', 45.75, 'Cancelled'),
(4, '2026-02-05', '2026-02-09', 310.20, 'Completed'),
(5, '2026-02-06', '2026-02-10', 89.49, DEFAULT),
(2, '2026-02-07', '2026-02-13', 150.00, 'Shipped');
SELECT * FROM orders;
DELETE FROM orders
WHERE order_id = 7;
DELETE FROM orders
WHERE status = 'Cancelled';
SELECT * FROM orders;
DELETE FROM orders
WHERE order_date >= '2026-02-06';
SELECT * FROM customers WHERE customer_id = 1;

UPDATE customers
SET email = 'john.doe@gmail.com.com',
    address = '999 Updated St, Miami, FL'
WHERE customer_id = 1;


SELECT * FROM customers;

UPDATE customers
SET address = 'Address Not Provided'
WHERE address IS NULL;

Drop Table if exists users;
CREATE TABLE users(
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  middle_name VARCHAR(50) NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(50) NOT NULL,
  age TINYINT UNSIGNED NOT NULL
);

desc users;
INSERT INTO users(first_name, middle_name, last_name, email, age) VALUES
('John', 'Michael', 'Smith', 'johnsmith@gmail.com', 25),
('Jane', 'Elizabeth', 'Doe', 'janedoe@Gmail.com', 28),
('Xavier', NULL, 'Wills', 'xavier@wills.io', 35),
('Bev', NULL, 'Scott', 'bev@bevscott.com', 16),
('Bree', 'Marie', 'Jensen', 'bjensen@corp.net', 42),
('John', 'Robert', 'Jacobs', 'jjacobs@corp.net', 56),
('Rick', NULL, 'Fullman', 'fullman@hotmail.com', 16);
SELECT * FROM users;
SELECT first_name, last_name, email FROM users;
SELECT * FROM users
WHERE first_name = 'John';


SELECT * FROM users
WHERE id = 1;

SELECT * FROM users ORDER BY age;
SELECT * FROM users ORDER BY age DESC;
SELECT * FROM users LIMIT 3;

SELECT first_name, age 
FROM users
WHERE age > 28
ORDER BY age DESC
LIMIT 10;

UPDATE users
SET age = 18
WHERE first_name = 'Bev';


SELECT * FROm users;

DELETE FROM users
WHERE age < 18;


SELECT * FROm users;