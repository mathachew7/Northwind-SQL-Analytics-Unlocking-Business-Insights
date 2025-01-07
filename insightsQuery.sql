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


