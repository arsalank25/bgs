drop table CartContains,Shipment, Cart ,WishList,Review ,Payment ,Product ,TAX,Customer


CREATE TABLE Customer (
customerID 	int		IDENTITY(1,1)  PRIMARY KEY,
customerUserName VARCHAR(20) NOT NULL,
password 	VARCHAR(20) 	 NOT NULL,
firstName 	VARCHAR(50) 	 NOT NULL,
lastName 	VARCHAR(50) 	 NOT NULL,
email 		VARCHAR(30) 	 NOT NULL,
houseNo 	VARCHAR(20),
street		VARCHAR(20),
city 		VARCHAR(20),
province 	VARCHAR(20),
postalCode 	VARCHAR(10),
accessLevel SMALLINT 	 	 NOT NULL
);



CREATE TABLE TAX  (
province		VARCHAR(2) 	NOT NULL,
PST			INT,
GST 		INT,
PRIMARY KEY (province)
);

CREATE TABLE Product (
pID		 	INT 	NOT NULL,
color		VARCHAR(20),
material	VARCHAR(20),
brand		VARCHAR(20),
size		VARCHAR(20),
price		DEC(8,2),
weight		INT,
style		VARCHAR(20),
image		VARCHAR(20),
inventory 	INT,
PRIMARY KEY (pID)
);

CREATE TABLE Payment(
customerID 		INT	NOT NULL,
paymentName 	VARCHAR(20)	NOT NULL,
firstName		VARCHAR(20),
lastName		VARCHAR(20),
street			VARCHAR(20),
city 			VARCHAR(20),
province 		VARCHAR(20),
postalCode 		VARCHAR(10),
cardNo			VARCHAR(30) ,
cardSin			INT,
cardExpeiryDate	INT,
PRIMARY KEY(customerID , paymentName),
CONSTRAINT fk_CustomersPayment 
FOREIGN KEY (customerID) REFERENCES Customer(customerID)
);

CREATE TABLE Review(
pID 		INT 	NOT NULL,
customerID	INT	NOT NULL,
comment		VARCHAR(140), 
Stars		INT, 
dateAndTime	DATETIME,
PRIMARY KEY(customerID , pID),
CONSTRAINT fk_CustomerReview FOREIGN KEY (customerID) REFERENCES Customer(customerID),
CONSTRAINT fk_ProductReview FOREIGN KEY (pID) REFERENCES Product(pID)
);

CREATE TABLE WishList(
pID 			INT 	NOT NULL,
customerID		INT	NOT NULL,
PRIMARY KEY(customerID ),
CONSTRAINT fk_CustomerWishlist FOREIGN KEY (customerID) REFERENCES Customer(customerID)
);


CREATE TABLE Cart(
customerID		INT		NOT NULL,
cID				INT	IDENTITY(1,1)	NOT NULL,
province		VARCHAR(2) 	NOT NULL,
totalAmount		DEC(8,2),
GST				INT,
PRIMARY KEY(customerID ,cID),
CONSTRAINT fk_cust
FOREIGN KEY (customerID) REFERENCES Customer(customerID),
CONSTRAINT fk_tax
FOREIGN KEY (province) REFERENCES TAX(province)
);

CREATE TABLE Shipment(
shipmentNo  		INT	IDENTITY(1,1)	 NOT NULL,
shipDate  		DATE,
estimated		DATE,
noteToService	VARCHAR(140),
noteOnPackage	VARCHAR(140),
cID	 			INT		NOT NULL,
customerID 		INT		NOT NULL,
PRIMARY KEY (shipmentNo ),
CONSTRAINT fk_customer_cart FOREIGN KEY(customerID,cID)
REFERENCES Cart(customerID,cID) 
);

CREATE TABLE CartContains(
cID			INT		NOT NULL,
customerID	INT		NOT NULL,
pID 		INT 	NOT NULL,
quantity	INT		NOT NULL,
PRIMARY KEY(cID,pID,customerID),
CONSTRAINT fk_cuscart FOREIGN KEY(customerID,cID) REFERENCES Cart(customerID,cID) ,
CONSTRAINT fk_Cart_quantity FOREIGN KEY (pID) REFERENCES Product(pID)
);


insert INTO Customer VALUES('EricNelson12','rocket','Eric','Nelson','EricNelson12@gmail.com',1234,1234,'Kelowna','BC','V1V 1V8',0)
insert INTO  Customer VALUES('EricNelson12','rocket','Eric','Nelson','EricNelson12@gmail.com',1234,1234,'Kelowna','BC','V1V 1V8',0)
insert INTO  Customer VALUES('admin','admin','admin','admin','EricNelson12@gmail.com',1234,1234,'Kelowna','BC','V1V 1V8',0)


insert INTO  TAX VALUES ('AB',0,5)
insert INTO  TAX VALUES ('BC',7,5)
insert INTO  TAX VALUES ('MB',8,5)
insert INTO TAX VALUES ('NB',0,15)
insert INTO TAX VALUES ('NL',0,15)
insert INTO TAX VALUES ('NS',0,15)
insert INTO TAX VALUES ('NT',0,5)
insert INTO TAX VALUES ('NU',0,5)
insert INTO TAX VALUES ('ON',0,13)
insert INTO TAX VALUES ('PE',0,15)
insert INTO TAX VALUES ('QC',10,5)
insert INTO TAX VALUES ('SK',5,5)
insert INTO TAX VALUES ('YT',0,5)













insert INTO Product VALUES(1,'red','wool','Roots','xl',28.0,1,'Turtle Neck','product1.jpg',3);
INSERT INTO  Product Values (2,'blue','wool','Roots','xl',34.50,1,'Turtle Neck','product2.jpg',10);
INSERT INTO Product Values(3,'brown','wool','Roots','sm',15.0,1,'Turtle Neck','product3.jpg',7);
INSERT INTO Product Values(4,'red','wool','Roots','xl',28.30,1,'Turtle Neck','product4.jpg',10);
INSERT INTO Product Values(5,'blue','wool','Roots','xl',28.0,1,'Turtle Neck','product5.jpg',15);
INSERT INTO Product Values(6,'red','wool','Roots','xl',28.0,1,'Turtle Neck','product6.jpg',3);
INSERT INTO Product Values(7,'red','wool','Roots','xl',28.0,1,'Turtle Neck','product7.jpg',3);
INSERT INTO Product Values(8,'pink','wool','Roots','xl',28.0,1,'Turtle Neck','product8.jpg',3);
INSERT INTO Product Values(9,'pink','wool','Roots','xl',28.0,1,'Pjs','product9.jpg',3);
INSERT INTO Product Values(10,'grey','cotton','Roots','xl',14.0,1.5,'T-Shirt','product10.jpg',3);
INSERT INTO Product Values(11,'grey','wool','Roots','xl',28.0,1,'Turtle Neck','product11.jpg',3);
INSERT INTO Product Values(12,'yellow','wool','Roots','xl',28.0,1,'Turtle Neck','product12.jpg',3);
INSERT INTO Product Values(13,'yellow','wool','Roots','xl',28.0,1,'Turtle Neck','product13.jpg',3);
INSERT INTO Product Values(14,'blue','wool','Roots','xl',28.0,1,'Turtle Neck','product14.jpg',3);
INSERT INTO Product Values(15,'brown','wool','Roots','xl',28.0,1,'Jacket','product15.jpg',3);
INSERT INTO Product Values(16,'white','cotton','Roots','xl',28.0,1,'T-Shirt','product16.jpg',3);
INSERT INTO Product Values(17,'grey','wool','Roots','xl',50.0,1,'Turtle Neck','product17.jpg',5);
INSERT INTO Product Values(18,'pink','fleece','Roots','xl',28.0,1,'Turtle Neck','product18.jpg',3);
INSERT INTO Product Values(19,'white','cotton','Roots','xl',28.0,1,'T-Shirt','product19.jpg',3);
INSERT INTO Product Values(20,'green','fleece','Roots','xl',28.0,1,'Turtle Neck','product20.jpg',3);
INSERT INTO Product Values(21,'blue','wool','Roots','xl',28.0,1,'Turtle Neck','product21.jpg',3);
INSERT INTO Product Values(22,'green','cotton','Roots','xl',28.0,1,'Turtle Neck','product22.jpg',3);
INSERT INTO Product Values(23,'green','wool','Roots','xl',28.0,1,'Turtle Neck','product23.jpg',3);
INSERT INTO Product Values(24,'blue','wool','Roots','xl',28.0,1,'Turtle Neck','product24.jpg',3);


