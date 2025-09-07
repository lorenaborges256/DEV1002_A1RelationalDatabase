-- Creating all tables with primary keys and foreign keys
CREATE TABLE states (
  state_id VARCHAR(10) PRIMARY KEY,
  state VARCHAR(50)
);

CREATE TABLE cities (
  city_id VARCHAR(10) PRIMARY KEY,
  city VARCHAR(50),
  state_id VARCHAR(10) REFERENCES states(state_id) ON DELETE SET NULL
);

CREATE TABLE customer (
  customer_id VARCHAR(10) PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100) NOT NULL UNIQUE,
  address VARCHAR(100),
  city_id VARCHAR(10) REFERENCES cities(city_id) ON DELETE SET NULL
);

CREATE TABLE orders (
  orders_id VARCHAR(10) PRIMARY KEY,
  order_date TIMESTAMP,
  total_paid NUMERIC(10, 2),
  customer_id VARCHAR(10) REFERENCES customer(customer_id) ON DELETE CASCADE
);

CREATE TABLE category (
  category_id VARCHAR(10) PRIMARY KEY,
  name VARCHAR(100)
);

CREATE TABLE products (
  product_id VARCHAR(10) PRIMARY KEY,
  title VARCHAR(500),
  price NUMERIC(10, 2),
  stock INTEGER,
  category_id VARCHAR(10) REFERENCES category(category_id) ON DELETE SET NULL
);

CREATE TABLE products_Order (
  orders_id VARCHAR(10) REFERENCES orders(orders_id) ON DELETE CASCADE,
  product_id VARCHAR(10) REFERENCES products(product_id) ON DELETE CASCADE,
  order_qty INTEGER SET DEFAULT 1,
  PRIMARY KEY ("orders_id", "product_id")
);
---------------------------------------------------------------
-- Inserting sample data into the tables

INSERT INTO states (state_id, state)
VALUES 
('ST01','NSW' ),
('ST02','VIC' ),
('ST03','QLD' ),
('ST04','WA' ),
('ST05','SA' ),
('ST06','TAS' ),
('ST07','ACT' ),
('ST08','NT' )
 ;

INSERT INTO cities (city_id, city,  state_id) VALUES
('CT01','Sydney','ST01' ),
('CT02','Melbourne','ST02' ),
('CT03','Brisbane','ST03' ),
('CT04','Perth','ST04' ),
('CT05','Adelaide','ST05' ),
('CT06','Hobart','ST06' ),
('CT07','Canberra','ST07' ),
('CT08','Darwin','ST08' ),
('CT09','Gold Coast','ST03' ),
('CT10','Newcastle','ST01' ),
('CT11','Cairns','ST03' ) 
;

INSERT INTO customer (customer_id, name, email, address, city_id)
VALUES ('C001','Ava Thompson','ava.t@samplemail.com','12 Oceanview Rd','CT01' ),
('C002','Liam Patel','liam.p@samplemail.com','88 King St','CT02' ),
('C003','Mia Chen','mia.c@samplemail.com','5 Riverbend Ave','CT03' )
;

INSERT INTO orders (orders_id, order_date, total_paid, customer_id)
VALUES ('0830','2025-08-24 12:48:16 +1000','46.75','C003' ),
('0833','2025-08-21 08:36:17 +1000','15.95','C001' )
;

INSERT INTO category (category_id, name)
VALUES ('C001','Shampoo' ),
('C002','Conditioner' ),
('C003','Mask' ),
('C004','Serum' )
;

INSERT INTO products (product_id, title, price, stock, category_id)
VALUES ('P001','Argan Oil Shampoo (500ml)','18.95','80','C001' ),
('P002','Color-Safe Purple Shampoo (300ml)','15.95','95','C001' ),
('P003','Tea Tree Clarifying Shampoo (500ml)','13.5','110','C001' ),
('P004','Keratin Repair Conditioner (300ml)','16.5','65','C002' ),
('P005','Volumizing Dry Shampoo Spray (150ml)','14.99','120','C001' ),
('P006','Scalp Detox Treatment Mask (200ml)','22','40','C003' ),
('P007','Curl Defining Cream (250ml)','19.75','55','C002' ),
('P008','Leave-In Hydration Mist (100ml)','17.25','70','C002' ),
('P009','Anti-Frizz Serum with Coconut Oil (100ml)','21.9','30','C004' ),
('P010','Heat Protectant Spray (200ml)','18','60','C004' )
;

INSERT INTO products_Order (orders_id, product_id, order_qty)
VALUES ('#0830','P003','2' ),
('#0830','P007','1' ),
('#0831','P001','3' ),
('#0832','P005','1' ),
('#0832','P009','2' ),
('#0833','P002','1' ),
('#0834','P004','2' ),
('#0835','P006','1' ),
('#0835','P010','1' ),
('#0836','P008','2' ),
('#0837','P010','1' ),
('#0838','P002','3' ),
('#0839','P003','1' ),
('#0840','P010','2' ),
('#0841','P009','1' ),
('#0842','P001','2' ),
('#0842','P005','1' ),
('#0843','P003','1' ),
;

--------------------------------------------------------------
-- query a table for a single record

-- Get one record by ID: 
SELECT * FROM customer 
WHERE customer_id = 'C001';

-- Get the first record in the table: 
SELECT * FROM products 
LIMIT 1;

-- Get the most recent order:
SELECT * FROM orders 
ORDER BY order_date DESC 
LIMIT 1;
--------------------------------------------------------------
-- query joined tables for a single record
--Give me orders that belong to customers 'C001'.
SELECT c.customer_id, c.name, o.orders_id, o.order_date
FROM customer c
JOIN orders o ON c.customer_id = o.customer_id
WHERE c.customer_id = 'C001'
ORDER BY o.order_date DESC
LIMIT 1;

--------------------------------------------------------------
-- insert a record into a table

INSERT INTO customer (customer_id, name, email, address, city_id)
VALUES ('C004','Noah Williams','noah.w@samplemail.com','42 Sunset Blvd','CT04' ),
('C005','Isabella Nguyen','isabella.n@samplemail.com',' 77 Garden Ln','CT05' ),
('C006','Ethan Smith','ethan.s@samplemail.com','101 Harbour Dr','CT06' ),
('C007','Zoe Johnson','zoe.j@samplemail.com','33 Maple St','CT07' ),
('C008','Oliver Davis','oliver.d@samplemail.com','19 Coral Cres','CT08' ),
('C009','Emily Brown','emily.b@samplemail.com','60 Pine Rd','CT09' ),
('C010','Jack Wilson','jack.w@samplemail.com','25 Bayview Ter','CT10' ),
('C011','Grace Taylor','grace.t@samplemail.com','14 Windmill St','CT01' ),
('C012','Benjamin Lee','ben.lee@samplemail.com','200 Queen St','CT03' ),
('C013','Chloe Martin','chloe.m@samplemail.com','9 Seaview Rd','CT05' ),
('C014','Lucas Wright','lucas.w@samplemail.com','55 Forest Dr','CT02' ),
('C015','Harper Singh','harper.s@samplemail.com','81 Lighthouse Ln','CT06' ),
('C016','Henry Clark','henry.c@samplemail.com','37 Rainforest Way','CT11' ),
('C017','Lily Robinson','lily.r@samplemail.com','102 Skyline Blvd','CT04' ),
('C018','Samuel Turner','samuel.t@samplemail.com','66 Valley Rd','CT08' ),
('C019','Aria Murphy','aria.m@samplemail.com','28 Crescent Ave','CT07' ),
('C020','Isaac Hall','isaac.h@samplemail.com','73 Horizon Ct','CT10' )
;


---------------------------------------------------------------
-- insert a record into a table with appropriate foreign-key data

INSERT INTO orders (orders_id, order_date, total_paid, customer_id)
VALUES ('#0830','2025-08-24 12:48:16 +1000','46.75','C003' ),
('#0831','2025-08-21 15:46:14 +1000','56.85','C007' ),
('#0832','2025-08-21 15:46:14 +1000','58.79','C015' ),
('#0833','2025-08-21 08:36:17 +1000','15.95','C001' ),
('#0834','2025-08-20 19:34:10 +1000','33','C010' ),
('#0835','2025-08-18 11:30:21 +1000','40','C018' ),
('#0836','2025-08-17 05:56:07 +1000','34.5','C005' ),
('#0837','2025-08-16 16:38:06 +1000','18','C012' ),
('#0838','2025-08-15 13:42:17 +1000','47.85','C020' ),
('#0839','2025-08-15 12:26:18 +1000','13.5','C009' ),
('#0840','2025-08-14 15:42:19 +1000','36','C002' ),
('#0841','2025-08-13 16:02:46 +1000','21.9','C014' ),
('#0842','2025-08-12 23:40:09 +1000','52.89','C006' ),
('#0843','2025-08-12 15:44:20 +1000','13.5','C017' ),
('#0844','2025-08-12 14:46:30 +1000','39.5','C008' ),
('#0845','2025-08-12 14:46:30 +1000','21.9','C011' ),
('#0846','2025-08-12 14:46:30 +1000','47.85','C019' ),
('#0847','2025-08-12 14:46:30 +1000','60.5','C004' ),
('#0848','2025-08-12 14:46:30 +1000','17.25','C013' ),
('#0849','2025-08-12 14:46:30 +1000','36','C016' ),
('#0850','2025-08-12 14:46:30 +1000','15.95','C001' ),
('#0851','2025-08-12 14:46:30 +1000','33','C007' ),
('#0852','2025-08-12 14:46:30 +1000','19.75','C015' ),
('#0853','2025-08-12 14:46:30 +1000','53.8','C003' ),
('#0854','2025-08-12 14:46:30 +1000','18.95','C010' ),
('#0855','2025-08-11 16:48:20 +1000','27','C018' ),
('#0856','2025-08-11 15:32:19 +1000','14.99','C005' ),
('#0857','2025-08-10 19:32:27 +1000','39.5','C012' ),
('#0858','2025-08-10 18:42:17 +1000','21.9','C020' ),
('#0859','2025-08-09 17:46:19 +1000','31.9','C009' ),
('#0860','2025-07-20 22:42:17 +1000','16.5','C010' ),
('#0861','2025-07-20 08:32:17 +1000','65.7','C011' ),
('#0862','2025-07-18 11:32:18 +1000','22','C012' ),
('#0863','2025-07-15 23:30:13 +1000','34.5','C013' ),
('#0864','2025-07-15 22:38:14 +1000','18','C014' ),
('#0865','2025-07-15 11:38:14 +1000','15.95','C015' ),
('#0866','2025-07-15 00:44:12 +1000','33','C016' ),
('#0867','2025-07-14 05:24:21 +1000','19.75','C017' ),
('#0868','2025-07-13 11:28:21 +1000','39.5','C016' ),
('#0869','2025-07-13 05:32:11 +1000','31.9','C001' ),
('#0870','2025-07-11 22:38:10 +1000','18.95','C007' ),
('#0871','2025-07-11 10:34:10 +1000','13.5','C015' ),
('#0872','2025-07-10 11:24:17 +1000','19.75','C011' ),
('#0873','2025-07-08 22:24:36 +1000','18.95','C019' ),
('#0874','2025-07-08 22:24:18 +1000','29.98','C004' ),
('#0875','2025-07-07 12:42:15 +1000','21.9','C013' ),
('#0876','2025-07-03 13:38:20 +1000','15.95','C016' ),
('#0877','2025-07-02 00:46:17 +1000','16.5','C001' ),
('#0878','2025-06-23 14:28:11 +1000','40','C007' ),
('#0878','2025-06-22 20:38:15 +1000','40','C015' ),
('#0879','2025-06-22 13:34:13 +1000','17.25','C003' ),
('#0880','2025-06-21 11:48:15 +1000','36','C010' ),
('#0881','2025-06-18 13:28:13 +1000','15.95','C018' ),
('#0882','2025-06-15 22:44:14 +1000','13.5','C005' ),
('#0883','2025-06-12 12:38:16 +1000','18','C012' ),
('#0884','2025-06-10 15:32:10 +1000','43.8','C020' ),
('#0885','2025-06-09 23:48:20 +1000','37.9','C009' )
;

---------------------------------------------------------------
-- update a record in a table
UPDATE customer
SET email = 'new_email.lian.p@updatemail.com'
WHERE customer_id = 'C002'
;

UPDATE orders
SET orders_id = REPLACE(orders_id, '#', '')
;

---------------------------------------------------------------
-- delete a record from a table
-- with no foreign key violations because this FK was setted to NULL on delete
DELETE FROM orders
WHERE orders_id = '0835'
;
---------------------------------------------------------------
-- order data by a specific value
-- Order highest total spend BY CUSTOMER per order

SELECT customer_id, MAX(total_paid)
FROM orders
GROUP BY customer_id
ORDER BY MAX(total_paid) DESC
;

---------------------------------------------------------------
-- Calculate a Order toal paid using products (price) table and products_order (order_qty) table
SELECT po.orders_id,
       SUM(po.order_qty * p.price) AS total_paid
FROM products_order po
JOIN products p ON po.product_id = p.product_id
WHERE po.orders_id = '0832'
GROUP BY po.orders_id;

---------------------------------------------------------------
-- filtering data based on a specific value
SELECT * [ALL_COLUMNS]
FROM [TABLE_NAME]
WHERE stock < 80
;
---------------------------------------------------------------
-- usage of appropriate automated data creation such as default
CREATE TABLE products_Order (
  orders_id VARCHAR(10) REFERENCES orders(orders_id) ON DELETE CASCADE,
  product_id VARCHAR(10) REFERENCES products(product_id) ON DELETE CASCADE,
  order_qty INTEGER SET DEFAULT 1,
  PRIMARY KEY ("orders_id", "product_id")
);

-------------------
------ PROPOSED DATABASE SCENARIOS - ECOMMERCE STORE ------
-- Items shoped by customer name - JOIN MULTIPLES TABLES
SELECT 
    c.customer_id,
    c.name AS customer_name,
    p.product_id,
    p.title AS product_name,
    po.order_qty
FROM 
    customer c
JOIN 
    orders o ON c.customer_id = o.customer_id
JOIN 
    products_order po ON o.orders_id = po.orders_id
JOIN 
    products p ON po.product_id = p.product_id
ORDER BY 
    c.customer_id, p.title
;
-- Sum of orders by customer
SELECT customer_id,
       SUM(total_paid) AS total_spent
FROM orders
GROUP BY customer_id
ORDER BY total_spent DESC
;

-- Sum of revenue by category
SELECT p.category_id, 
    c.name AS category_name,
    SUM(po.order_qty * p.price) AS total_revenue
FROM products p
JOIN products_order po 
    ON p.product_id = po.product_id
JOIN category c 
    ON p.category_id = c.category_id 
GROUP BY p.category_id,c.name
ORDER BY total_revenue DESC
;

-- Average order value per customer - TOP 3 customers
SELECT c.name AS customer_name,
    ROUND(AVG(total_paid),2) AS avg_order_value
FROM orders AS o
JOIN customer AS c 
    ON o.customer_id = c.customer_id
GROUP BY c.name
ORDER BY avg_order_value DESC
LIMIT 3;


