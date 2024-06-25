
CREATE DATABASE Analysis;

USE Assignment1;
---DROP TABLE Customers;

--- Table 1: Sample Data for Customers Table
---DROP TABLE Customers;
CREATE TABLE Customers(
  CustomerID	Int				NOT NULL,
  FirstName		Varchar(35)		NOT NULL,
  LastName		Varchar(35)		NOT NULL,
  Email			Varchar(35)		NOT NULL UNIQUE,
  PhoneNumber   Varchar(35)		DEFAULT NULL
);

INSERT INTO Customers(CustomerID,FirstName,LastName,Email,PhoneNumber) VALUES
(1,'John', 'Doe', 'john.doe@example.com', '123-456-7890'),
(2 ,'Jane', 'Smith', 'jane.smith@example.com', '987-654-3210'),
(3 ,'Bob', 'Johnson', 'bob.j@example.com', '555-123-4567'),
(4 ,'Alice', 'White', 'alice.white@example.com', '333-987-6543'),
(5,'Chris', 'Davis', 'chris.d@example.com', '111-222-3333'),
(6 ,'Emma', 'Wilson', 'emma.w@example.com', '444-555-6666'),
(7 ,'Michael', 'Turner', 'michael.t@example.com', '777-888-9999'),
(8 ,'Olivia', 'Brown', 'olivia.b@example.com', '666-555-4444'),
(9 ,'David', 'Miller', 'david.m@example.com', '999-000-1111'),
(10 ,'Sophia', 'Taylor', 'sophia.t@example.com', '222-333-4444'),
(11 ,'Ethan', 'Harris', 'ethan.h@example.com', '555-444-3333'),
(12 ,'Ava', 'Moore', 'ava.m@example.com', '123-789-4561'),
(13 ,'Liam', 'Robinson', 'liam.r@example.com', '456-789-1230'),
(14 ,'Mia', 'Carter', 'mia.c@example.com', '789-456-1230'),
(15 ,'Noah', 'Adams', 'noah.a@example.com', '987-654-3210')
;
---DROP TABLE Product;
--- Table 2: Product Table

CREATE TABLE Product(
 ProductID			Int					NOT NULL,
 ProductName		Varchar(35)			NOT NULL UNIQUE,
 Category			Varchar(35)			NOT NULL,
 Price				Float				NOT NULL DEFAULT 0.00,
 CustomerID			Int					NOT NULL 
);

INSERT INTO Product (ProductID,ProductName,Category,Price,CustomerID) VALUES
(1 ,'Laptop', 'Electronics', 899.99, 8),
(2 ,'Headphones', 'Electronics', 79.99, 11),
(3 ,'Smartphone', 'Electronics', 699.99, 4),
(4 ,'Coffee Maker', 'Appliances', 49.99, 6),
(5 ,'Backpack', 'Fashion', 29.99, 13),
(6 ,'Desk Chair', 'Furniture', 149.99, 9),
(7 ,'Fitness Tracker', 'Health', 89.99, 3),
(8 ,'Blender', 'Appliances', 39.99, 10),
(9 ,'Running Shoes', 'Fashion', 59.99, 14),
(10 ,'Office Desk', 'Furniture', 199.99, 1),
(11 ,'Wireless Mouse', 'Electronics', 19.99, 7),
(12 ,'Yoga Mat', 'Health', 24.99, 5),
(13 ,'Sunglasses', 'Fashion', 34.99, 12),
(14 ,'Portable Speaker', 'Electronics', 59.99, 2),
(15 ,'Toaster Oven', 'Appliances', 69.99, 15);

---Table 3: Sample Data for Orders Table
---DROP TABLE Orders;
CREATE TABLE Orders(
OrderID			Int			NOT NULL,
CustomerID		Int			NOT NULL		UNIQUE,
OrderDate		Date		NOT NULL,
TotalAmount		Float		NOT NULL		DEFAULT 0.00,
TotalOrders		Int			NOT NULL		DEFAULT 0
);

INSERT INTO Orders (OrderID	,CustomerID,OrderDate,TotalAmount,TotalOrders) VALUES
(1 ,10 , '2023-05-12', 979.98, 3),
(2 ,5 ,'2023-08-03', 159.98, 2),
(3 ,12 ,'2022-11-25', 349.95, 1),
(4, 7 ,'2023-02-17', 79.99, 4),
(5 ,2 ,'2022-09-08', 179.97, 2),
(6 ,6 ,'2024-01-21', 399.96, 1),
(7 ,14 ,'2022-07-14', 249.99, 3),
(8 ,1 ,'2024-02-09', 129.98, 1),
(9 ,9 ,'2022-06-30', 59.99, 2),
(10 ,13 ,'2023-12-04', 239.97, 1),
(11 ,8 ,'2022-10-19', 149.95, 3),
(12 ,4 ,'2024-03-08', 54.98, 2),
(13 ,15 ,'2023-04-02', 134.97, 1),
(14 ,3 ,'2023-07-17', 189.96, 3),
(15 ,11 ,'2024-04-30', 299.94, 2)
;

SELECT * FROM Customers;
SELECT * FROM Product;
SELECT * FROM Orders;

--- Adding PRIMARY KEY Constraint to CustomerID column in Customer table
ALTER TABLE Customers
ADD CONSTRAINT PK_Customer_CustomerID PRIMARY KEY(CustomerID);

--- Adding PRIMARY KEY Constarint to ProductID column in the Product table
ALTER TABLE Product
ADD CONSTRAINT PK_Product_ProductID PRIMARY KEY(ProductID);

---Adding PRIMARY KEY Constraint to the OrderID	column in the Orders Table
ALTER TABLE Orders
ADD CONSTRAINT PK_Orders_OrderID	PRIMARY KEY(OrderID);


---Adding FOREIGN KEY Constraint for CustomerID in Product Table
ALTER TABLE Product
ADD CONSTRAINT FK_Product_CustomerID 
FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID);

---Adding FOREIGN KEY Constarint for CustomerID in Orders Table
ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_CustomerID
FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID);

---Q4) retrieve the product names and their prices for all products in the "Electronics" category
SELECT ProductName, Price 
FROM Product
WHERE Category = 'Electronics';

---Q5) find the total number of orders placed by each customer. Include customer names and the corresponding order counts
SELECT c.FirstName, c.LastName, o.TotalOrders
FROM Customers c, Orders o
WHERE c.CustomerID = o.CustomerID
ORDER BY o.TotalOrders ASC;

---Q6) Create an SQL query to identify orders where the total amount exceeds $200.
SELECT o.OrderID, c.CustomerID, o.OrderDate, o.TotalAmount, o.TotalOrders
FROM Orders o , customers c
WHERE o.CustomerID = c.CustomerID and o.TotalAmount > 200.00;

---Q7) Write an SQL query to determine the top 5 customers who have spent the most in total across all orders. Include customer names and the corresponding total amount spent.
SELECT TOP 5 c.FirstName, c.LastName, o.TotalAmount AS TotalSpent
FROM Customers c , Orders o
WHERE c.CustomerID = o.CustomerID
ORDER BY TotalSpent DESC;

---8) Write an SQL query to find customers who have not placed orders for products in the "Fashion" category
SELECT c.FirstName, c.LastName
FROM Customers c, Product p
WHERE c.CustomerID = p.CustomerID 
AND Category NOT IN ('Fashion');

--9)Write an SQL query to retrieve the top 3 customers who have placed the highest number of orders.
SELECT TOP 3 c.FirstName, c.LastName, o.TotalOrders
FROM Customers c, Orders o
WHERE c.CustomerID = o.CustomerID
ORDER BY o.TotalOrders DESC;

---10)retrieve orders along with product categories.
---Include order ID, product name, category, quantity, and sort the result by
---category in alphabetical order, then by order ID in ascending order
SELECT o.OrderID, p.ProductName, p.Category
FROM Orders o, Product p
WHERE o.CustomerID = p.CustomerID
ORDER BY p.Category ASC , o.OrderID ASC;
