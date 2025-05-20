

IF OBJECT_ID('dbo.Products') IS NOT NULL DROP TABLE dbo.Products;
GO
CREATE TABLE dbo.Products (
    ProductID   INT             PRIMARY KEY,
    ProductName VARCHAR(50),    -- 6‑bandda UNIQUE bo‘ladi
    Price       DECIMAL(10,2)
);
GO


INSERT INTO dbo.Products (ProductID, ProductName, Price) VALUES
(1, 'Phone',  299.99),
(2, 'Laptop', 999.99),
(3, 'Tablet', 499.99);
GO


ALTER TABLE dbo.Products
ADD CONSTRAINT UQ_Products_ProductName UNIQUE (ProductName);
GO


-- Quyidagi so‘rov barcha mahsulotlarni ko‘rsatadi:
SELECT * FROM dbo.Products;
GO


ALTER TABLE dbo.Products
ADD CategoryID INT;   -- keyin Foreign Key bo‘ladi
GO


IF OBJECT_ID('dbo.Categories') IS NOT NULL DROP TABLE dbo.Categories;
GO
CREATE TABLE dbo.Categories (
    CategoryID   INT          PRIMARY KEY,
    CategoryName VARCHAR(50)  UNIQUE
);
GO


ALTER TABLE dbo.Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID)
REFERENCES dbo.Categories(CategoryID);
GO


ALTER TABLE dbo.Products
ADD CONSTRAINT CHK_Products_Price_Positive CHECK (Price > 0);
GO

ALTER TABLE dbo.Products
ADD Stock INT NOT NULL DEFAULT 0;
GO

SELECT ProductID, ProductName, ISNULL(Price, 0) AS Price
FROM   dbo.Products;
GO


IF OBJECT_ID('dbo.Customers') IS NOT NULL DROP TABLE dbo.Customers;
GO
CREATE TABLE dbo.Customers (
    CustomerID INT PRIMARY KEY,
    CustName   VARCHAR(50),
    Age        INT CHECK (Age >= 18)
);
GO

IF OBJECT_ID('dbo.IdentityTest') IS NOT NULL DROP TABLE dbo.IdentityTest;
GO
CREATE TABLE dbo.IdentityTest (
    ID  INT IDENTITY(100,10) PRIMARY KEY,
    Note VARCHAR(50)
);
GO

IF OBJECT_ID('dbo.OrderDetails') IS NOT NULL DROP TABLE dbo.OrderDetails;
GO
CREATE TABLE dbo.OrderDetails (
    OrderID   INT,
    ProductID INT,
    Quantity  INT,
    PRIMARY KEY (OrderID, ProductID)   -- kompozit kalit
);
GO


SELECT
    ISNULL(NULL, 5)          AS IsNullDemo,
    COALESCE(NULL, NULL, 7)  AS CoalesceDemo;
GO


IF OBJECT_ID('dbo.Employees') IS NOT NULL DROP TABLE dbo.Employees;
GO
CREATE TABLE dbo.Employees (
    EmpID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Email VARCHAR(100) UNIQUE
);
GO


IF OBJECT_ID('dbo.Orders') IS NOT NULL DROP TABLE dbo.Orders;
GO
CREATE TABLE dbo.Orders (
    OrderID    INT PRIMARY KEY,
    CustomerID INT,
    FOREIGN KEY (CustomerID)
        REFERENCES dbo.Customers(CustomerID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
GO
