/*-----------------------------------------create schema for e-commerce----------------------------------------------------------------*/

show databases;
use Ecommerce;
/*---------------------------------------------database design--------------------------------------------------------------------------*/
show tables;
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    fullname VARCHAR(100),
    email VARCHAR(45),
    mobile_no VARCHAR(100),
    gender ENUM('Male', 'Female', 'Other'),
    address TEXT,
    created_on_datetime TIMESTAMP(6),
    password VARCHAR(100),
    age INT,
    order_order_id INT,
    order_totalamount DECIMAL(20),
    Reviews_review_id INT
);
INSERT INTO customer (fullname, email, mobile_no, gender, address, created_on_datetime, password, age, order_order_id, order_totalamount, Reviews_review_id)
VALUES
('John Doe', 'john.doe@example.com', '1234567890', 'Male', '123 Elm St', NOW(), 'password123', 30, NULL, NULL, NULL),
('Jane Smith', 'jane.smith@example.com', '9876543210', 'Female', '456 Oak St', NOW(), 'securepass', 28, NULL, NULL, NULL),
('Alice Johnson', 'alice.j@example.com', '1122334455', 'Female', '789 Pine St', NOW(), 'alicepass', 35, NULL, NULL, NULL),
('Bob Brown', 'bob.brown@example.com', '6655443322', 'Male', '321 Maple St', NOW(), 'bobsecure', 40, NULL, NULL, NULL),
('Charlie Green', 'charlie.g@example.com', '7788990011', 'Other', '654 Birch St', NOW(), 'charliepass', 29, NULL, NULL, NULL);

CREATE TABLE product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    description TEXT(500),
    price DECIMAL(20),
    category VARCHAR(100),
    stock INT,
    created_at_datetime DATETIME,
    lastupdated_datetime DATETIME,
    productcol VARCHAR(45),
    stock_quantity VARCHAR(45),
    Reviews_review_id INT
);

INSERT INTO product (name, description, price, category, stock, created_at_datetime, lastupdated_datetime, productcol, stock_quantity, Reviews_review_id)
VALUES
('Laptop', 'High performance laptop', 1200.50, 'Electronics', 15, NOW(), NOW(), NULL, '15', NULL),
('Smartphone', 'Latest model smartphone', 800.00, 'Electronics', 25, NOW(), NOW(), NULL, '25', NULL),
('Headphones', 'Noise-canceling headphones', 150.00, 'Electronics', 50, NOW(), NOW(), NULL, '50', NULL),
('Office Chair', 'Ergonomic office chair', 200.00, 'Furniture', 10, NOW(), NOW(), NULL, '10', NULL),
('Gaming Mouse', 'High-precision gaming mouse', 60.00, 'Accessories', 100, NOW(), NOW(), NULL, '100', NULL);


CREATE TABLE `order` (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id int,
    orderdate VARCHAR(100),
    status VARCHAR(100),
    totalamount DECIMAL(5,2),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);
ALTER TABLE `order`
MODIFY COLUMN totalamount DECIMAL(10,2);

INSERT INTO `order` (customer_id, orderdate, status, totalamount)
VALUES
(1, NOW(), 'Completed', 1350.50),
(2, NOW(), 'Pending', 800.00),
(3, NOW(), 'Cancelled', 0.00),
(4, NOW(), 'Completed', 410.00),
(5, NOW(), 'Processing', 120.00);

CREATE TABLE order_details (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(20),
    order_detailscol VARCHAR(45),
    Cart_cart_id INT,
    product_product_id INT,
    FOREIGN KEY (order_id) REFERENCES `order`(order_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

INSERT INTO order_details (order_id, product_id, quantity, price, order_detailscol, Cart_cart_id, product_product_id)
VALUES
(1, 1, 1, 1200, null, NULL, NULL),
(1, 3, 1, 150, null, NULL, NULL),
(2, 2, 1, 800, null, NULL, NULL),
(4, 4, 2, 410, null, NULL, NULL),
(5, 5, 2, 120, null, NULL, NULL);

CREATE TABLE cart (
    cart_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    product_id INT,
    quantity_id INT,
    added_at_date VARCHAR(45),
    Shipping_shipping_id INT,
    FOREIGN KEY (user_id) REFERENCES customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

INSERT INTO cart (user_id, product_id, quantity_id, added_at_date, Shipping_shipping_id)
VALUES
(1, 1, 1, NOW(), NULL),
(1, 3, 1, NOW(), NULL),
(2, 2, 1, NOW(), NULL),
(4, 4, 2, NOW(), NULL),
(5, 5, 1, NOW(), NULL);

CREATE TABLE shipping (
    shipping_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    shippingaddress TEXT(100),
    city VARCHAR(45),
    state VARCHAR(45),
    postalcode VARCHAR(45),
    status VARCHAR(45),
    shippeddate DATETIME,
    Payments_Payment_id INT,
    FOREIGN KEY (order_id) REFERENCES `order`(order_id)
);
INSERT INTO shipping (order_id, shippingaddress, city, state, postalcode, status, shippeddate, Payments_Payment_id)
VALUES
(1, '123 Elm St', 'New York', 'NY', '10001', 'Delivered', NOW(), NULL),
(2, '456 Oak St', 'Los Angeles', 'CA', '90001', 'In Transit', NOW(), NULL),
(3, '789 Pine St', 'Chicago', 'IL', '60601', 'Cancelled', NOW(), NULL),
(4, '321 Maple St', 'Houston', 'TX', '77001', 'Delivered', NOW(), NULL),
(5, '654 Birch St', 'Phoenix', 'AZ', '85001', 'Processing', NOW(), NULL);

CREATE TABLE reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    product_id INT,
    rating INT,
    comment TEXT(100),
    review_date DATETIME,
    FOREIGN KEY (user_id) REFERENCES customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

INSERT INTO reviews (user_id, product_id, rating, comment, review_date)
VALUES
(1, 1, 5, 'Excellent product!', NOW()),
(2, 2, 4, 'Very useful and efficient.', NOW()),
(3, 3, 3, 'Decent but could be better.', NOW()),
(4, 4, 5, 'Very comfortable!', NOW()),
(5, 5, 4, 'Good for gaming, love it!', NOW());

CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    paymentdate DATETIME,
    amount DECIMAL(5,2),
    payment_methods VARCHAR(50),
    status VARCHAR(45),
    FOREIGN KEY (order_id) REFERENCES `order`(order_id)
);
alter table payments modify column amount decimal (10,2);

INSERT INTO payments (order_id, paymentdate, amount, payment_methods, status)
VALUES
(1, NOW(), 1350.50, 'Credit Card', 'Completed'),
(2, NOW(), 800.00, 'PayPal', 'Pending'),
(3, NOW(), 0.00, 'N/A', 'Cancelled'),
(4, NOW(), 410.00, 'Credit Card', 'Completed'),
(5, NOW(), 120.00, 'Cash on Delivery', 'Processing');

/*-------------------select and where statement------------------*/
SELECT * FROM customer;
SELECT * FROM customer WHERE customer_id = 2;
SELECT * FROM customer WHERE created_on_datetime > '2024-11-18';

SELECT * FROM product;
SELECT * FROM product WHERE product_id = 3;
SELECT * FROM product WHERE price < 500;

SELECT * FROM `order`;
SELECT * FROM `order` WHERE order_id = 1;
SELECT * FROM `order` WHERE customer_id = 1;

SELECT * FROM order_details;
SELECT * FROM order_details WHERE order_id = 2;

SELECT product_id, SUM(quantity) AS total_quantity
FROM order_details
GROUP BY product_id;

SELECT * FROM cart;
SELECT * FROM cart WHERE user_id = 4;

SELECT * FROM shipping;
SELECT * FROM shipping WHERE order_id = 4;

SELECT * FROM reviews;
SELECT * FROM reviews WHERE product_id = 1;
SELECT product_id, AVG(rating) AS average_rating
FROM reviews
GROUP BY product_id;

SELECT * FROM payments;
SELECT * FROM payments WHERE order_id = 5;

/* ------------comparison operator--------------*/
SELECT * FROM customer WHERE age = 30;
SELECT * FROM product WHERE price <> 500;
SELECT * FROM `order` WHERE totalamount > 1000;
SELECT * FROM product WHERE stock <= 15;
SELECT * FROM customer WHERE age >= 30;
SELECT * FROM product WHERE price <= 200;

/*------------logical operator------------*/
SELECT * FROM customer WHERE age >= 30 AND gender = 'Male';
SELECT * FROM product WHERE category = 'Electronics' OR category = 'Furniture';
SELECT * FROM customer WHERE NOT gender = 'Female';

/*-----------------In operator--------------*/
SELECT * FROM product WHERE category IN ('Electronics', 'Furniture');

/*-----------------Between operator--------------*/
SELECT * FROM product WHERE price BETWEEN 100 AND 500;

/*-----------------like operator/ wildcard% and wildcard_ --------------*/
SELECT * FROM customer WHERE fullname LIKE 'J%';
SELECT * FROM product WHERE name LIKE '_j';

SELECT * FROM product ORDER BY price DESC;
SELECT customer_id AS ID, fullname AS Name FROM customer;

/*----------------Group By and Aggregate Functions -------------------*/
SELECT category, COUNT(*) AS product_count FROM product GROUP BY category;
SELECT customer_id, SUM(totalamount) AS total_spent FROM `order` GROUP BY customer_id;
SELECT product_id, AVG(rating) AS average_rating FROM reviews GROUP BY product_id;
SELECT MIN(price), MAX(price) FROM product;

/*------------ inner join ----------------*/
SELECT category, COUNT(*) AS product_count FROM product GROUP BY category HAVING COUNT(*) > 10;
SELECT * FROM customer c JOIN `order` o ON c.customer_id = o.customer_id;

SELECT * FROM customer c LEFT JOIN `order` o ON c.customer_id = o.customer_id;
SELECT * FROM customer c RIGHT JOIN `order` o ON c.customer_id = o.customer_id;
SELECT * FROM customer c  JOIN `order` o ON c.customer_id = o.customer_id;
SELECT c1.fullname AS customer1, c2.fullname AS customer2
FROM customer c1
JOIN customer c2 ON c1.customer_id <> c2.customer_id; # self join

/*-------subqueries----*/
SELECT * FROM product WHERE price > (SELECT AVG(price) FROM product);

/*-----window function-------*/
SELECT *, ROW_NUMBER() OVER (ORDER BY price DESC) AS row_num FROM product;

/*-------- cte common table expression--------*/
WITH TopCustomers AS (
    SELECT customer_id, SUM(totalamount) AS total_spent
    FROM `order`
    GROUP BY customer_id
    ORDER BY total_spent DESC
    LIMIT 10
)
SELECT c.fullname, tc.total_spent
FROM customer c
JOIN TopCustomers tc ON c.customer_id = tc.customer_id;

/*-----------case statement---------*/
SELECT customer_id, fullname,
  CASE WHEN age >= 18 THEN 'Adult'
       WHEN age >= 13 THEN 'Teenager'
       ELSE 'Child'
  END AS age_group
FROM customer;

/*---------having clause----------*/
SELECT category, COUNT(*) AS product_count
FROM product
GROUP BY category
HAVING COUNT(*) > 1;  -- Filter categories with more than 1 products

/*---------- multiple joins--------*/
SELECT c.fullname, p.name, r.rating
FROM customer c
INNER JOIN `order` o ON o.customer_id = c.customer_id
INNER JOIN order_details od ON od.order_id = o.order_id
INNER JOIN product p ON p.product_id = od.product_id
INNER JOIN reviews r ON r.product_id = p.product_id
WHERE c.fullname = 'John Doe';

/*----------indexes--------*/
CREATE INDEX idx_customer_name ON customer(fullname);
CREATE INDEX idx_product_category ON product(category);
CREATE INDEX idx_order_customer_id ON `order`(customer_id); 

/*---------- store procedure-------------*/
delimiter $$
CREATE PROCEDURE GetCustomerOrders(IN customer_id INT)
BEGIN
  SELECT *
  FROM `order` o
  JOIN customer c ON o.customer_id = c.customer_id
  WHERE c.customer_id = customer_id;
END $$
delimiter ;

CALL GetCustomerOrders(2);  -- This will call the procedure for customer ID 2
/*-------------trigger------------*/
delimiter $$
CREATE TRIGGER update_stock_on_order_place
AFTER INSERT ON order_details
FOR EACH ROW
BEGIN
  UPDATE product
  SET stock = stock - NEW.quantity
  WHERE product_id = NEW.product_id;
END $$
delimiter ;

select * from order_details;
INSERT INTO order_details (order_id, product_id, quantity, price)
VALUES (6, 1, 2, 1200);
/*-------------multiplejoins----------------*/ # find  customer review
SELECT c.fullname, p.name, r.rating
FROM customer c
INNER JOIN `order` o ON o.customer_id = c.customer_id
INNER JOIN order_details od ON od.order_id = o.order_id
INNER JOIN product p ON p.product_id = od.product_id
INNER JOIN reviews r ON r.product_id = p.product_id
WHERE c.fullname = 'John Doe';

# find top selling product
SELECT p.name, SUM(od.quantity) AS total_sold
FROM product p
INNER JOIN order_details od ON od.product_id = p.product_id
GROUP BY p.name
ORDER BY total_sold DESC;

# find orde and specfic status
SELECT c.fullname, o.orderdate, o.status
FROM customer c
INNER JOIN `order` o ON o.customer_id = c.customer_id
WHERE o.status = 'Completed';
/*-----------------------------------Data Analysis-----------------------*/
/*# Find Customers Who Haven't Ordered Yet:*/
SELECT c.fullname
FROM customer c
LEFT JOIN `order` o ON o.customer_id = c.customer_id
WHERE o.order_id IS NULL;

/*#Find Orders with Specific Products:*/
SELECT o.order_id, customer_id
FROM `order` o
INNER JOIN order_details od ON od.order_id = o.order_id
INNER JOIN product p ON p.product_id = od.product_id
WHERE p.name = 'Laptop';

/*# revenue by customer*/
SELECT c.fullname, SUM(o.totalamount) AS total_spent
FROM customer c
JOIN `order` o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.fullname
ORDER BY total_spent DESC;

/*# sales by product*/
SELECT p.category, SUM(od.quantity) AS total_sold
FROM product p
JOIN order_details od ON p.product_id = od.product_id
GROUP BY p.category
ORDER BY total_sold DESC;

/*# order status distributuion*/ 
SELECT status, COUNT(*) AS total_orders
FROM `order`
GROUP BY status;

/*# average rating by category*/
SELECT p.category, AVG(r.rating) AS average_rating
FROM product p
JOIN reviews r ON p.product_id = r.product_id
GROUP BY p.category;

/*# customer age groups*/
SELECT 
  CASE 
    WHEN age < 18 THEN 'Under 18'
    WHEN age BETWEEN 18 AND 30 THEN '18-30'
    WHEN age BETWEEN 31 AND 50 THEN '31-50'
    ELSE '51+' 
  END AS age_group,
  COUNT(*) AS total_customers
FROM customer
GROUP BY age_group;
