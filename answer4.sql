answer.sql

-- ==================================================
-- WEEK 7 DATABASE ASSIGNMENT
-- TOPIC: DATABASE DESIGN AND NORMALIZATION
-- ==================================================

-- QUESTION 1: ACHIEVING FIRST NORMAL FORM (1NF)

-- Create a new table where each row contains
-- only one product per order.

CREATE TABLE ProductDetail_1NF (
    OrderID INT NOT NULL,
    CustomerName VARCHAR(100) NOT NULL,
    Product VARCHAR(100) NOT NULL,
    PRIMARY KEY (OrderID, Product)
);


-- Insert normalized records into the new table.

INSERT INTO ProductDetail_1NF
(OrderID, CustomerName, Product)
VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');


-- Display the normalized table.

SELECT * FROM ProductDetail_1NF;


-- ==================================================
-- QUESTION 2: ACHIEVING SECOND NORMAL FORM (2NF)
-- ==================================================

-- The partial dependency is:
-- OrderID determines CustomerName.
-- CustomerName does not depend on the entire
-- composite key (OrderID, Product).
--
-- To achieve 2NF, we separate order information
-- from product and quantity information.


-- STEP 1: Create the Orders table.

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL
);


-- STEP 2: Create the OrderItems table.

CREATE TABLE OrderItems (
    OrderID INT NOT NULL,
    Product VARCHAR(100) NOT NULL,
    Quantity INT NOT NULL,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID)
        REFERENCES Orders(OrderID)
);


-- STEP 3: Insert records into the Orders table.

INSERT INTO Orders
(OrderID, CustomerName)
VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');


-- STEP 4: Insert records into the OrderItems table.

INSERT INTO OrderItems
(OrderID, Product, Quantity)
VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);


-- STEP 5: Display records from Orders.

SELECT * FROM Orders;


-- STEP 6: Display records from OrderItems.

SELECT * FROM OrderItems;


-- STEP 7: Use INNER JOIN to display order information
-- together with products and quantities.

SELECT
    Orders.OrderID,
    Orders.CustomerName,
    OrderItems.Product,
    OrderItems.Quantity
FROM Orders
INNER JOIN OrderItems
ON Orders.OrderID = OrderItems.OrderID;


-- ==================================================
-- END OF WEEK 7 DATABASE ASSIGNMENT
-- ==================================================
