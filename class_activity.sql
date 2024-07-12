create database Salesdb;
use Salesdb;


create table Productlines(
productLine VARCHAR(50) PRIMARY KEY,
textDescription VARCHAR(4000),
htmlDescription MEDIUMTEXT,
image MEDIUMBLOB
);


create table products(
productCode VARCHAR(15) PRIMARY KEY,
productName VARCHAR(70) NOT NULL,
productLine VARCHAR(50),
constraint product_key foreign key fk_products (productLine)
references productlines(productLine),
productScale VARCHAR(10) NOT NULL,
productVendor VARCHAR(50) NOT NULL,
productDescription TEXT NOT NULL,
quantityInStock SMALLINT NOT NULL,
buyPrice DECIMAL(10, 2) NOT NULL,
MSRP DECIMAL(10, 2) NOT NULL
);


create table offices(
officeCode VARCHAR(10) PRIMARY KEY,
city VARCHAR(50) NOT NULL,
phone VARCHAR(50) NOT NULL,
addressLine1 VARCHAR(50) NOT NULL,
addressLine2 VARCHAR(50),
state VARCHAR(50),
country VARCHAR(50) NOT NULL,
postalCode VARCHAR(15) NOT NULL,
territory VARCHAR(10) NOT NULL
);


create table employees(
employeeNumber INT PRIMARY KEY,
lastName VARCHAR(50) NOT NULL,
firstName VARCHAR(50) NOT NULL,
extension VARCHAR(10) NOT NULL,
email VARCHAR(100) NOT NULL,
officeCode VARCHAR(10),
constraint offices_key foreign key fk_officecode (officeCode)
references offices(officeCode),
reportsTo int,
constraint reportsto_key foreign key fk_reportsto(reportsTo)
references employees(employeeNumber),
jobTitle VARCHAR(50) NOT NULL
);



create table customers (
customerNumber INT PRIMARY KEY,
customerName VARCHAR(50) NOT NULL,
contactLastName VARCHAR(50) NOT NULL,
contactFirstName VARCHAR(50) NOT NULL,
phone VARCHAR(50) NOT NULL,
addressLine1 VARCHAR(50) NOT NULL,
addressLine2 VARCHAR(50),
city VARCHAR(50) NOT NULL,
state VARCHAR(50),
postalCode VARCHAR(15),
country VARCHAR(50) NOT NULL,
salesRepEmployeeNumber int,
constraint salesRepEmployeeNumber_key foreign key fk_salesRepEmployeeNumber(salesRepEmployeeNumber)
references employees(employeeNumber),
creditLimit DECIMAL(10, 2)
);


create table orders (
orderNumber INT PRIMARY KEY,
orderDate DATE NOT NULL,
requiredDate DATE NOT NULL,
shippedDate DATE,
status VARCHAR(15) NOT NULL,
comments TEXT,
customerNumber INT,
constraint customerNumber_key foreign key fk_customerNumber(customerNumber)
references customers(customerNumber)
);

create table orderdetails(
orderNumber INT,
constraint orderNumber_key foreign key fk_orderNumber(orderNumber)
references orders(orderNumber),
productCode VARCHAR(15),
constraint productCode_key foreign key fk_productCode(productCode)
references products(productCode),
quantityOrdered INT NOT NULL,
priceEach DECIMAL(10, 2) NOT NULL,
orderLineNumber SMALLINT NOT NULL,
primary key(orderNumber,productCode)
);


create table payments(
customerNumber INT,
constraint customerNumber_payments_key foreign key fk_customerNumber(customerNumber)
references customers(customerNumber),
checkNumber VARCHAR(50) PRIMARY KEY,
paymentDate DATE NOT NULL,
amount DECIMAL(10, 2) NOT NULL
);


