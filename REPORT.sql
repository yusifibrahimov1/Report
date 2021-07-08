-- TABLES --

USE Northwind;
go
SELECT *
FROM Categories;
go
SELECT *
FROM Customers;
go
SELECT *
FROM [Order Details];
go
SELECT *
FROM Orders;
go
SELECT *
FROM Products;
go

-- REMAKE --

SELECT OrderDate
FROM Orders;
go
SELECT YEAR(OrderDate),MONTH(OrderDate),DAY(OrderDate)
FROM Orders;
go
SELECT CONCAT(YEAR(OrderDate),'-',MONTH(OrderDate),'-',DAY(OrderDate))
FROM Orders
go
SELECT CONCAT(YEAR(OrderDate),'-',MONTH(OrderDate),'-',DAY(OrderDate))
FROM Orders
WHERE LEN(MONTH(OrderDate))=1;
go

-- JOIN --

SELECT CU.ContactName AS Customer,P.ProductID AS [Product ID],P.ProductName AS Product,
	   CT.CategoryName AS Category,P.UnitPrice AS Price,OD.Quantity AS Quantity,
	   O.OrderID AS [Order ID],
	   CONCAT(YEAR(O.OrderDate),'-',MONTH(O.OrderDate),'-',DAY(O.OrderDate)) AS [Order Date],
	   CONCAT(O.ShipCountry,' / ',O.ShipCountry) AS [Order Region]
FROM Categories AS CT
INNER JOIN Products AS P
ON CT.CategoryID=P.CategoryID
INNER JOIN [Order Details] AS OD
ON OD.ProductID=P.ProductID
INNER JOIN Orders AS O
ON O.OrderID=OD.OrderID
INNER JOIN Customers AS CU
ON CU.CustomerID=O.CustomerID
ORDER BY CU.ContactName,P.ProductID,O.OrderID;
go

-- VIEW --

CREATE VIEW [Order Informations] (Customer,[Product ID],[Product Name],Category,Price,Quantity,[Order ID],[Order Date],[Order Region])
AS
SELECT CU.ContactName AS Customer,P.ProductID AS [Product ID],P.ProductName AS Product,
	   CT.CategoryName AS Category,P.UnitPrice AS Price,OD.Quantity AS Quantity,
	   O.OrderID AS [Order ID],
	   CONCAT(YEAR(O.OrderDate),'-',MONTH(O.OrderDate),'-',DAY(O.OrderDate)) AS [Order Date],
	   CONCAT(O.ShipCity,' / ',O.ShipCountry) AS [Order Region]
FROM Categories AS CT
INNER JOIN Products AS P
ON CT.CategoryID=P.CategoryID
INNER JOIN [Order Details] AS OD
ON OD.ProductID=P.ProductID
INNER JOIN Orders AS O
ON O.OrderID=OD.OrderID
INNER JOIN Customers AS CU
ON CU.CustomerID=O.CustomerID;
go

ALTER VIEW [Order Informations] (Customer,[Product ID],[Product Name],Category,Price,Quantity,[Order ID],
		   [Order Date],[Order Region])
AS
SELECT CU.ContactName AS Customer,P.ProductID AS [Product ID],P.ProductName AS Product,
	   CT.CategoryName AS Category,P.UnitPrice AS Price,OD.Quantity AS Quantity,
	   O.OrderID AS [Order ID],
	   LEFT(O.OrderDate,11) AS [Order Date],
	   CONCAT(O.ShipCity,' / ',O.ShipCountry) AS [Order Region]
FROM Categories AS CT
INNER JOIN Products AS P
ON CT.CategoryID=P.CategoryID
INNER JOIN [Order Details] AS OD
ON OD.ProductID=P.ProductID
INNER JOIN Orders AS O
ON O.OrderID=OD.OrderID
INNER JOIN Customers AS CU
ON CU.CustomerID=O.CustomerID;
go

-- SELECT --

SELECT *
FROM [Order Informations];