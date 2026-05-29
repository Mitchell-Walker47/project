-- CS340 Database Systems - Project Step 4 Draft
-- Project: Computer Parts Store Management System
-- Group: 34
-- Members: Tullock Logan, Eddie Roland, Walker Mitchell
-- PL.sql
-- Purpose: Additional stored procedure used by the backend to demonstrate one CUD operation.
-- AI citation: AI assistance was used to draft this small procedure based on the Step 4 requirement.


--todo: fix supplierproducts
DROP PROCEDURE IF EXISTS sp_delete_demo_customer;

DELIMITER //

CREATE PROCEDURE sp_delete_demo_customer()
BEGIN
    -- This hard-coded DELETE is only for Step 4 RESET demonstration.
    -- It removes one known sample customer. ON DELETE CASCADE removes that customer's orders/order items.
    DELETE FROM Customers
    WHERE email = 'maya.johnson@example.com';
END //

DELIMITER ;
