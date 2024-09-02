CREATE SCHEMA pizza_runner;
use pizza_runner;

-- Drop the table if it exists
DROP TABLE IF EXISTS runners;

-- Create the table with additional columns
CREATE TABLE runners (
  runner_id INT AUTO_INCREMENT PRIMARY KEY,
  registration_date DATE NOT NULL,
  email VARCHAR(255) NOT NULL,
  phone_number VARCHAR(20),
  status ENUM('active', 'inactive') DEFAULT 'active'
);

-- Insert sample data
INSERT INTO runners (registration_date, email, phone_number, status)
VALUES
  ('2021-01-01', 'runner1@example.com', '9876543210', 'active'),
  ('2021-01-03', 'runner2@example.com', '9876543211', 'active'),
  ('2021-01-08', 'runner3@example.com', '9876543212', 'inactive'),
  ('2021-01-15', 'runner4@example.com', '9876543213', 'active'),
  ('2021-01-20', 'runner5@example.com', '9876543214', 'active'),
  ('2021-02-01', 'runner6@example.com', '9876543215', 'inactive'),
  ('2021-02-10', 'runner7@example.com', '9876543216', 'active'),
  ('2021-03-01', 'runner8@example.com', '9876543217', 'active'),
  ('2021-03-15', 'runner9@example.com', '9876543218', 'inactive'),
  ('2021-04-01', 'runner10@example.com', '9876543219', 'active');

select * from runners;

-- Drop the table if it exists
DROP TABLE IF EXISTS customers;

-- Create the table with relevant columns
CREATE TABLE customers (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  phone_number VARCHAR(20),
  address VARCHAR(255),
  city VARCHAR(100),
  state VARCHAR(100),
  postal_code VARCHAR(20),
  registration_date DATE NOT NULL,
  status ENUM('active', 'inactive') DEFAULT 'active'
);

-- Insert sample data
INSERT INTO customers (first_name, last_name, email, phone_number, address, city, state, postal_code, registration_date, status)
VALUES
  ('Amit', 'Sharma', 'amit.sharma@example.com', '9876543210', '123 MG Road', 'Mumbai', 'Maharashtra', '400001', '2021-01-01', 'active'),
  ('Priya', 'Patel', 'priya.patel@example.com', '9876543211', '456 Brigade Road', 'Bengaluru', 'Karnataka', '560001', '2021-01-03', 'active'),
  ('Raj', 'Kumar', 'raj.kumar@example.com', '9876543212', '789 Park Avenue', 'Delhi', 'Delhi', '110001', '2021-01-08', 'inactive'),
  ('Neha', 'Gupta', 'neha.gupta@example.com', '9876543213', '321 Connaught Place', 'New Delhi', 'Delhi', '110002', '2021-01-15', 'active'),
  ('Vikram', 'Singh', 'vikram.singh@example.com', '9876543214', '654 Janpath', 'Kolkata', 'West Bengal', '700001', '2021-01-20', 'active'),
  ('Anjali', 'Rao', 'anjali.rao@example.com', '9876543215', '987 Salt Lake', 'Kolkata', 'West Bengal', '700002', '2021-02-01', 'inactive'),
  ('Ravi', 'Joshi', 'ravi.joshi@example.com', '9876543216', '123 MG Road', 'Hyderabad', 'Telangana', '500001', '2021-02-10', 'active'),
  ('Kavita', 'Mehta', 'kavita.mehta@example.com', '9876543217', '456 Banjara Hills', 'Hyderabad', 'Telangana', '500002', '2021-03-01', 'active'),
  ('Sunil', 'Bansal', 'sunil.bansal@example.com', '9876543218', '789 Gachibowli', 'Hyderabad', 'Telangana', '500003', '2021-03-15', 'inactive'),
  ('Sita', 'Nair', 'sita.nair@example.com', '9876543219', '321 Hitech City', 'Hyderabad', 'Telangana', '500004', '2021-04-01', 'active');
  
  -- Drop existing tables if they exist
DROP TABLE IF EXISTS pizza_names;
DROP TABLE IF EXISTS pizza_recipes;
DROP TABLE IF EXISTS pizza_toppings;

-- Create the pizza_names table with additional columns
CREATE TABLE pizza_names (
  pizza_id INT AUTO_INCREMENT PRIMARY KEY,
  pizza_name VARCHAR(100) NOT NULL,
  price DECIMAL(10, 2) NOT NULL,   -- Price in Indian Rupees
  size VARCHAR(10) NOT NULL       -- Size of the pizza
);

-- Insert data into pizza_names with prices in INR
INSERT INTO pizza_names (pizza_name, price, size)
VALUES
  ('Meatlovers', 1599.00, 'Large'),   -- Price in INR
  ('Vegetarian', 1299.00, 'Medium'),
  ('Pepperoni Deluxe', 1649.00, 'Large'),
  ('Margherita', 1199.00, 'Small'),
  ('BBQ Chicken', 1499.00, 'Medium');

-- Create the pizza_toppings table with additional columns
CREATE TABLE pizza_toppings (
  topping_id INT AUTO_INCREMENT PRIMARY KEY,
  topping_name VARCHAR(100) NOT NULL,
  is_vegetarian BOOLEAN NOT NULL   -- Indicates if topping is vegetarian
);

-- Insert data into pizza_toppings
INSERT INTO pizza_toppings (topping_name, is_vegetarian)
VALUES
  ('Bacon', FALSE),
  ('BBQ Sauce', TRUE),
  ('Beef', FALSE),
  ('Cheese', TRUE),
  ('Chicken', FALSE),
  ('Mushrooms', TRUE),
  ('Onions', TRUE),
  ('Pepperoni', FALSE),
  ('Peppers', TRUE),
  ('Salami', FALSE),
  ('Tomatoes', TRUE),
  ('Tomato Sauce', TRUE);

-- Create the pizza_recipes table with foreign key constraints
CREATE TABLE pizza_recipes (
  pizza_id INT,
  topping_id INT,
  amount DECIMAL(5, 2) NOT NULL, -- Amount of topping in grams or other unit
  FOREIGN KEY (pizza_id) REFERENCES pizza_names(pizza_id) ON DELETE CASCADE,
  FOREIGN KEY (topping_id) REFERENCES pizza_toppings(topping_id) ON DELETE CASCADE,
  PRIMARY KEY (pizza_id, topping_id)
);

-- Insert data into pizza_recipes
INSERT INTO pizza_recipes (pizza_id, topping_id, amount)
VALUES
  (1, 1, 20.00),   -- Bacon for Meatlovers
  (1, 2, 10.00),   -- BBQ Sauce for Meatlovers
  (1, 3, 15.00),   -- Beef for Meatlovers
  (1, 4, 25.00),   -- Cheese for Meatlovers
  (1, 5, 20.00),   -- Chicken for Meatlovers
  (1, 6, 15.00),   -- Mushrooms for Meatlovers
  (1, 8, 20.00),   -- Pepperoni for Meatlovers
  (1, 10, 15.00),  -- Salami for Meatlovers
  (2, 4, 15.00),   -- Cheese for Vegetarian
  (2, 6, 10.00),   -- Mushrooms for Vegetarian
  (2, 7, 8.00),    -- Onions for Vegetarian
  (2, 9, 10.00),   -- Peppers for Vegetarian
  (2, 11, 12.00),  -- Tomatoes for Vegetarian
  (2, 12, 5.00),   -- Tomato Sauce for Vegetarian
  (3, 4, 25.00),   -- Cheese for Pepperoni Deluxe
  (3, 8, 30.00),   -- Pepperoni for Pepperoni Deluxe
  (3, 10, 20.00),  -- Salami for Pepperoni Deluxe
  (4, 4, 15.00),   -- Cheese for Margherita
  (4, 11, 12.00),  -- Tomatoes for Margherita
  (5, 5, 20.00),   -- Chicken for BBQ Chicken
  (5, 12, 8.00);   -- Tomato Sauce for BBQ Chicken

-- Drop existing tables if they exist
DROP TABLE IF EXISTS customer_orders;
DROP TABLE IF EXISTS runner_orders;

-- Create the customer_orders table with additional columns and foreign key constraints
CREATE TABLE customer_orders (
  order_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  pizza_id INT NOT NULL,
  exclusions TEXT,
  extras TEXT,
  order_time TIMESTAMP NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE,
  FOREIGN KEY (pizza_id) REFERENCES pizza_names(pizza_id) ON DELETE CASCADE
);
select * from customer_orders;
-- Insert data into customer_orders with additional rows
INSERT INTO customer_orders (customer_id, pizza_id, exclusions, extras, order_time)
VALUES
  (1, 1, '', '', '2020-01-01 18:05:02'),
  (2, 1, '', '', '2020-01-01 19:00:52'),
  (3, 1, '', '', '2020-01-02 23:51:23'),
  (4, 2, '', 'Extra Cheese', '2020-01-02 23:51:23'),
  (5, 1, 'Cheese', '', '2020-01-04 13:23:46'),
  (6, 1, 'Cheese', '', '2020-01-04 13:23:46'),
  (7, 2, 'Cheese', '', '2020-01-04 13:23:46'),
  (8, 1, 'Olives', 'Extra Chicken', '2020-01-08 21:00:29'),
  (10, 2, 'None', 'Extra Cheese', '2020-01-08 21:03:13'),
  (5, 2, 'None', 'Extra Olives', '2020-01-08 21:20:29'),
  (2, 1, 'None', 'Extra Cheese', '2020-01-09 23:54:33'),
  (3, 1, 'Cheese, Olives', 'Extra Pepperoni', '2020-01-10 11:22:59'),
  (4, 1, 'None', 'Extra Olives', '2020-01-11 18:34:49'),
  (9, 1, 'Mushrooms, Peppers', 'Extra Cheese', '2020-01-11 18:34:49'),
  (6, 3, 'Onions', '', '2020-01-12 20:22:15'),
  (7, 2, 'None', 'Extra Garlic', '2020-01-13 22:34:00');

-- Create the runner_orders table with additional columns and foreign key constraints
CREATE TABLE runner_orders (
  order_id INT,
  runner_id INT,
  pickup_time TIMESTAMP,
  distance VARCHAR(10),
  duration VARCHAR(10),
  cancellation VARCHAR(50),
  FOREIGN KEY (order_id) REFERENCES customer_orders(order_id) ON DELETE CASCADE,
  FOREIGN KEY (runner_id) REFERENCES runners(runner_id) ON DELETE CASCADE
);
select * from runner_orders;
-- Insert data into runner_orders with additional rows
-- Ensure order_id values in runner_orders exist in customer_orders
-- Update runner_orders with valid order_id values

INSERT INTO runner_orders (order_id, runner_id, pickup_time, distance, duration, cancellation) VALUES
  (1, 1, '2020-01-01 18:15:34', '20 km', '32 minutes', ''),
  (2, 1, '2020-01-01 19:10:54', '20 km', '27 minutes', ''),
  (3, 1, '2020-01-03 00:12:37', '13.4 km', '20 minutes', NULL),
  (4, 2, '2020-01-04 13:53:03', '23.4 km', '40 minutes', NULL),
  (5, 3, '2020-01-08 21:10:57', '10 km', '15 minutes', NULL),
  (6, 3, '2020-01-08 22:00:00', '12 km', '20 minutes', 'Restaurant Cancellation'),
  (7, 2, '2020-01-08 21:30:45', '25 km', '25 minutes', NULL),
  (8, 2, '2020-01-10 00:15:02', '23.4 km', '15 minutes', NULL),
  (9, 2, '2020-01-10 10:00:00', '15 km', '20 minutes', 'Customer Cancellation'),
  (10, 1, '2020-01-11 18:50:20', '10 km', '10 minutes', 'Delayed'),
  (11, 4, '2020-01-12 19:45:00', '18 km', '30 minutes', NULL),
  (12, 1, '2020-01-13 21:00:00', '22 km', '35 minutes', 'Late Delivery'),
  (13, 3, '2020-01-14 20:15:00', '11 km', '25 minutes', NULL);
