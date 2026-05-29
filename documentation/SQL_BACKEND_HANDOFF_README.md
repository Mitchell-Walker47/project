# SQL / Backend Handoff - Project Step 4 Draft
Prepared by: Eddie Roland
ONID / username: rolande
Email: rolande@oregonstate.edu
Group: 34
Project: Computer Parts Store Management System

## What this package contains

This folder contains the SQL/backend portion for Project Step 4 Draft.

The goal of Step 4 is to:
1. Put the DDL.sql reset logic inside a stored procedure.
2. Add a RESET button/route that rebuilds the database and reloads sample data.
3. Implement SELECT/READ operations for all entities.
4. Implement at least one CUD operation to prove RESET works.
5. Include PL.sql if stored procedures are used.

## Main files

### DDL.sql
This file contains the stored procedure:

    sp_reset_computer_parts_store()

This procedure drops/recreates the project tables and reloads sample data. It is used for the RESET functionality.

### DML.sql
This file contains SELECT queries for all entities:

- Customers
- Suppliers
- Products
- Orders
- OrderItems
- SupplierProducts

The M:M pages use JOIN queries so names show instead of only raw IDs.

### PL.sql
This file contains one stored procedure for the required Step 4 CUD demo:

    sp_delete_demo_customer()

This deletes Maya Johnson from the Customers table. Then the RESET procedure can restore her, proving RESET works.

### app.js
This is the Express backend.

Routes included:

    /                       Home page
    /reset                  Calls sp_reset_computer_parts_store()
    /demo-delete-customer   Calls sp_delete_demo_customer()
    /customers              SELECT customers
    /suppliers              SELECT suppliers
    /products               SELECT products
    /orders                 SELECT orders with customer JOIN
    /order-items            SELECT order items with customer/product JOINs
    /supplier-products      SELECT supplier products with supplier/product JOINs

### database/db-connector.js
This file connects the backend to MySQL using mysql2 and environment variables.

### .env.example
This is the database credential template. I filled in my username as rolande.

Before running, copy this file and rename it to:

    .env

Then update the password and port.

Example:

    DB_HOST=classmysql.engr.oregonstate.edu
    DB_USER=rolande
    DB_PASSWORD=your_real_password
    DB_DATABASE=cs340_rolande
    PORT=your_assigned_port

## How to run

1. Install dependencies:

    npm install

2. Create the .env file:

    copy .env.example .env

On Mac/Linux:

    cp .env.example .env

3. Add the real database password and assigned port inside .env.

4. Import SQL files into phpMyAdmin in this order:

    DDL.sql
    PL.sql

5. Start the backend:

    npm start

6. Open the project:

    http://classwork.engr.oregonstate.edu:YOUR_PORT/

## How to test RESET

1. Open the Customers page.
2. Confirm Maya Johnson appears.
3. Click Delete Demo Customer.
4. Go back to Customers and confirm Maya Johnson is gone.
5. Click RESET Database.
6. Go back to Customers and confirm Maya Johnson appears again.

## What works

- Backend connects to MySQL.
- RESET stored procedure is included.
- One DELETE demo CUD operation is included.
- SELECT/READ routes exist for every entity.
- M:M pages use JOINs to display readable names.

## What still needs work later

- Full CREATE, UPDATE, and DELETE operations for every table are not all connected yet.
- UI can still be polished.
- Final PDF and Ed Discussion URL still need to be updated with the final deployed website link.

## Suggested Ed Discussion wording

Technology used:
Node.js, Express, MySQL, mysql2.

What works:
RESET route, DELETE demo route, and SELECT/READ pages for all entities.

How to tell RESET worked:
Delete Maya Johnson using the demo route, then use RESET and confirm Maya Johnson appears again.

What does not work yet:
Full CUD for all entities is not fully connected yet.

Blocked:
Main remaining work is expanding CUD routes/forms and polishing the UI.
