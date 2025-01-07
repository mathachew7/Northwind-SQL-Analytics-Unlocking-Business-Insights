-- Let's Explore the dataset 


-- View table structures
DESCRIBE Categories;
DESCRIBE Products;
DESCRIBE Orders;
DESCRIBE OrderDetails;


-- Preview first 5 Data 
SELECT * FROM Categories LIMIT 5;
SELECT * FROM Products LIMIT 5;
SELECT * FROM Orders LIMIT 5;


-- Counting Records in each table 
SELECT 'Categories' AS TableName, COUNT(*) AS RecordCount FROM Categories
UNION ALL
SELECT 'Products', COUNT(*) FROM Products
UNION ALL
SELECT 'Orders', COUNT(*) FROM Orders
UNION ALL
SELECT 'OrderDetails', COUNT(*) FROM OrderDetails;


-- Let’s dive deeper into analyzing the Northwind database. 

-- Top 5 Products generating the most revenue 
Select 
    p.ProductName, 
    SUM(od.Quantity * p.price) AS TotalRevenue
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductID
ORDER BY TotalRevenue DESC
LIMIT 5;

-- Revenue Trend Over Time 
SELECT 
    DATE_FORMAT(o.OrderDate, '%Y-%m') AS Month,
    SUM(od.Quantity * p.Price) AS TotalRevenue
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p on od.ProductID = p.ProductID
GROUP BY MONTH
ORDER BY MONTH;


-- Top Categories by Revenue 
SELECT
    c.CategoryName, 
    SUM(od.Quantity * p.Price) AS TotalRevenue
FROM OrderDetails as od 
JOIN Products p ON od.ProductID = p.ProductID
JOIN Categories c ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryID
ORDER BY TotalRevenue DESC;


-- Let's have some cusomter insights 

-- Top 5 Customers by Revenue 
SELECT 
    cu.CustomerName, 
    SUM(od.Quantity * p.Price) as TotalSpent
FROM Customers cu
JOIN Orders o ON cu.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY cu.CustomerID
ORDER BY TotalSpent DESC
LIMIT 5;

-- Customer Order Frequency 
SELECT 
    cu.CustomerName,
    COUNT(o.OrderID) AS OrderCount
FROM Customers cu
LEFT JOIN Orders o ON cu.CustomerID = o.CustomerID
GROUP BY cu.CustomerID
ORDER BY OrderCount DESC
LIMIT 5;

-- Average Order Value Per Customer
SELECT 
    cu.CustomerName,
    AVG(od.Quantity * p.Price) AS AvgOrderValue
FROM Customers cu
JOIN Orders o ON cu.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY cu.CustomerID
ORDER BY AvgOrderValue DESC
LIMIT 5;


-- Employee Performance 

-- Top Employees by Sales
SELECT 
    e.FirstName,
    e.LastName,
    SUM(od.Quantity * p.Price) AS TotalSales
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY e.EmployeeID
ORDER BY TotalSales DESC
LIMIT 5;

-- Average Order Size Handled by Employees
SELECT 
    e.FirstName,
    e.LastName,
    AVG(od.Quantity) AS AvgOrderSize
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY e.EmployeeID
ORDER BY AvgOrderSize DESC;




