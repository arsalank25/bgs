DROP TABLE Shipment ;
DROP TABLE PST ;
DROP TABLE  Payment ;
DROP TABLE Review ;
DROP TABLE  Cart ;
DROP TABLE WishList ;
DROP TABLE OrderContains ;
DROP TABLE  Product ;
DROP TABLE Customer ;


CREATE TABLE Customer (
CustomerID 	int				NOT NULL PRIMARY KEY,
password 	VARCHAR(20) 	NOT NULL,
firstName 	VARCHAR(50) 	NOT NULL,
lastName 	VARCHAR(50) 	NOT NULL,
email 		VARCHAR(30) 	NOT NULL,
houseNo 	VARCHAR(20),
street		VARCHAR(20),
city 		VARCHAR(20),
province 	VARCHAR(20),
postalCode 	VARCHAR(10),
accessLevel SMALLINT 	 	NOT NULL
);

CREATE TABLE Shipment(
shipmentNo  		INT()		 NOT NULL,
shipDate  		DATE,
estimated		DATE,
noteToService	VARCHAR(140)
noteOnPackage	VARCHAR(140)
oID	 			INT()		NOT NULL,
CustomerID 		INT()		NOT NULL,
PRIMARY KEY (shipmentNo )
FOREIGN KEY (CustomerID,oID) REFERENCES Cart(CustomerID,oID)
);

CREATE TABLE PST(
province		VARCHAR(2) 	NOT NULL,
PST			INT(),
PRIMARY KEY (province)
);

CREATE TABLE Product (
pID		INT() 	NOT NULL,
color		VARCHAR(20),
material	VARCHAR(20),
brand		VARCHAR(20),
size		VARCHAR(20),
price		DEC(8,2),
weight		INT()
style		VARCHAR(20),
image		VARCHAR(20),
inventory 	INT(),
PRIMARY KEY (pID)
);

CREATE TABLE Payment(
CustomerID 		INT()	NOT NULL,
paymentName 	VARCHAR(20)	NOT NULL,
firstName		VARCHAR(20),
last Name		VARCHAR(20),
street			VARCHAR(20),
city 			VARCHAR(20),
province 		VARCHAR(20),
postalCode 		VARCHAR(10),
cardNo			INT(),
cardSin			INT(),
cardExpeiryDate	INT(),
PRIMARY KEY(CustomerID , paymentName),
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE Cart(
CustomerID		INT()		NOT NULL,
oID				INT()		NOT NULL,
province		VARCHAR(20),
totalAmount		DEC(8,2),
GST				INT(),
PRIMARY KEY(CustomerID ,oID),
FOREIGN KEY (province) REFERENCES PST(province)
);

CREATE TABLE Review(
pID 		INT() 	NOT NULL,
CustomerID	INT()	NOT NULL,
Text		VARCHAR(140), 
Stars		INT(5), 
dateTime	DATETIME,
PRIMARY KEY(CustomerID , pID),
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
FOREIGN KEY (pID) REFERENCES Product(pID)
);

CREATE TABLE WishList(
pID 			INT() 	NOT NULL,
CustomerID		INT()	NOT NULL,
PRIMARY KEY(CustomerID ),
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE OrderContains(
oID			INT()		NOT NULL, 
pID 		INT() 		NOT NULL,
quantity	INT()		NOT NULL,
PRIMARY KEY(oID,pID),
FOREIGN KEY (oID) REFERENCES Cart(oID)
FOREIGN KEY (pID) REFERENCES Product(pID)
);




insert Product Values(1,'red','wool','Roots','xl',28.0,'1kg','Turtle Neck','product1.jpg',3);
INSERT Product Values(2,'blue','wool','Roots','xl',34.50,'1kg','Turtle Neck','product2.jpg',10);
INSERT Product Values(3,'brown','wool','Roots','sm',15.0,'1kg','Turtle Neck','product3.jpg',7);
INSERT Product Values(4,'red','wool','Roots','xl',28.30,'1kg','Turtle Neck','product4.jpg',10);
INSERT Product Values(5,'blue','wool','Roots','xl',28.0,'1kg','Turtle Neck','product5.jpg',15);
INSERT Product Values(6,'red','wool','Roots','xl',28.0,'1kg','Turtle Neck','product6.jpg',3);
INSERT Product Values(7,'red','wool','Roots','xl',28.0,'1kg','Turtle Neck','product7.jpg',3);
INSERT Product Values(8,'pink','wool','Roots','xl',28.0,'1kg','Turtle Neck','product8.jpg',3);
INSERT Product Values(9,'pink','wool','Roots','xl',28.0,'1kg','Turtle Neck','product9.jpg',3);
INSERT Product Values(10,'grey','cotton','Roots','xl',14.0,'1.5kg','T-Shirt','product10.jpg',3);
INSERT Product Values(11,'grey','wool','Roots','xl',28.0,'1kg','Turtle Neck','product11.jpg',3);
INSERT Product Values(12,'yellow','wool','Roots','xl',28.0,'1kg','Turtle Neck','product12.jpg',3);
INSERT Product Values(13,'yellow','wool','Roots','xl',28.0,'1kg','Turtle Neck','product13.jpg',3);
INSERT Product Values(14,'blue','wool','Roots','xl',28.0,'1kg','Turtle Neck','product14.jpg',3);
INSERT Product Values(15,'brown','wool','Roots','xl',28.0,'1kg','Jacket','product15.jpg',3);
INSERT Product Values(16,'white','cotton','Roots','xl',28.0,'1kg','T-Shirt','product16.jpg',3);
INSERT Product Values(17,'grey','wool','Roots','xl',50.0,'1kg','Turtle Neck','product17.jpg',5);
INSERT Product Values(18,'pink','fleece','Roots','xl',28.0,'1kg','Turtle Neck','product18.jpg',3);
INSERT Product Values(19,'white','cotton','Roots','xl',28.0,'1kg','T-Shirt','product19.jpg',3);
INSERT Product Values(20,'green','fleece','Roots','xl',28.0,'1kg','Turtle Neck','product20.jpg',3);
INSERT Product Values(21,'blue','wool','Roots','xl',28.0,'1kg','Turtle Neck','product21.jpg',3);
INSERT Product Values(22,'green','cotton','Roots','xl',28.0,'1kg','Turtle Neck','product22.jpg',3);
INSERT Product Values(23,'green','wool','Roots','xl',28.0,'1kg','Turtle Neck','product23.jpg',3);
INSERT Product Values(24,'blue','wool','Roots','xl',28.0,'1kg','Turtle Neck','product24.jpg',3);


