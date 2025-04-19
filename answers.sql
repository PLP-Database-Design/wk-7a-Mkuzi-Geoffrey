
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(255),
    Product VARCHAR(255)
);

INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
SELECT
    OrderID,
    CustomerName,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n), ',', -1)) AS Product
FROM
    ProductDetail
CROSS JOIN
    (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3) AS numbers
WHERE
    LENGTH(Products) - LENGTH(REPLACE(Products, ',', '')) >= numbers.n - 1;

SELECT * FROM ProductDetail_1NF;




CREATE TABLE Customers2NF (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(255)
);


INSERT INTO Customers2NF (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;


CREATE TABLE OrderItems2NF (
    OrderID INT,
    Product VARCHAR(255),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Customers2NF(OrderID)
);


INSERT INTO OrderItems2NF (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;

SELECT * FROM Customers2NF;
SELECT * FROM OrderItems2NF;