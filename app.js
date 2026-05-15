/*
    Citation for starter code used in this file:
    Date Retrieved: 05/03/2026
    Adapted from: CS340 Node.js starter code
    Source: Oregon State University CS340 Exploration - Web Application Technology
    Type: starter code

    Notes:
    Original BSG example routes adapted into project-specific routes
    such as Customers.
*/

// ########################################
// ########## SETUP

// Express
const express = require('express');
const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static('public'));

const PORT = 6767;

// Database
const db = require('./database/db-connector');

// Handlebars
const { engine } = require('express-handlebars'); // Import express-handlebars engine
app.engine('.hbs', engine({ extname: '.hbs' })); // Create instance of handlebars
app.set('view engine', '.hbs'); // Use handlebars engine for *.hbs files.

// ########################################
// ########## ROUTE HANDLERS

// READ ROUTES
app.get('/', async function (req, res) {
    try {
        res.render('home'); // Render the home.hbs file
    } catch (error) {
        console.error('Error rendering page:', error);
        // Send a generic error message to the browser
        res.status(500).send('An error occurred while rendering the page, Please review app.js');
    }
});

// While we removed bsg people from homepage, the code for it is a good reference
// code to work off of right now. though it will be removed later for final part
app.get('/bsg-people', async function (req, res) {
    try {
        // Create and execute our queries
        // In query1, we use a JOIN clause to display the names of the homeworlds
        const query1 = `SELECT bsg_people.id, bsg_people.fname, bsg_people.lname, \
            bsg_planets.name AS 'homeworld', bsg_people.age FROM bsg_people \
            LEFT JOIN bsg_planets ON bsg_people.homeworld = bsg_planets.id;`;
        const query2 = 'SELECT * FROM bsg_planets;';
        const [people] = await db.query(query1);
        const [homeworlds] = await db.query(query2);

        // Render the bsg-people.hbs file, and also send the renderer
        //  an object that contains our bsg_people and bsg_homeworld information
        res.render('bsg-people', { people: people, homeworlds: homeworlds });
    } catch (error) {
        console.error('Error executing queries:', error);
        // Send a generic error message to the browser
        res.status(500).send(
            'An error occurred while executing the database queries.'
        );
    }
});
//----------------------------------------------------------------------------

app.get('/customers', async function (req, res) {
    try {
        const query1 = `
        SELECT customerID, firstName, lastName, email, phoneNumber,
               streetAddress, city, state, zipCode
        FROM Customers;
        `;

        const [customers] = await db.query(query1);

        res.render('customers', { customers: customers });
    } catch (error) {
        console.error('error executing Customers Query: ', error);
        res.status(500).send('An error occurred while loading Customers.');
    }
});

app.get('/suppliers', async function (req, res) {
    try {
        const query1 = `
        SELECT supplierID, supplierName, contactName, email,
               phoneNumber, address
        FROM Suppliers;
        `;

        const [suppliers] = await db.query(query1);

        res.render('suppliers', { suppliers: suppliers });
    } catch (error) {
        console.error('Error executing Suppliers query:', error);
        res.status(500).send('An error occurred while loading Suppliers.');
    }
});

app.get('/products', async function (req, res) {
    try {
        const query1 = `
        SELECT productID, productName, category, brand, price,
               stockQuantity, description
        FROM Products;
        `;

        const [products] = await db.query(query1);

        res.render('products', { products: products });
    } catch (error) {
        console.error('Error executing products query:', error);
        res.status(500).send('An error occurred while loading products.');
    }
});


app.get('/orders', async function (req, res) {
    try {
        const query1 = `
        SELECT Orders.orderID,
            Customers.firstName,
            Customers.lastName,
            Orders.orderDate,
            Orders.totalAmount,
            Orders.orderStatus
        FROM Orders
        INNER JOIN Customers
        ON Orders.customerID = Customers.customerID`;
        
        const [orders] = await db.query(query1);
        res.render('orders', { orders: orders });
        
    } catch (error) {
        console.error('Error executing orders query:', error);
        res.status(500).send('An error occurred while loading orders.');
    }
});


app.get('/orderitems', async function (req, res) {
    try {
    const query1 = `
        SELECT OrderItems.orderItemID,
            Orders.orderID,
            Customers.firstName,
            Customers.lastName,
            Products.productName,
            OrderItems.quantity
        FROM OrderItems
        INNER JOIN Orders ON OrderItems.orderID = Orders.orderID
        INNER JOIN Customers ON Orders.customerID = Customers.customerID
        INNER JOIN Products ON OrderItems.productID = Products.productID;
`;
        const [orderitems] = await db.query(query1);

        res.render('orderitems', {orderitems: orderitems });
        
    } catch (error) {
        console.error('Error executing orderitems query:', error);
        res.status(500).send('An error occurred while loading orders.');
    }
});


app.get('/supplierproducts', async function (req, res) {
    try {
        const query1 = `
        SELECT SupplierProducts.supplierProductID,
            Suppliers.supplierName,
            Products.productName
        FROM SupplierProducts
        INNER JOIN Suppliers ON SupplierProducts.supplierID = Suppliers.supplierID
        INNER JOIN Products ON SupplierProducts.productID = Products.productID;
`;
        const [supplierproducts] = await db.query(query1);
        res.render('supplierproducts', {supplierproducts: supplierproducts });
        
    } catch (error) {
        console.error('Error executing supplierproducts query:', error);
        res.status(500).send('An error occurred while loading orders.');
    }
});

// ########################################
// ########## LISTENER

app.listen(PORT, function () {
    console.log(
        'Express started on http://localhost:' +
            PORT +
            '; press Ctrl-C to terminate.'
    );
});
