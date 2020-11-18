USE master
GO

-- CREATE DATABASE
IF NOT EXISTS (
	SELECT name
	FROM sys.databases
	WHERE name = 'Lai_ChaoChun_SSD_Ecommerce'
)
BEGIN
CREATE DATABASE Lai_ChaoChun_SSD_Ecommerce
END
GO

-- USE Lai_ChaoChun_SSD_Ecommerce Database
USE Lai_ChaoChun_SSD_Ecommerce
GO

-- DROP Tables
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

-- CREATE Tables
CREATE TABLE Customer (
	CustomerId INT IDENTITY PRIMARY KEY,
	FirstName VARCHAR(20),
	LastName VARCHAR(20)
);

CREATE TABLE Address (
	AddressId INT IDENTITY PRIMARY KEY,
	CustomerId INT NOT NULL,
	City VARCHAR(20) NOT NULL,
	StateProvinceCode VARCHAR(10) NOT NULL,
	Country VARCHAR(20) NOT NULL,
	AddressLine1 VARCHAR(50) NOT NULL,
	ZipPostalCode VARCHAR(10) NOT NULL,
	isBilling BIT NOT NULL,
	isShipping BIT NOT NULL,
	FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId)
);

CREATE TABLE Sale (
	SaleId INT IDENTITY PRIMARY KEY,
	CustomerId INT,
	ShippingAddressId INT,
	BillingAddressId INT,
	BillingName VARCHAR(40),
	PaymentType VARCHAR(10),
	CreditCard VARCHAR(4),
	TranscationCode VARCHAR(50),
	Confirmation VARCHAR(30),
	Date DATE
	FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId),
	FOREIGN KEY (ShippingAddressId) REFERENCES Address(AddressId),
	FOREIGN KEY (BillingAddressId) REFERENCES Address(AddressId)
);

CREATE TABLE Size (
	SizeId INT IDENTITY PRIMARY KEY,
	Size VARCHAR(50) NOT NULL,
	Description VARCHAR(20)
);

CREATE TABLE Product (
	SKU VARCHAR(4) PRIMARY KEY,
	Title VARCHAR(100) NOT NULL,
	Price MONEY NOT NULL,
	Description VARCHAR(2000)
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
	TranscationCode VARCHAR(50),
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


-- INSERT Statments
BEGIN --INSERT Seed Data-------------------------------------------------------------------
INSERT INTO Customer(FirstName,LastName) VALUES ('john','doe');
INSERT INTO Customer(FirstName,LastName) VALUES ('david','morrison');
INSERT INTO Customer(FirstName,LastName) VALUES ('kevin','ryan');
INSERT INTO Customer(FirstName,LastName) VALUES ('don','romer');
INSERT INTO Customer(FirstName,LastName) VALUES ('derek','powell');
INSERT INTO Customer(FirstName,LastName) VALUES ('david','russell');
INSERT INTO Customer(FirstName,LastName) VALUES ('miriam','snyder');
INSERT INTO Customer(FirstName,LastName) VALUES ('william','hopkins');
INSERT INTO Customer(FirstName,LastName) VALUES ('kate','hale');
INSERT INTO Customer(FirstName,LastName) VALUES ('jimmie','klein');

INSERT INTO Address (CustomerId, City, StateProvinceCode, Country, AddressLine1, ZipPostalCode, isBilling, isShipping) VALUES (1,'kilcoole','IE-L','Ireland','7682 new road','12926-3874',1,1);
INSERT INTO Address (CustomerId, City, StateProvinceCode, Country, AddressLine1, ZipPostalCode, isBilling, isShipping) VALUES (1,'kilcoole','IE-L','Ireland','7267 Lovers Ln','12926-3874',1,1);
INSERT INTO Address (CustomerId, City, StateProvinceCode, Country, AddressLine1, ZipPostalCode, isBilling, isShipping) VALUES (1,'Cullman','AL','USA','86 Frances Ct','29567-1452',0,1);
INSERT INTO Address (CustomerId, City, StateProvinceCode, Country, AddressLine1, ZipPostalCode, isBilling, isShipping) VALUES (2,'San Antonio','TX','USA','6454 Hunters Creek Dr','98234-1734',1,0);
INSERT INTO Address (CustomerId, City, StateProvinceCode, Country, AddressLine1, ZipPostalCode, isBilling, isShipping) VALUES (2,'san Antonio','TX','USA','245 adams St','80796-1234',0,1);
INSERT INTO Address (CustomerId, City, StateProvinceCode, Country, AddressLine1, ZipPostalCode, isBilling, isShipping) VALUES (3,'el paso','TX','USA','124 prospect st','12346-0456',1,0);
INSERT INTO Address (CustomerId, City, StateProvinceCode, Country, AddressLine1, ZipPostalCode, isBilling, isShipping) VALUES (4,'mesa','CA','USA','1342 vally view ln','96378-0245',0,1);
INSERT INTO Address (CustomerId, City, StateProvinceCode, Country, AddressLine1, ZipPostalCode, isBilling, isShipping) VALUES (5,'miami','FL','USA','345 avondale ave','96378-0245',1,1);
INSERT INTO Address (CustomerId, City, StateProvinceCode, Country, AddressLine1, ZipPostalCode, isBilling, isShipping) VALUES (6,'fort wayne','IN','USA','526 oak lawn ave','10256-4532',1,1);
INSERT INTO Address (CustomerId, City, StateProvinceCode, Country, AddressLine1, ZipPostalCode, isBilling, isShipping) VALUES (7,'fresno','CA','USA','1342 saddle st','96378-0245',1,1);

INSERT INTO Product(SKU,title,price,description) VALUES ('1247','Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops',109.95,'Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday');
INSERT INTO Product(SKU,title,price,description) VALUES ('2247','Mens Casual Premium Slim Fit T-Shirts',22.3,'Slim-fitting style, contrast raglan long sleeve, three-button henley placket, light weight & soft fabric for breathable and comfortable wearing. And Solid stitched shirts with round neck made for durability and a great fit for casual fashion wear and diehard baseball fans. The Henley style round neckline includes a three-button placket.');
INSERT INTO Product(SKU,title,price,description) VALUES ('3247','Mens Cotton Jacket',55.99,'great outerwear jackets for Spring/Autumn/Winter, suitable for many occasions, such as working, hiking, camping, mountain/rock climbing, cycling, traveling or other outdoors. Good gift choice for you or your family member. A warm hearted love to Father, husband or son in this thanksgiving or Christmas Day.');
INSERT INTO Product(SKU,title,price,description) VALUES ('4247','Mens Casual Slim Fit',15.99,'The color could be slightly different between on the screen and in practice. / Please note that body builds vary by person, therefore, detailed size information should be reviewed below on the product description.');
INSERT INTO Product(SKU,title,price,description) VALUES ('5247','John Hardy Women''s Legends Naga Gold & Silver Dragon Station Chain Bracelet',695,'From our Legends Collection, the Naga was inspired by the mythical water dragon that protects the ocean''s pearl. Wear facing inward to be bestowed with love and abundance, or outward for protection.');
INSERT INTO Product(SKU,title,price,description) VALUES ('6247','Solid Gold Petite Micropave',168,'Satisfaction Guaranteed. Return or exchange any order within 30 days.Designed and sold by Hafeez Center in the United States. Satisfaction Guaranteed. Return or exchange any order within 30 days.');
INSERT INTO Product(SKU,title,price,description) VALUES ('7247','White Gold Plated Princess',9.99,'Classic Created Wedding Engagement Solitaire Diamond Promise Ring for Her. Gifts to spoil your love more for Engagement, Wedding, Anniversary, Valentine''s Day...');
INSERT INTO Product(SKU,title,price,description) VALUES ('8247','Pierced Owl Rose Gold Plated Stainless Steel Double',10.99,'Rose Gold Plated Double Flared Tunnel Plug Earrings. Made of 316L Stainless Steel');
INSERT INTO Product(SKU,title,price,description) VALUES ('9247','WD 2TB Elements Portable External Hard Drive - USB 3.0',64,'USB 3.0 and USB 2.0 Compatibility Fast data transfers Improve PC Performance High Capacity; Compatibility Formatted NTFS for Windows 10, Windows 8.1, Windows 7; Reformatting may be required for other operating systems; Compatibility may vary depending on user�s hardware configuration and operating system');
INSERT INTO Product(SKU,title,price,description) VALUES ('1099','SanDisk SSD PLUS 1TB Internal SSD - SATA III 6 Gb/s',109,'Easy upgrade for faster boot up, shutdown, application load and response (As compared to 5400 RPM SATA 2.5� hard drive; Based on published specifications and internal benchmarking tests using PCMark vantage scores) Boosts burst write performance, making it ideal for typical PC workloads The perfect balance of performance and reliability Read/write speeds of up to 535MB/s/450MB/s (Based on internal testing; Performance may vary depending upon drive capacity, host device, OS and application.)');
INSERT INTO Product(SKU,title,price,description) VALUES ('1199','Silicon Power 256GB SSD 3D NAND A55 SLC Cache Performance Boost SATA III 2.5',109,'3D NAND flash are applied to deliver high transfer speeds Remarkable transfer speeds that enable faster bootup and improved overall system performance. The advanced SLC Cache Technology allows performance boost and longer lifespan 7mm slim design suitable for Ultrabooks and Ultra-slim notebooks. Supports TRIM command, Garbage Collection technology, RAID, and ECC (Error Checking & Correction) to provide the optimized performance and enhanced reliability.');
INSERT INTO Product(SKU,title,price,description) VALUES ('1299','WD 4TB Gaming Drive Works with Playstation 4 Portable External Hard Drive',114,'Expand your PS4 gaming experience, Play anywhere Fast and easy, setup Sleek design with high capacity, 3-year manufacturer''s limited warranty');
INSERT INTO Product(SKU,title,price,description) VALUES ('1399','Acer SB220Q bi 21.5 inches Full HD (1920 x 1080) IPS Ultra-Thin',599,'21. 5 inches Full HD (1920 x 1080) widescreen IPS display And Radeon free Sync technology. No compatibility for VESA Mount Refresh Rate: 75Hz - Using HDMI port Zero-frame design | ultra-thin | 4ms response time | IPS panel Aspect ratio - 16: 9. Color Supported - 16. 7 million colors. Brightness - 250 nit Tilt angle -5 degree to 15 degree. Horizontal viewing angle-178 degree. Vertical viewing angle-178 degree 75 hertz');
INSERT INTO Product(SKU,title,price,description) VALUES ('1499','Samsung 49-Inch CHG90 144Hz Curved Gaming Monitor (LC49HG90DMNXZA) � Super Ultrawide Screen QLED',999.99,'49 INCH SUPER ULTRAWIDE 32:9 CURVED GAMING MONITOR with dual 27 inch screen side by side QUANTUM DOT (QLED) TECHNOLOGY, HDR support and factory calibration provides stunningly realistic and accurate color and contrast 144HZ HIGH REFRESH RATE and 1ms ultra fast response time work to eliminate motion blur, ghosting, and reduce input lag');
INSERT INTO Product(SKU,title,price,description) VALUES ('1599','BIYLACLESEN Women''s 3-in-1 Snowboard Jacket Winter Coats',56.99,'Note:The Jackets is US standard size, Please choose size as your usual wear Material: 100% Polyester; Detachable Liner Fabric: Warm Fleece. Detachable Functional Liner: Skin Friendly, Lightweigt and Warm.Stand Collar Liner jacket, keep you warm in cold weather. Zippered Pockets: 2 Zippered Hand Pockets, 2 Zippered Pockets on Chest (enough to keep cards or keys)and 1 Hidden Pocket Inside.Zippered Hand Pockets and Hidden Pocket keep your things secure. Humanized Design: Adjustable and Detachable Hood and Adjustable cuff to prevent the wind and water,for a comfortable fit. 3 in 1 Detachable Design provide more convenience, you can separate the coat and inner as needed, or wear it together. It is suitable for different season and help you adapt to different climates');
INSERT INTO Product(SKU,title,price,description) VALUES ('1699','Lock and Love Women''s Removable Hooded Faux Leather Moto Biker Jacket',29.95,'100% POLYURETHANE(shell) 100% POLYESTER(lining) 75% POLYESTER 25% COTTON (SWEATER), Faux leather material for style and comfort / 2 pockets of front, 2-For-One Hooded denim style faux leather jacket, Button detail on waist / Detail stitching at sides, HAND WASH ONLY / DO NOT BLEACH / LINE DRY / DO NOT IRON');
INSERT INTO Product(SKU,title,price,description) VALUES ('1799','Rain Jacket Women Windbreaker Striped Climbing Raincoats',39.99,'Lightweight perfet for trip or casual wear---Long sleeve with hooded, adjustable drawstring waist design. Button and zipper front closure raincoat, fully stripes Lined and The Raincoat has 2 side pockets are a good size to hold all kinds of things, it covers the hips, and the hood is generous but doesn''t overdo it.Attached Cotton Lined Hood with Adjustable Drawstrings give it a real styled look.');
INSERT INTO Product(SKU,title,price,description) VALUES ('1899','MBJ Women''s Solid Short Sleeve Boat Neck V',9.85,'95% RAYON 5% SPANDEX, Made in USA or Imported, Do Not Bleach, Lightweight fabric with great stretch for comfort, Ribbed on sleeves and neckline / Double stitching on bottom hem');
INSERT INTO Product(SKU,title,price,description) VALUES ('1999','Opna Women''s Short Sleeve Moisture',7.95,'100% Polyester, Machine wash, 100% cationic polyester interlock, Machine Wash & Pre Shrunk for a Great Fit, Lightweight, roomy and highly breathable with moisture wicking fabric which helps to keep moisture away, Soft Lightweight Fabric with comfortable V-neck collar and a slimmer fit, delivers a sleek, more feminine silhouette and Added Comfort');
INSERT INTO Product(SKU,title,price,description) VALUES ('2099','DANVOUY Womens T Shirt Casual Cotton Short',12.99,'95%Cotton,5%Spandex, Features: Casual, Short Sleeve, Letter Print,V-Neck,Fashion Tees, The fabric is soft and has some stretch., Occasion: Casual/Office/Beach/School/Home/Street. Season: Spring,Summer,Autumn,Winter.');

INSERT INTO Category VALUES ('mens clothing','Clothing designed for men.');
INSERT INTO Category VALUES ('womens clothing','Clothing designed for women.');
INSERT INTO Category VALUES ('childrens clothing','Clothing designed for children.');
INSERT INTO Category VALUES ('electronics','Electronic devices and accessories.');
INSERT INTO Category VALUES ('jewelry',NULL)

INSERT INTO CategoryProduct VALUES ('2247','mens clothing');
INSERT INTO CategoryProduct VALUES ('3247','mens clothing');
INSERT INTO CategoryProduct VALUES ('4247','mens clothing');
INSERT INTO CategoryProduct VALUES ('6247','womens clothing');
INSERT INTO CategoryProduct VALUES ('7247','womens clothing');
INSERT INTO CategoryProduct VALUES ('6247','jewelry');
INSERT INTO CategoryProduct VALUES ('7247','jewelry');
INSERT INTO CategoryProduct VALUES ('8247','jewelry');
INSERT INTO CategoryProduct VALUES ('9247','electronics');
INSERT INTO CategoryProduct VALUES ('1099','electronics');
INSERT INTO CategoryProduct VALUES ('1199','electronics');
INSERT INTO CategoryProduct VALUES ('1299','electronics');
INSERT INTO CategoryProduct VALUES ('1399','electronics');
INSERT INTO CategoryProduct VALUES ('1499','electronics');
INSERT INTO CategoryProduct VALUES ('1599','womens clothing');
INSERT INTO CategoryProduct VALUES ('1699','womens clothing');
INSERT INTO CategoryProduct VALUES ('1799','womens clothing');
INSERT INTO CategoryProduct VALUES ('1899','womens clothing');
INSERT INTO CategoryProduct VALUES ('1999','womens clothing');
INSERT INTO CategoryProduct VALUES ('2099','womens clothing');

INSERT INTO ProductImage VALUES ('https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg',	'2247', 1);
INSERT INTO ProductImage VALUES ('https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_.jpg','3247', 1)
INSERT INTO ProductImage VALUES ('https://fakestoreapi.com/img/71YXzeOuslL._AC_UY879_.jpg','4247', 1)
INSERT INTO ProductImage VALUES ('https://fakestoreapi.com/img/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg','6247', 1)
INSERT INTO ProductImage VALUES ('https://fakestoreapi.com/img/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg','7247', 1)
INSERT INTO ProductImage VALUES ('https://bnsec.bluenile.com/bluenile/is/image/bluenile/-diamond-tennis-bracelet-14k-white-gold-/58152_main?$phab_detailmain$','6247', 0)
INSERT INTO ProductImage VALUES ('https://images-na.ssl-images-amazon.com/images/I/61WEn1hW34L._AC_UL160_.jpg','7247', 0)
INSERT INTO ProductImage VALUES ('https://fakestoreapi.com/img/51UDEzMJVpL._AC_UL640_QL65_ML3_.jpg','8247', 1)
INSERT INTO ProductImage VALUES ('https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg','9247', 1)
INSERT INTO ProductImage VALUES ('https://fakestoreapi.com/img/61U7T1koQqL._AC_SX679_.jpg','1099', 1)
INSERT INTO ProductImage VALUES ('https://fakestoreapi.com/img/71kWymZ+c+L._AC_SX679_.jpg','1199', 1)
INSERT INTO ProductImage VALUES ('https://fakestoreapi.com/img/61mtL65D4cL._AC_SX679_.jpg','1299', 1)
INSERT INTO ProductImage VALUES ('https://fakestoreapi.com/img/81QpkIctqPL._AC_SX679_.jpg','1399', 1)
INSERT INTO ProductImage VALUES ('https://fakestoreapi.com/img/81Zt42ioCgL._AC_SX679_.jpg','1499', 1)
INSERT INTO ProductImage VALUES ('https://fakestoreapi.com/img/51Y5NI-I5jL._AC_UX679_.jpg','1599', 1)
INSERT INTO ProductImage VALUES ('https://fakestoreapi.com/img/81XH0e8fefL._AC_UY879_.jpg','1699', 1)
INSERT INTO ProductImage VALUES ('https://fakestoreapi.com/img/71HblAHs5xL._AC_UY879_-2.jpg','1799', 1)
INSERT INTO ProductImage VALUES ('https://fakestoreapi.com/img/71z3kpMAYsL._AC_UY879_.jpg','1899', 1)
INSERT INTO ProductImage VALUES ('https://fakestoreapi.com/img/51eg55uWmdL._AC_UX679_.jpg','1999', 1)
INSERT INTO ProductImage VALUES ('https://fakestoreapi.com/img/61pHAEJ4NML._AC_UX679_.jpg','2099', 1)

INSERT INTO Size VALUES ('Small', NULL);
INSERT INTO Size VALUES ('Medium', NULL);
INSERT INTO Size VALUES ('Large', NULL);
INSERT INTO Size VALUES ('Extra Large', NULL);
INSERT INTO Size VALUES ('24"', 'Waist');
INSERT INTO Size VALUES ('26"', 'Waist');
INSERT INTO Size VALUES ('28"', 'Waist');
INSERT INTO Size VALUES ('30"', 'Waist');
INSERT INTO Size VALUES ('32"', 'Waist');
INSERT INTO Size VALUES ('34"', 'Waist');
INSERT INTO Size VALUES ('36"', 'Waist');

INSERT INTO ProductSize VALUES ('2247',3);
INSERT INTO ProductSize VALUES ('3247',4);
INSERT INTO ProductSize VALUES ('4247',5);
INSERT INTO ProductSize VALUES ('6247',1);
INSERT INTO ProductSize VALUES ('7247',1);
INSERT INTO ProductSize VALUES ('6247',2);
INSERT INTO ProductSize VALUES ('7247',2);
INSERT INTO ProductSize VALUES ('8247',4);
INSERT INTO ProductSize VALUES ('1599',6);
INSERT INTO ProductSize VALUES ('1699',6);
INSERT INTO ProductSize VALUES ('1799',4);
INSERT INTO ProductSize VALUES ('1899',2);
INSERT INTO ProductSize VALUES ('1999',2);
INSERT INTO ProductSize VALUES ('2099',2);

INSERT INTO Sale VALUES (1,1,1,'test testerson', 'MC','4242', CAST(newID() AS VARCHAR(50)), 'Payment Succesful', GETDATE());
INSERT INTO Sale VALUES (1,2,3,'test testerson', 'MC','4242', CAST(newID() AS VARCHAR(50)), 'Payment Succesful', GETDATE());
INSERT INTO Sale VALUES (1,NULL,NULL, NULL, NULL,NULL, NULL, NULL, NULL);
INSERT INTO Sale VALUES (2,4,5,'david morrison', 'VISA','1234', CAST(newID() AS VARCHAR(50)), 'Payment Succesful', GETDATE());
INSERT INTO Sale VALUES (3,6,NULL,'Kevin Ryan', 'VISA','846', CAST(newID() AS VARCHAR(50)), 'Payment Succesful', GETDATE());
INSERT INTO Sale VALUES (3,NULL,NULL, NULL, NULL,NULL, NULL, NULL, NULL);

INSERT INTO SaleProduct VALUES (1,'1247',NULL,109.95,2)
INSERT INTO SaleProduct VALUES (1,'2247',3,22.30,1)
INSERT INTO SaleProduct VALUES (1,'6247',1,168.00, 1)
INSERT INTO SaleProduct VALUES (1,'6247',2,168.00, 1)
INSERT INTO SaleProduct VALUES (2,'7247',1,9.99, 3)
INSERT INTO SaleProduct VALUES (2,'7247',2,9.99, 1)
INSERT INTO SaleProduct VALUES (4,'1999',2,12.99, 3)
INSERT INTO SaleProduct VALUES (5,'1499',NULL,999.99, 1)
INSERT INTO SaleProduct VALUES (5,'1799',4,39.99, 1)
INSERT INTO SaleProduct VALUES (5,'1699',6,29.95, 1)
INSERT INTO SaleProduct VALUES (5,'1599',6,56.99, 1)

INSERT INTO Returns VALUES (5, '1499', NULL, GETDATE(), CAST(NEWID() AS VARCHAR(50)));
INSERT INTO Returns VALUES (1, '1247', NULL, GETDATE(), CAST(NEWID() AS VARCHAR(50)));
INSERT INTO Returns VALUES (1, '2247', 3, GETDATE(), CAST(NEWID() AS VARCHAR(50)));
END
GO


----------------------------- Question 5 ---------------------------------
DROP PROC IF EXISTS spAllCategoriesAndProducts
GO

CREATE PROC spAllCategoriesAndProducts AS
	-- a
	SELECT C.CategoryId AS [Category Name], COUNT(P.SKU) AS [Product Amount]
	FROM Category C
		 INNER JOIN CategoryProduct CP ON C.CategoryId = CP.CategoryId
		 INNER JOIN Product P ON P.SKU = CP.SKU
	GROUP BY C.CategoryId
	ORDER BY C.CategoryId

	-- b
	SELECT P.*, PI.ImageId
	FROM Product P
		 INNER JOIN ProductImage PI ON PI.SKU = P.SKU,
		 (SELECT SKU, MIN(ImageOrder) AS [ImageOrder]
		 FROM ProductImage
		 GROUP BY SKU) AS temp
	WHERE P.SKU = temp.SKU AND PI.ImageOrder = temp.ImageOrder
	ORDER BY P.SKU
GO


EXEC spAllCategoriesAndProducts;


----------------------------- Question 6 ---------------------------------
DROP FUNCTION IF EXISTS fnGetSectionProducts
GO

CREATE FUNCTION fnGetSectionProducts(@categoryName VARCHAR(50))
	RETURNS TABLE AS
	RETURN
		SELECT P.*, PI.ImageId
		FROM Category C
			 INNER JOIN CategoryProduct CP ON CP.CategoryId = C.CategoryId
			 INNER JOIN Product P ON P.SKU = CP.SKU
			 INNER JOIN ProductImage PI ON PI.SKU = P.SKU,
			 (SELECT SKU, MIN(ImageOrder) AS [ImageOrder]
			 FROM ProductImage
			 GROUP BY SKU) AS temp
		WHERE P.SKU = temp.SKU AND PI.ImageOrder = temp.ImageOrder AND C.CategoryId = @categoryName
GO

SELECT * FROM fnGetSectionProducts('womens clothing') ORDER BY SKU;


----------------------------- Question 7 ---------------------------------
DROP FUNCTION IF EXISTS fnGetProductsSearch
GO

CREATE FUNCTION fnGetProductsSearch(@search VARCHAR(100))
	RETURNS TABLE AS
	RETURN
		SELECT P.*, PI.ImageId
		FROM Category C
			 INNER JOIN CategoryProduct CP ON CP.CategoryId = C.CategoryId
			 INNER JOIN Product P ON P.SKU = CP.SKU
			 INNER JOIN ProductImage PI ON PI.SKU = P.SKU,
			 (SELECT SKU, MIN(ImageOrder) AS [ImageOrder]
			 FROM ProductImage
			 GROUP BY SKU) AS temp
		WHERE P.SKU = temp.SKU AND 
			  PI.ImageOrder = temp.ImageOrder AND 
			  (C.CategoryId LIKE '%' + @search + '%' OR P.Title LIKE '%' + @search + '%')
		GROUP BY P.SKU, P.Title, P.Price, P.Description, PI.ImageId
GO

SELECT * FROM fnGetProductsSearch('mens') ORDER BY SKU;


----------------------------- Question 8 ---------------------------------
DROP FUNCTION IF EXISTS fnGetProductDetail
GO

CREATE FUNCTION fnGetProductDetail(@sku VARCHAR(4))
	RETURNS TABLE
	RETURN
		SELECT P.SKU , 
			   P.Title , 
			   P.Price, 
			   P.Description AS [Product Description], 
			   PI.ImageId AS [Image URL]
		FROM Product P
			 INNER JOIN ProductImage PI ON PI.SKU = P.SKU
		WHERE P.SKU = @sku
GO

SELECT * FROM fnGetProductDetail('6247');


----------------------------- Question 9 ---------------------------------
DROP PROC IF EXISTS spAddToCart
GO

CREATE PROC spAddToCart(@sku VARCHAR(4), @quantity INT, @sizeId INT, @saleId INT, @customerId INT) AS
	
	IF  @saleId IS NULL OR @saleId NOT IN (SELECT SaleId FROM Sale)
	BEGIN
		INSERT INTO Sale VALUES (@customerId, NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE())

		SET @saleId = SCOPE_IDENTITY()
	END
	
	INSERT INTO SaleProduct 
	SELECT  @saleId, @sku, @sizeId, P.Price, @quantity
	FROM Product P
		 LEFT JOIN ProductSize PS ON PS.SKU = P.SKU
	WHERE P.SKU = @sku
GO

EXEC spAddToCart '1247', 3, 3, 7, 4


----------------------------- Question 10 ---------------------------------
DROP PROC IF EXISTS spChangePrice 
GO

CREATE PROC spChangePrice(@saleId INT) AS
	UPDATE SaleProduct
	SET Price = P.Price
	FROM Product P
		 INNER JOIN SaleProduct SP ON SP.SKU = P.SKU
	WHERE SP.SaleId = @saleId
GO

EXEC spChangePrice 4


----------------------------- Question 11 ---------------------------------
DROP PROC IF EXISTS spCustomerLogin
GO

CREATE PROC spCustomerLogin(@customerId INT, @saleId INT) AS
	-- 11.1
	IF @saleId IS NOT NULL
	BEGIN
		SELECT SP.*
		FROM Sale S
			 INNER JOIN SaleProduct SP ON SP.SaleId = S.SaleId
		WHERE S.SaleId = @saleId
	END
	ELSE
	BEGIN
		IF @customerId IN (SELECT CustomerId FROM Sale WHERE CustomerId = @customerId AND Confirmation IS NULL)
		BEGIN
			DECLARE @unpaidSaleId INT = (SELECT SaleId FROM Sale WHERE CustomerId = @customerId AND Confirmation IS NULL)

			EXEC spChangePrice @unpaidSaleId

			UPDATE Sale
			SET Date = GETDATE()
			WHERE SaleId = @unpaidSaleId

			SELECT SP.*
			FROM Sale S
				 INNER JOIN SaleProduct SP ON SP.SaleId = S.SaleId
			WHERE S.SaleId = @unpaidSaleId
		END
		ELSE
		BEGIN
			SELECT 'No Cart Items Found!' AS Message
		END
	END

	-- 11.2
	SELECT CASE 
			WHEN BillingAddressId IS NULL THEN 'No Billing Addresses Found!'
			ELSE CAST(BillingAddressId AS VARCHAR(10))
			END AS [Billing Address ID]
	FROM Sale
	WHERE CustomerId = @customerId

	-- 11.3
	SELECT CASE 
			WHEN ShippingAddressId IS NULL THEN 'No Shipping Addresses Found!'
			ELSE CAST(ShippingAddressId AS VARCHAR(10))
			END AS [Shipping Address ID]
	FROM Sale
	WHERE CustomerId = @customerId

	-- 11.4
	IF @customerId NOT IN (SELECT CustomerId FROM Sale WHERE CustomerId = @customerId)
	BEGIN
		SELECT 'No Purchases Found!'
	END
	ELSE
	BEGIN
		SELECT *
		FROM Sale
		WHERE CustomerId = @customerId
	END
GO

EXEC spCustomerLogin 5, NULL


----------------------------- Question 12 ---------------------------------
DROP FUNCTION IF EXISTS fnReturnItems
GO

CREATE FUNCTION fnReturnItems(@saleId INT)
	RETURNS TABLE
	RETURN
		SELECT SP.SaleId, SP.SKU, SP.SizeId, SP.Price, SP.Quantity, R.TranscationCode AS [Return Transaction Code], R.Date AS [Return Date]
		FROM SaleProduct SP
			 LEFT JOIN Returns R ON R.SaleId = SP.SaleId AND R.SKU = SP.SKU AND (R.SizeId = SP.SizeId OR (R.SizeId IS NULL AND SP.SizeId IS NULL))
		WHERE SP.SaleId = @saleId
GO

SELECT * FROM fnReturnItems(1)