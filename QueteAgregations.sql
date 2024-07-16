USE master

--Create database if not exists
IF NOT (EXISTS (SELECT name FROM sys.databases 
WHERE ('[' + name + ']' = 'ProductDb' 
OR name = 'ProductDb')))
BEGIN    
    CREATE DATABASE ProductDb;
END

--Use the newly created database
USE ProductDb

--Drop table Product if already exists
IF OBJECT_ID('Product', 'U') IS NOT NULL 
BEGIN
    DROP TABLE Product;
END

--Create table Categorie
CREATE TABLE Categorie
(
    CategorieId INT PRIMARY KEY IDENTITY(1,1),
    CategorieName VARCHAR(128)
)

--Create table Product
CREATE TABLE Product 
(
    ProductId INT PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(128), 
    Prix DECIMAL(8,2),
    CategorieId INT NOT NULL
    CONSTRAINT FK_Categorie FOREIGN KEY (CategorieId)
    REFERENCES Categorie (CategorieId) 
)

--Create table Order
CREATE TABLE ACHAT
(
    AchatId INT PRIMARY KEY IDENTITY(1,1),
    ProductId INT NOT NULL
    CONSTRAINT FK_Product FOREIGN KEY (ProductId)
    REFERENCES Product(ProductId),
    DateDAchat DATETIME 
)

INSERT INTO Categorie (CategorieName) VALUES ('Categorie1');
INSERT INTO Categorie (CategorieName) VALUES ('Categorie2');
INSERT INTO Categorie (CategorieName) VALUES ('Categorie3');

INSERT INTO Product (ProductName, Prix, CategorieId) VALUES ('Product1', 45.78, 1);
INSERT INTO Product (ProductName, Prix, CategorieId) VALUES ('Product2', 02.00, 1);
INSERT INTO Product (ProductName, Prix, CategorieId) VALUES ('Product3', 90.33, 1);
INSERT INTO Product (ProductName, Prix, CategorieId) VALUES ('Product4', 12.12, 2);
INSERT INTO Product (ProductName, Prix, CategorieId) VALUES ('Product5', 41.00, 2);
INSERT INTO Product (ProductName, Prix, CategorieId) VALUES ('Product6', 120.00, 2);
INSERT INTO Product (ProductName, Prix, CategorieId) VALUES ('Product7', 29.99, 3);
INSERT INTO Product (ProductName, Prix, CategorieId) VALUES ('Product8', 67.00, 3);
INSERT INTO Product (ProductName, Prix, CategorieId) VALUES ('Product9', 45.45, 3);

INSERT INTO ACHAT (ProductId, DateDAchat) VALUES (1, '2024-12-03');
INSERT INTO ACHAT (ProductId, DateDAchat) VALUES (2, '2012-03-12');
INSERT INTO ACHAT (ProductId, DateDAchat) VALUES (3, '1994-09-09');
INSERT INTO ACHAT (ProductId, DateDAchat) VALUES (4, '2024-10-18');
INSERT INTO ACHAT (ProductId, DateDAchat) VALUES (5, '2023-12-03');
INSERT INTO ACHAT (ProductId, DateDAchat) VALUES (6, '2024-11-03');
INSERT INTO ACHAT (ProductId, DateDAchat) VALUES (7, '1991-03-23');
INSERT INTO ACHAT (ProductId, DateDAchat) VALUES (8, '2024-07-03');
INSERT INTO ACHAT (ProductId, DateDAchat) VALUES (9, '2024-07-03');
INSERT INTO ACHAT (ProductId, DateDAchat) VALUES (1, '2024-09-03');
INSERT INTO ACHAT (ProductId, DateDAchat) VALUES (2, '2024-01-03');
INSERT INTO ACHAT (ProductId, DateDAchat) VALUES (3, '2024-02-03');
INSERT INTO ACHAT (ProductId, DateDAchat) VALUES (4, '2024-11-03');
INSERT INTO ACHAT (ProductId, DateDAchat) VALUES (5, '2024-06-03');
INSERT INTO ACHAT (ProductId, DateDAchat) VALUES (6, '2024-05-03');
INSERT INTO ACHAT (ProductId, DateDAchat) VALUES (7, '2024-12-03');
INSERT INTO ACHAT (ProductId, DateDAchat) VALUES (8, '2024-04-03');
INSERT INTO ACHAT (ProductId, DateDAchat) VALUES (9, '1999-02-17');


SELECT 
C.CategorieName,
Count(A.AchatId) AS 'Nombre d''Achat'
FROM
Product P 
JOIN Categorie C ON P.CategorieId = C.CategorieId
JOIN Achat A ON P.ProductId = A.AchatId
GROUP BY C.CategorieName

SELECT 
C.CategorieName,
SUM(P.Prix) AS 'Somme de Prix'
FROM
Product P 
JOIN Categorie C ON P.CategorieId = C.CategorieId
GROUP BY C.CategorieName