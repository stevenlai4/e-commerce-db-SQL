USE master
GO

-- Create database
IF NOT EXISTS (
	SELECT name
	FROM sys.databases
	WHERE name = 'Lai_ChaoChun_SSD_Ecommerce'
)
BEGIN
CREATE DATABASE Lai_ChaoChun_SSD_Ecommerce
END
GO

-- Use Lai_ChaoChun_SSD_Ecommerce Database
USE Lai_ChaoChun_SSD_Ecommerce
GO

-- Drop Tables
IF OBJECT_ID('dbo.Returns', 'u') IS NOT NULL
DROP TABLE Returns
GO

IF OBJECT_ID('dbo.SaleProduct', 'u') IS NOT NULL
DROP TABLE SaleProduct
GO

IF OBJECT_ID('dbo.Sale', 'u') IS NOT NULL
DROP TABLE Sale
GO

IF OBJECT_ID('dbo.Address', 'u') IS NOT NULL
DROP TABLE Address
GO

IF OBJECT_ID('dbo.Customer', 'u') IS NOT NULL
DROP TABLE Customer
GO

IF OBJECT_ID('dbo.ProductSize', 'u') IS NOT NULL
DROP TABLE ProductSize
GO

IF OBJECT_ID('dbo.Size', 'u') IS NOT NULL
DROP TABLE Size
GO

IF OBJECT_ID('dbo.CategoryProduct', 'u') IS NOT NULL
DROP TABLE CategoryProduct
GO

IF OBJECT_ID('dbo.Category', 'u') IS NOT NULL
DROP TABLE Category
GO

IF OBJECT_ID('dbo.ProductImage', 'u') IS NOT NULL
DROP TABLE ProductImage
GO

IF OBJECT_ID('dbo.Product', 'u') IS NOT NULL
DROP TABLE Product
GO

-- Create Tables
CREATE TABLE Customer (
	CustomerId INT IDENTITY PRIMARY KEY,
	FirstName VARCHAR(20),
	LastName VARCHAR(20)
);

CREATE TABLE Address (
	AddressId INT IDENTITY PRIMARY KEY,
	CustomerId INT NOT NULL,
	City VARCHAR(20) NOT NULL,
	StateProvinceCode INT NOT NULL,
	Country VARCHAR(20) NOT NULL,
	AddressLine1 VARCHAR(50) NOT NULL,
	ZipPostalCode VARCHAR(10) NOT NULL,
	isBilling BIT NOT NULL,
	isShipping BIT NOT NULL,
	FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId)
);

CREATE TABLE Sale (
	SaleId INT IDENTITY PRIMARY KEY,
	CustomerId INT NOT NULL,
	ShippingAddressId INT,
	BillingAddressId INT,
	BillingName VARCHAR(40),
	PaymentType VARCHAR(10),
	CreditCard VARCHAR(4),
	TranscationCode UNIQUEIDENTIFIER,
	Confirmation VARCHAR(30),
	Date DATE
	FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId),
	FOREIGN KEY (ShippingAddressId) REFERENCES Address(AddressId),
	FOREIGN KEY (BillingAddressId) REFERENCES Address(AddressId)
);

CREATE TABLE Size (
	SizeId INT IDENTITY PRIMARY KEY,
	Size VARCHAR(10) NOT NULL,
	Description VARCHAR(20)
);

CREATE TABLE Product (
	SKU VARCHAR(4) PRIMARY KEY,
	Title VARCHAR(100) NOT NULL,
	Price MONEY NOT NULL,
	Description VARCHAR(500)
);

CREATE TABLE ProductImage (
	ImageId VARCHAR(500) PRIMARY KEY,
	SKU VARCHAR(4) NOT NULL,
	ImageOrder INT NOT NULL
	FOREIGN KEY (SKU) REFERENCES Product(SKU)
);

CREATE TABLE ProductSize(
	SKU VARCHAR(4) NOT NULL,
	SizeId INT NOT NULL,
	PRIMARY KEY (SKU, SizeId),
	FOREIGN KEY (SKU) REFERENCES Product(SKU),
	FOREIGN KEY (SizeId) REFERENCES Size(SizeId)
);

CREATE TABLE SaleProduct(
	SaleId INT NOT NULL,
	SKU VARCHAR(4) NOT NULL,
	SizeId INT,
	Price MONEY,
	Quantity INT,
	UNIQUE(SaleId, SKU, SizeId),
	FOREIGN KEY (SaleId) REFERENCES Sale(SaleId),
	FOREIGN KEY (SKU) REFERENCES Product(SKU),
	FOREIGN KEY (SizeId) REFERENCES Size(SizeId)
);

CREATE TABLE Returns(
	SaleId INT NOT NULL,
	SKU VARCHAR(4) NOT NULL,
	SizeId INT,
	Date DATE,
	TransactionCode UNIQUEIDENTIFIER,
	UNIQUE(SaleId, SKU, SizeId),
	FOREIGN KEY (SaleId, SKU, SizeId) REFERENCES SaleProduct(SaleId, SKU, SizeId)
);

CREATE TABLE Category(
	CategoryId VARCHAR(50) PRIMARY KEY,
	Description VARCHAR(200)
);

CREATE TABLE CategoryProduct(
	SKU VARCHAR(4) NOT NULL,
	CategoryId VARCHAR(50) NOT NULL
	PRIMARY KEY(SKU, CategoryId),
	FOREIGN KEY (SKU) REFERENCES Product(SKU),
	FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId)
);

