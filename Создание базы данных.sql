CREATE DATABASE Store
COLLATE Cyrillic_General_CI_AS;

USE Store;

CREATE TABLE Customer (
	CustomerID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	FirstName nvarchar(50) NOT NULL,
	MiddleName nvarchar(50),
	LastName nvarchar(50) NOT NULL,
	Gender nchar(1) NOT NULL,
	Address nvarchar(100) NOT NULL,
	City nvarchar(40) NOT NULL,
	CHECK (Gender = 'М' OR Gender = 'Ж')
);

CREATE TABLE Product (
	ProductID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Name varchar(100) NOT NULL,
	Price money NOT NULL,
	MesurementType nvarchar(10) NOT NULL
);

CREATE TABLE OrderHeader (
	OrderID int IDENTITY (1,1) NOT NULL PRIMARY KEY,
	CustomerID int FOREIGN KEY REFERENCES Customer(CustomerID),
	OrderDate date NOT NULL
);

CREATE TABLE OrderDetail (
	OrderDetailID int IDENTITY (1,1) PRIMARY KEY,
	OrderID int FOREIGN KEY REFERENCES OrderHeader(OrderID),
	ProductID int FOREIGN KEY REFERENCES Product(ProductID),
	OrderQty smallint NOT NULL,
	Price money NOT NULL,
	TotalCost AS (OrderQty * Price) PERSISTED
);
