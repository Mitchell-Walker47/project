-- CS340 Database Systems, Project Step 3 Draft
-- Project: Computer Parts Store Management System
-- Group: 34
-- Members: Tullock Logan, Eddie Roland, Walker Mitchell
-- DML.sql - Data Manipulation Queries



                    --!!Important!!
-- Variables with @ are placeholder values that will use=the web app froms

------------------
-- Customers page
--------------------
-- Create
INSERT INTO Customers
(firstName, lastName, email, phoneNumber, streetAddress, city, state, zipCode)
VALUES
(@firstNameInput, @lastNameInput, @emailInput, @phoneNumberInput,
 @streetAddressInput, @cityInput, @stateInput, @zipCodeInput);

-- Read
SELECT customerID, firstName, lastName, email, phoneNumber, streetAddress, city, state, zipCode
FROM Customers;

-- Update
UPDATE Customers
SET firstName = @firstNameInput,
    lastName = @lastNameInput,
    email = @emailInput,
    phoneNumber = @phoneNumberInput,
    streetAddress = @streetAddressInput,
    city = @cityInput,
    state = @stateInput,
    zipCode = @zipCodeInput
WHERE customerID = @customerIDInput;

-- Delete 
DELETE FROM Customers
WHERE customerID = @customerIDInput;


------------------
-- Suppliers
------------------
-- Create
INSERT INTO Suppliers
(supplierName, contactName, email, phoneNumber, address)
VALUES
(@supplierNameInput, @contactNameInput, @emailInput,
 @phoneNumberInput, @addressInput);

-- Read
SELECT *
FROM Suppliers;

-- Update
UPDATE Suppliers
SET
supplierName = @supplierNameInput,
contactName = @contactNameInput,
email = @emailInput,
phoneNumber = @phoneNumberInput,
address = @addressInput
WHERE supplierID = @supplierIDInput;

-- Delete
DELETE FROM Suppliers
WHERE supplierID = @supplierIDInput;


------------------
-- Products
------------------

-- Create
INSERT INTO Products
(productName, category, brand, price, stockQuantity, description)
VALUES
(@productNameInput, @categoryInput, @brandInput,
 @priceInput, @stockQuantityInput, @descriptionInput);

-- Read
SELECT *
FROM Products;

-- Update
UPDATE Products
SET
productName = @productNameInput,
category = @categoryInput,
brand = @brandInput,
price = @priceInput,
stockQuantity = @stockQuantityInput,
description = @descriptionInput
WHERE productID = @productIDInput;

-- Delete
DELETE FROM Products
WHERE productID = @productIDInput;


------------------
-- Orders
------------------

-- Read
SELECT Orders.orderID, Customers.firstName, Customers.lastName,
Orders.orderDate, Orders.totalAmount, Orders.orderStatus
FROM Orders
INNER JOIN Customers ON Orders.customerID = Customers.customerID;

-- Create
INSERT INTO Orders
(customerID, orderDate, totalAmount, orderStatus)
VALUES
(@customerIDInput, @orderDateInput,
 @totalAmountInput, @orderStatusInput);

-- Update
UPDATE Orders
SET
customerID = @customerIDInput,
orderDate = @orderDateInput,
totalAmount = @totalAmountInput,
orderStatus = @orderStatusInput
WHERE orderID = @orderIDInput;

-- Delete
DELETE FROM Orders
WHERE orderID = @orderIDInput;


------------------
-- OrderItems
------------------
-- Read
SELECT OrderItems.orderItemID, Orders.orderID,
Products.productName, OrderItems.quantity
FROM OrderItems
INNER JOIN Orders ON OrderItems.orderID = Orders.orderID
INNER JOIN Products ON OrderItems.productID = Products.productID;

-- Create
INSERT INTO OrderItems
(orderID, productID, quantity)
VALUES
(@orderIDInput, @productIDInput, @quantityInput);

-- Update
UPDATE OrderItems
SET
orderID = @orderIDInput,
productID = @productIDInput,
quantity = @quantityInput
WHERE orderItemID = @orderItemIDInput;

-- Delete
DELETE FROM OrderItems
WHERE orderItemID = @orderItemIDInput;


------------------
-- SupplierProducts
------------------
-- Read
SELECT SupplierProducts.supplierProductID,
Suppliers.supplierName,
Products.productName
FROM SupplierProducts
INNER JOIN Suppliers
ON SupplierProducts.supplierID = Suppliers.supplierID
INNER JOIN Products
ON SupplierProducts.productID = Products.productID;

-- Create
INSERT INTO SupplierProducts
(supplierID, productID)
VALUES
(@supplierIDInput, @productIDInput);

-- Update
UPDATE SupplierProducts
SET
supplierID = @supplierIDInput,
productID = @productIDInput
WHERE supplierProductID = @supplierProductIDInput;

-- Delete
DELETE FROM SupplierProducts
WHERE supplierProductID = @supplierProductIDInput;