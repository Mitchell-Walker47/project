# ProjectGroup34 Step 4 Draft Backend

## Technology Used
Node.js + Express + MySQL using mysql2.

## What Works
- RESET database route: `/reset`
- Demo DELETE route: `/demo-delete-customer`
- READ/SELECT pages for:
  - `/customers`
  - `/suppliers`
  - `/products`
  - `/orders`
  - `/order-items`
  - `/supplier-products`

## How to verify RESET
1. Import `DDL.sql` into the CS340 database using phpMyAdmin.
2. Import `PL.sql` into the CS340 database using phpMyAdmin.
3. Run the app with `npm start`.
4. Open the home page.
5. Click Customers and confirm Maya Johnson exists.
6. Click Delete Demo Customer.
7. Go back to Customers and confirm Maya Johnson is gone.
8. Click RESET Database.
9. Go back to Customers and confirm Maya Johnson is restored.

## Setup
1. Run `npm install`.
2. Copy `.env.example` to `.env`.
3. Put your real CS340 database credentials in `.env`.
4. Run `npm start`.

## Notes
- This is Step 4 Draft work.
- CUD is intentionally limited to one DELETE demo because the Step 4 draft only requires one CUD operation to demonstrate RESET.
