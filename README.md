# E-Commerce-Database-SQL-Project
I designed an E-commerce database using SQL with multiple related tables for customers, products, orders, and payments. I used joins, aggregate functions, and subqueries to analyze sales performance, customer behavior, and product demand.
Purpose:
To manage customers, products, orders, and payments, and to analyze sales data for business decisions.

2️⃣ Database Design (Tables)
Tables:
customers
products
orders
order_items
payments

3️⃣ Create Database & Tables
CREATE DATABASE ecommerce_db;
USE ecommerce_db;

-- Customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    email VARCHAR(50),
    city VARCHAR(30),
    register_date DATE
);

-- Products table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(30),
    price DECIMAL(8,2),
    stock INT
);

-- Orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Order items table
CREATE TABLE order_items (
    item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Payments table
CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_date DATE,
    payment_method VARCHAR(20),
    amount DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

4️⃣ Insert Sample Data
INSERT INTO customers VALUES
(1, 'Amit Kumar', 'amit@gmail.com', 'Pune', '2024-01-05'),
(2, 'Neha Sharma', 'neha@gmail.com', 'Mumbai', '2024-02-10');

INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 55000, 10),
(102, 'Mobile Phone', 'Electronics', 25000, 15),
(103, 'Headphones', 'Accessories', 3000, 25);

INSERT INTO orders VALUES
(1001, 1, '2024-03-01', 'Delivered'),
(1002, 2, '2024-03-03', 'Shipped');

INSERT INTO order_items VALUES
(1, 1001, 101, 1),
(2, 1001, 103, 2),
(3, 1002, 102, 1);

INSERT INTO payments VALUES
(1, 1001, '2024-03-02', 'Credit Card', 61000),
(2, 1002, '2024-03-04', 'UPI', 25000);

5️⃣ Basic SQL Queries
🔹 View all customers
SELECT * FROM customers;

🔹 Products in Electronics category
SELECT product_name, price
FROM products
WHERE category = 'Electronics';

6️⃣ JOIN Queries (Very Important)
🔹 Order details with customer name
SELECT o.order_id, c.customer_name, o.order_date, o.order_status
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

🔹 Products ordered by each customer
SELECT c.customer_name, p.product_name, oi.quantity
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON oi.product_id = p.product_id;

7️⃣ Analytical Queries (For Data Analyst Role)
🔹 Total sales amount
SELECT SUM(amount) AS total_sales
FROM payments;

🔹 Sales by product
SELECT p.product_name, SUM(oi.quantity * p.price) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name;

🔹 Top selling products
SELECT p.product_name, SUM(oi.quantity) AS total_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC;

8️⃣ Advanced Queries
🔹 Customers who placed more than 1 order
SELECT c.customer_name, COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name
HAVING COUNT(o.order_id) > 1;

🔹 Pending / non-delivered orders
SELECT order_id, order_status
FROM orders
WHERE order_status <> 'Delivered';
