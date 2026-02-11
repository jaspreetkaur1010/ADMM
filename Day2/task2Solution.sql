-- TASK 1: Create Database --

CREATE DATABASE FoodDelivery;

USE FoodDelivery;

-- TASK 2: Create Tables --

-- Customers Table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE,
    city VARCHAR(50) NOT NULL,
    signup_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Restaurants Table
CREATE TABLE Restaurants (
    restaurant_id INT PRIMARY KEY,
    restaurant_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    rating DECIMAL(2,1),
    CHECK (rating BETWEEN 0 AND 5)
);

-- Menu Table
CREATE TABLE Menu (
    item_id INT PRIMARY KEY,
    restaurant_id INT,
    item_name VARCHAR(100) NOT NULL,
    price DECIMAL(8,2),
    is_available BOOLEAN DEFAULT TRUE,
    CHECK (price > 0),
    FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id)
);

-- Orders Table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    restaurant_id INT,
    order_date DATETIME NOT NULL,
    total_amount DECIMAL(10,2),
    status VARCHAR(20),
    CHECK (total_amount >= 0),
    CHECK (status IN ('Pending','Delivered','Cancelled')),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id)
);

-- Order_Items Table
CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    item_id INT,
    quantity INT,
    CHECK (quantity > 0),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (item_id) REFERENCES Menu(item_id)
);

-- TASK 3: Insert Sample Data --

INSERT INTO Customers VALUES
(1, 'Aarav Sharma', 'aarav@gmail.com', '9876543210', 'Mumbai', '2025-01-05 10:15:00'),
(2, 'Priya Mehta', 'priya@gmail.com', '9876543211', 'Delhi', '2025-01-10 12:30:00'),
(3, 'Rohan Verma', 'rohan@gmail.com', '9876543212', 'Bangalore', '2025-02-01 09:20:00'),
(4, 'Sneha Iyer', 'sneha@gmail.com', '9876543213', 'Chennai', '2025-02-15 14:45:00'),
(5, 'Kabir Khan', 'kabir@gmail.com', '9876543214', 'Mumbai', '2025-03-01 16:10:00'),
(6, 'Ananya Patel', 'ananya@gmail.com', '9876543215', 'Pune', '2025-03-10 11:25:00');

INSERT INTO Restaurants VALUES
(1, 'Spice Hub', 'Mumbai', 4.3),
(2, 'Pizza Palace', 'Delhi', 4.5),
(3, 'Burger Town', 'Bangalore', 4.1),
(4, 'Healthy Bites', 'Pune', 4.7);

INSERT INTO Menu VALUES
(1, 1, 'Paneer Butter Masala', 250.00, TRUE),
(2, 1, 'Chicken Biryani', 300.00, TRUE),
(3, 1, 'Butter Naan', 40.00, TRUE),
(4, 2, 'Margherita Pizza', 350.00, TRUE),
(5, 2, 'Farmhouse Pizza', 450.00, TRUE),
(6, 2, 'Garlic Bread', 150.00, TRUE),
(7, 3, 'Veg Burger', 120.00, TRUE),
(8, 3, 'Chicken Burger', 180.00, TRUE),
(9, 3, 'French Fries', 90.00, TRUE),
(10, 4, 'Quinoa Salad', 220.00, TRUE),
(11, 4, 'Grilled Chicken', 320.00, TRUE),
(12, 4, 'Smoothie Bowl', 180.00, TRUE);

INSERT INTO Orders VALUES
(1, 1, 1, '2025-03-15 13:10:00', 340.00, 'Delivered'),
(2, 2, 2, '2025-03-16 18:20:00', 500.00, 'Delivered'),
(3, 1, 3, '2025-03-18 20:00:00', 210.00, 'Delivered'),
(4, 3, 1, '2025-03-20 14:30:00', 300.00, 'Pending'),
(5, 4, 2, '2025-03-22 19:45:00', 450.00, 'Delivered'),
(6, 2, 3, '2025-03-25 21:15:00', 180.00, 'Cancelled'),
(7, 5, 1, '2025-04-01 12:00:00', 290.00, 'Delivered'),
(8, 1, 2, '2025-04-03 17:40:00', 350.00, 'Pending');

INSERT INTO Order_Items VALUES
(1, 1, 1, 1),
(2, 1, 3, 2),
(3, 2, 4, 1),
(4, 2, 6, 1),
(5, 3, 7, 1),
(6, 3, 9, 1),
(7, 4, 2, 1),
(8, 5, 5, 1),
(9, 6, 8, 1),
(10, 7, 1, 1),
(11, 7, 3, 1),
(12, 8, 4, 1),
(13, 8, 6, 1),
(14, 8, 6, 1),
(15, 8, 5, 1);

-- TASK 4: Aggregation Queries --

-- Total revenue generated
SELECT SUM(total_amount) AS Total_Revenue FROM Orders;

-- Average order value
SELECT AVG(total_amount) AS Avg_Order_Value FROM Orders;

-- Highest and lowest priced menu item
SELECT MAX(price) AS Highest_Price, MIN(price) AS Lowest_Price FROM Menu;

-- Number of orders grouped by status
SELECT status, COUNT(*) AS Total_Orders
FROM Orders
GROUP BY status;

-- TASK 5: Join Queries --

-- INNER JOIN: Customer Name, Restaurant Name, Order Date, Total Amount
SELECT c.name, r.restaurant_name, o.order_date, o.total_amount
FROM Orders o
INNER JOIN Customers c ON o.customer_id = c.customer_id
INNER JOIN Restaurants r ON o.restaurant_id = r.restaurant_id;

-- LEFT JOIN: All restaurants and their orders
SELECT r.restaurant_name, o.order_id, o.total_amount
FROM Restaurants r
LEFT JOIN Orders o
ON r.restaurant_id = o.restaurant_id;

-- RIGHT JOIN: All customers and their orders
SELECT c.name, o.order_id, o.total_amount
FROM Orders o
RIGHT JOIN Customers c
ON o.customer_id = c.customer_id;

-- Count number of orders per restaurant
SELECT r.restaurant_name, COUNT(o.order_id) AS Total_Orders
FROM Restaurants r
LEFT JOIN Orders o
ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_name;

-- Total sales per restaurant
SELECT r.restaurant_name, SUM(o.total_amount) AS Total_Sales
FROM Restaurants r
JOIN Orders o
ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_name;

-- TASK 6: Subqueries --

-- Customers who have ordered from 'Spice Hub'
SELECT name
FROM Customers
WHERE customer_id IN (
    SELECT customer_id FROM Orders
    WHERE restaurant_id = (
        SELECT restaurant_id FROM Restaurants
        WHERE restaurant_name = 'Spice Hub'
    )
);

-- Restaurants that never received an order
SELECT restaurant_name
FROM Restaurants
WHERE restaurant_id NOT IN (
    SELECT DISTINCT restaurant_id FROM Orders
);

-- Customers whose total spending is above average
SELECT name
FROM Customers
WHERE customer_id IN (
    SELECT customer_id
    FROM Orders
    GROUP BY customer_id
    HAVING SUM(total_amount) >
        (SELECT AVG(total_amount) FROM Orders)
);

-- TASK 7: UNION and UNION ALL --

-- Unique cities where customers or restaurants are located
SELECT city FROM Customers
UNION
SELECT city FROM Restaurants;

-- Cities including duplicates
SELECT city FROM Customers
UNION ALL
SELECT city FROM Restaurants;

-- Create Archived Customers Table
CREATE TABLE Archived_Customers AS
SELECT * FROM Customers WHERE 1=0;

INSERT INTO Archived_Customers VALUES
(7, 'Old User1', 'old1@gmail.com', '9999999991', 'Goa', NOW()),
(8, 'Old User2', 'old2@gmail.com', '9999999992', 'Jaipur', NOW());

-- UNION of active and archived customers
SELECT name, city FROM Customers
UNION
SELECT name, city FROM Archived_Customers;

-- UNION ALL of active and archived customers
SELECT name, city FROM Customers
UNION ALL
SELECT name, city FROM Archived_Customers;

-- TASK 8: DateTime Functions --

-- Orders placed in the last 7 days
SELECT *
FROM Orders
WHERE order_date >= NOW() - INTERVAL 7 DAY;

-- Total revenue for March 2025
SELECT SUM(total_amount) AS March_Revenue
FROM Orders
WHERE MONTH(order_date) = 3
AND YEAR(order_date) = 2025;

-- Extract year and month from order_date
SELECT order_id,
YEAR(order_date) AS Order_Year,
MONTH(order_date) AS Order_Month
FROM Orders;

-- Number of days since each customer signed up
SELECT name,
DATEDIFF(CURRENT_DATE(), signup_date) AS Days_Since_Signup
FROM Customers;

-- Group orders by month and count them
SELECT YEAR(order_date) AS Year,
MONTH(order_date) AS Month,
COUNT(*) AS Total_Orders
FROM Orders
GROUP BY YEAR(order_date), MONTH(order_date);