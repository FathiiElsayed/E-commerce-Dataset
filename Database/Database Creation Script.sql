-- Establish the database
CREATE DATABASE Ecommerce
use Ecommerce
go
-- IMPORTING DATA TO Ecommerce DATABASE

-- The order of importing data should be:
-- geolocation > customers/sellers > orders > order_reviews/order_payments > category_names_english > products > order_items
-- according to the foreign keys'constraints 

-- Create table geolocation
CREATE TABLE Geolocation (
	Zip_code_prefix INT NOT NULL,
	Latitude FLOAT,
	Longitude FLOAT,
	City text,
	State text
)
go
BULK INSERT Geolocation
FROM 'E:\Chefaa_Assesment\Business Analyst Assessment\Dataset\Geolocation.csv'
WITH (
  FIRSTROW = 2,
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '\n'
  
)


-- Create table customers
drop table Customers
CREATE TABLE Customers (
    Customer_id VARCHAR(150) PRIMARY KEY NOT NULL,
    Customer_unique_id VARCHAR(MAX),
    Zip_code_prefix INT NOT NULL,
    City text,
    State text
)
go
BULK INSERT Customers
FROM 'E:\Chefaa_Assesment\Business Analyst Assessment\Dataset\Customers.csv'
WITH (
  FIRSTROW = 2,
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '\n'
  
)
-- Create table sellers

CREATE TABLE Sellers (
	Seller_id VARCHAR(150) PRIMARY KEY NOT NULL,
	Zip_code_prefix INT,
	City TEXT,
	State TEXT
)
go
BULK INSERT Sellers
FROM 'E:\Chefaa_Assesment\Business Analyst Assessment\Dataset\Sellers.csv'
WITH (
  FIRSTROW = 2,
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '\n'
  
)
-- Create table orders

CREATE TABLE Orders (
	Order_id VARCHAR(150) PRIMARY KEY NOT NULL,
	Customer_id VARCHAR(150) NOT NULL,
	Status TEXT,
	Purchase_timestamp DATETIME,
	Approval_timestamp DATETIME,
	Delivered_carrier_date DATETIME,
	Delivered_customer_date DATETIME,
	Dstimated_delivery_date DATETIME,
	CONSTRAINT Fk_Customer FOREIGN KEY (Customer_id) REFERENCES Customers(Customer_id)
)
go
BULK INSERT Orders
FROM 'E:\Chefaa_Assesment\Business Analyst Assessment\Dataset\Orders.csv'
WITH (
  FIRSTROW = 2,
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '\n'
 ) 

-- Create table order_reviews
drop table Order_Reviews
CREATE TABLE Order_Reviews (
	Review_id VARCHAR(150) NOT NULL,
	Order_id VARCHAR(150) NOT NULL,
	Rating INT,
	Review_title TEXT,
	Review_content TEXT,
	Creation_timestamp DATETIME,
	Answer_timestamp DATETIME,
	CONSTRAINT Fk_reviews FOREIGN KEY (Order_id) REFERENCES Orders(Order_id)
)
go
BULK INSERT Order_Reviews
FROM 'E:\Chefaa_Assesment\Business Analyst Assessment\Dataset\Reviews.csv'
WITH (
  FIRSTROW = 2,
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '\n'
 ) 

-- Create table order_payments
CREATE TABLE Order_Payments (
	Order_id VARCHAR(150) NOT NULL,
	Payment_sequential INT,
	Payment_type TEXT,
	Payment_installments INT,
	Payment_value Float,
	CONSTRAINT Fk_Payments FOREIGN KEY (Order_id) REFERENCES Orders(Order_id)
)
go
BULK INSERT Order_Payments
FROM 'E:\Chefaa_Assesment\Business Analyst Assessment\Dataset\Order_Payments.csv'
WITH (
  FIRSTROW = 2,
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '\n'
 ) 
-- Create table category

CREATE TABLE Categories(
	Product_category VARCHAR(150) PRIMARY KEY NOT NULL,
	Product_Category_Eng TEXT
)
go
BULK INSERT Categories
FROM 'E:\Chefaa_Assesment\Business Analyst Assessment\Dataset\Categories.csv'
WITH (
  FIRSTROW = 2,
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '\n'
 ) 

-- Create table products

CREATE TABLE Products (
	Product_id VARCHAR(150) PRIMARY KEY NOT NULL,
	Product_category VARCHAR(150),
	Name_length INT,
	Oescription_length INT,
	Photos_quantity INT,
	Weight_g INT,
	Length_cm INT,
	Height_cm INT,
	Width_cm INT,
	CONSTRAINT fk_cateogry_eng FOREIGN KEY (product_category) REFERENCES Categories(Product_category)
)
go
BULK INSERT Products
FROM 'E:\Chefaa_Assesment\Business Analyst Assessment\Dataset\Products.csv'
WITH (
  
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '\n',FIRSTROW = 2
 ) 
-- Create table order_items
CREATE TABLE Order_items (
	Order_id VARCHAR(150)NOT NULL,
	Item_id TEXT,
	Product_id VARCHAR(150) NOT NULL,
	Seller_id VARCHAR(150) NOT NULL,
	Shipping_limit_date DATETIME,
	Price Float,
	Freight_value Float,
	CONSTRAINT Fk_Products FOREIGN KEY (Product_id) REFERENCES products(Product_id),
	CONSTRAINT Fk_Orders FOREIGN KEY (Order_id) REFERENCES orders(Order_id),
	CONSTRAINT Fk_Sellers FOREIGN KEY (Seller_id) REFERENCES sellers(Seller_id)
)
go
BULK INSERT Order_items
FROM 'E:\Chefaa_Assesment\Business Analyst Assessment\Dataset\Order_Items.csv'
WITH (
  
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '\n',FIRSTROW = 2
 ) 