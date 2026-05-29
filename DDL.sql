-- CS340 Database Systems - Project Step 2 Draft
-- Project: Computer Parts Store Management System
-- Group: 34
-- Members: Tullock Logan, Eddie Roland, Walker Mitchell
-- Instructor: Michael Curry
-- DDL.sql - creates tables and inserts sample data

DROP PROCEDURE IF EXISTS sp_reset_computer_parts_store;

DELIMITER //

CREATE PROCEDURE sp_reset_computer_parts_store()
BEGIN

SET FOREIGN_KEY_CHECKS = 0;


DROP TABLE IF EXISTS SupplierProducts;
DROP TABLE IF EXISTS OrderItems;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Suppliers;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS InvoiceDetails;
DROP TABLE IF EXISTS Invoices;
DROP TABLE IF EXISTS TermsCode;

SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE Customers (
    customerID INT AUTO_INCREMENT NOT NULL,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phoneNumber VARCHAR(20),
    streetAddress VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    zipCode VARCHAR(15) NOT NULL,
    PRIMARY KEY (customerID),
    UNIQUE KEY unique_customer_email (email)
);

CREATE TABLE Suppliers (
    supplierID INT AUTO_INCREMENT NOT NULL,
    supplierName VARCHAR(100) NOT NULL,
    contactName VARCHAR(100),
    email VARCHAR(100),
    phoneNumber VARCHAR(20),
    address VARCHAR(100),
    PRIMARY KEY (supplierID),
    UNIQUE KEY unique_supplier_name (supplierName)
);

CREATE TABLE Products (
    productID INT AUTO_INCREMENT NOT NULL,
    productName VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    brand VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stockQuantity INT NOT NULL,
    description VARCHAR(255),
    PRIMARY KEY (productID)
);

CREATE TABLE Orders (
    orderID INT AUTO_INCREMENT NOT NULL,
    customerID INT NOT NULL,
    orderDate DATE NOT NULL,
    totalAmount DECIMAL(10,2) NOT NULL,
    orderStatus VARCHAR(30) NOT NULL,
    PRIMARY KEY (orderID),
    CONSTRAINT fk_orders_customers
        FOREIGN KEY (customerID) REFERENCES Customers(customerID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE OrderItems (
    orderItemID INT AUTO_INCREMENT NOT NULL,
    orderID INT NOT NULL,
    productID INT NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (orderItemID),
    CONSTRAINT fk_orderitems_orders
        FOREIGN KEY (orderID) REFERENCES Orders(orderID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_orderitems_products
        FOREIGN KEY (productID) REFERENCES Products(productID)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    UNIQUE KEY unique_order_product (orderID, productID)
);

CREATE TABLE SupplierProducts (
    supplierProductID INT AUTO_INCREMENT NOT NULL,
    supplierID INT NOT NULL,
    productID INT NOT NULL,
    PRIMARY KEY (supplierProductID),
    CONSTRAINT fk_supplierproducts_suppliers
        FOREIGN KEY (supplierID) REFERENCES Suppliers(supplierID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_supplierproducts_products
        FOREIGN KEY (productID) REFERENCES Products(productID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    UNIQUE KEY unique_supplier_product (supplierID, productID)
);

INSERT INTO Customers (firstName, lastName, email, phoneNumber, streetAddress, city, state, zipCode) VALUES
('Maya', 'Johnson', 'maya.johnson@example.com', '503-555-0181', '1200 Alder Street', 'Portland', 'OR', '97201'),
('Noah', 'Garcia', 'noah.garcia@example.com', '503-555-0192', '450 Cedar Avenue', 'Salem', 'OR', '97301'),
('Ava', 'Patel', 'ava.patel@example.com', '503-555-0134', '89 Tech Park Drive', 'Beaverton', 'OR', '97005');

INSERT INTO Suppliers (supplierName, contactName, email, phoneNumber, address) VALUES
('Northwest Components', 'Liam Carter', 'sales@nwcomponents.example.com', '503-555-0222', '700 Warehouse Road, Portland, OR'),
('Pacific Hardware Supply', 'Emma Wilson', 'orders@pacifichardware.example.com', '503-555-0244', '410 Industrial Way, Eugene, OR'),
('Cascade Computer Parts', 'Olivia Brown', 'support@cascadeparts.example.com', '503-555-0277', '222 Supplier Lane, Salem, OR');

INSERT INTO Products (productName, category, brand, price, stockQuantity, description) VALUES
('Ryzen 7 7800X3D Processor', 'Processor', 'AMD', 389.99, 18, 'Eight-core desktop CPU for gaming and productivity'),
('GeForce RTX 4070 Graphics Card', 'Graphics Card', 'NVIDIA', 599.99, 12, 'High-performance GPU for gaming and creative workloads'),
('32GB DDR5 Memory Kit', 'Memory', 'Corsair', 119.99, 35, 'Two-stick DDR5 desktop memory kit'),
('2TB NVMe Solid State Drive', 'Storage', 'Samsung', 149.99, 24, 'Fast internal PCIe NVMe storage drive');

INSERT INTO Orders (customerID, orderDate, totalAmount, orderStatus) VALUES
((SELECT customerID FROM Customers WHERE email = 'maya.johnson@example.com'), '2026-04-01', 509.98, 'Shipped'),
((SELECT customerID FROM Customers WHERE email = 'noah.garcia@example.com'), '2026-04-03', 599.99, 'Processing'),
((SELECT customerID FROM Customers WHERE email = 'ava.patel@example.com'), '2026-04-06', 269.98, 'Delivered');

INSERT INTO OrderItems (orderID, productID, quantity) VALUES
((SELECT orderID FROM Orders WHERE customerID = (SELECT customerID FROM Customers WHERE email = 'maya.johnson@example.com') AND orderDate = '2026-04-01'),
 (SELECT productID FROM Products WHERE productName = 'Ryzen 7 7800X3D Processor'), 1),
((SELECT orderID FROM Orders WHERE customerID = (SELECT customerID FROM Customers WHERE email = 'maya.johnson@example.com') AND orderDate = '2026-04-01'),
 (SELECT productID FROM Products WHERE productName = '32GB DDR5 Memory Kit'), 1),
((SELECT orderID FROM Orders WHERE customerID = (SELECT customerID FROM Customers WHERE email = 'noah.garcia@example.com') AND orderDate = '2026-04-03'),
 (SELECT productID FROM Products WHERE productName = 'GeForce RTX 4070 Graphics Card'), 1),
((SELECT orderID FROM Orders WHERE customerID = (SELECT customerID FROM Customers WHERE email = 'ava.patel@example.com') AND orderDate = '2026-04-06'),
 (SELECT productID FROM Products WHERE productName = '2TB NVMe Solid State Drive'), 1),
((SELECT orderID FROM Orders WHERE customerID = (SELECT customerID FROM Customers WHERE email = 'ava.patel@example.com') AND orderDate = '2026-04-06'),
 (SELECT productID FROM Products WHERE productName = '32GB DDR5 Memory Kit'), 1);

INSERT INTO SupplierProducts (supplierID, productID) VALUES
((SELECT supplierID FROM Suppliers WHERE supplierName = 'Northwest Components'),
 (SELECT productID FROM Products WHERE productName = 'Ryzen 7 7800X3D Processor')),
((SELECT supplierID FROM Suppliers WHERE supplierName = 'Northwest Components'),
 (SELECT productID FROM Products WHERE productName = '32GB DDR5 Memory Kit')),
((SELECT supplierID FROM Suppliers WHERE supplierName = 'Pacific Hardware Supply'),
 (SELECT productID FROM Products WHERE productName = 'GeForce RTX 4070 Graphics Card')),
((SELECT supplierID FROM Suppliers WHERE supplierName = 'Cascade Computer Parts'),
 (SELECT productID FROM Products WHERE productName = '2TB NVMe Solid State Drive')),
((SELECT supplierID FROM Suppliers WHERE supplierName = 'Cascade Computer Parts'),
 (SELECT productID FROM Products WHERE productName = '32GB DDR5 Memory Kit'));

END //

DELIMITER ;

CALL sp_reset_computer_parts_store();
