DROP TABLE OrderContains,WishList, Review,Cart,Customer, Payment,Product,PST,Shipment;

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
shipmentNo  		INT		 NOT NULL,
shipDate  		DATE,
estimated		DATE,
noteToService	VARCHAR(140),
noteOnPackage	VARCHAR(140),
oID	 			INT		NOT NULL,
CustomerID 		INT		NOT NULL,
PRIMARY KEY (shipmentNo ),
CONSTRAINT fk_customer_cart FOREIGN KEY(CustomerID,oID)
REFERENCES Cart(CustomerID,oID) 
);

CREATE TABLE PST(
province		VARCHAR(2) 	NOT NULL,
PST			INT,
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
CustomerID 		INT	NOT NULL,
paymentName 	VARCHAR(20)	NOT NULL,
firstName		VARCHAR(20),
lastName		VARCHAR(20),
street			VARCHAR(20),
city 			VARCHAR(20),
province 		VARCHAR(20),
postalCode 		VARCHAR(10),
cardNo			INT,
cardSin			INT,
cardExpeiryDate	INT,
PRIMARY KEY(CustomerID , paymentName),
CONSTRAINT fk_CustomersPayment 
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE Cart(
CustomerID		INT		NOT NULL,
oID				INT		NOT NULL,
province		VARCHAR(20),
totalAmount		DEC(8,2),
GST				INT,
PRIMARY KEY(CustomerID ,oID),
CONSTRAINT fk_provincePST 
FOREIGN KEY (province) REFERENCES PST(province)
);

CREATE TABLE Review(
pID 		INT 	NOT NULL,
CustomerID	INT	NOT NULL,
comment		VARCHAR(140), 
Stars		INT, 
dateAndTime	DATETIME,
PRIMARY KEY(CustomerID , pID),
CONSTRAINT fk_CustomerReview FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
CONSTRAINT fk_ProductReview FOREIGN KEY (pID) REFERENCES Product(pID)
);

CREATE TABLE WishList(
pID 			INT 	NOT NULL,
CustomerID		INT	NOT NULL,
PRIMARY KEY(CustomerID ),
CONSTRAINT fk_CustomerWishlist FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE OrderContains(
oID			INT		NOT NULL, 
pID 		INT 	NOT NULL,
quantity	INT		NOT NULL,
PRIMARY KEY(oID,pID),
CONSTRAINT fk_Cart_Order FOREIGN KEY (oID) REFERENCES Cart(oID),
CONSTRAINT fk_Orders_quantity FOREIGN KEY (pID) REFERENCES Product(pID)
);




insert Product Values(1,'red','wool','Roots','xl',28.0,1,'Turtle Neck','product1.jpg',3);
INSERT Product Values(2,'blue','wool','Roots','xl',34.50,1,'Turtle Neck','product2.jpg',10);
INSERT Product Values(3,'brown','wool','Roots','sm',15.0,1,'Turtle Neck','product3.jpg',7);
INSERT Product Values(4,'red','wool','Roots','xl',28.30,1,'Turtle Neck','product4.jpg',10);
INSERT Product Values(5,'blue','wool','Roots','xl',28.0,1,'Turtle Neck','product5.jpg',15);
INSERT Product Values(6,'red','wool','Roots','xl',28.0,1,'Turtle Neck','product6.jpg',3);
INSERT Product Values(7,'red','wool','Roots','xl',28.0,1,'Turtle Neck','product7.jpg',3);
INSERT Product Values(8,'pink','wool','Roots','xl',28.0,1,'Turtle Neck','product8.jpg',3);
INSERT Product Values(9,'pink','wool','Roots','xl',28.0,1,'Pjs','product9.jpg',3);
INSERT Product Values(10,'grey','cotton','Roots','xl',14.0,1.5,'T-Shirt','product10.jpg',3);
INSERT Product Values(11,'grey','wool','Roots','xl',28.0,1,'Turtle Neck','product11.jpg',3);
INSERT Product Values(12,'yellow','wool','Roots','xl',28.0,1,'Turtle Neck','product12.jpg',3);
INSERT Product Values(13,'yellow','wool','Roots','xl',28.0,1,'Turtle Neck','product13.jpg',3);
INSERT Product Values(14,'blue','wool','Roots','xl',28.0,1,'Turtle Neck','product14.jpg',3);
INSERT Product Values(15,'brown','wool','Roots','xl',28.0,1,'Jacket','product15.jpg',3);
INSERT Product Values(16,'white','cotton','Roots','xl',28.0,1,'T-Shirt','product16.jpg',3);
INSERT Product Values(17,'grey','wool','Roots','xl',50.0,1,'Turtle Neck','product17.jpg',5);
INSERT Product Values(18,'pink','fleece','Roots','xl',28.0,1,'Turtle Neck','product18.jpg',3);
INSERT Product Values(19,'white','cotton','Roots','xl',28.0,1,'T-Shirt','product19.jpg',3);
INSERT Product Values(20,'green','fleece','Roots','xl',28.0,1,'Turtle Neck','product20.jpg',3);
INSERT Product Values(21,'blue','wool','Roots','xl',28.0,1,'Turtle Neck','product21.jpg',3);
INSERT Product Values(22,'green','cotton','Roots','xl',28.0,1,'Turtle Neck','product22.jpg',3);
INSERT Product Values(23,'green','wool','Roots','xl',28.0,1,'Turtle Neck','product23.jpg',3);
INSERT Product Values(24,'blue','wool','Roots','xl',28.0,1,'Turtle Neck','product24.jpg',3);


