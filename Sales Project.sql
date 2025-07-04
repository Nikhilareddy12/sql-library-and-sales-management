CREATE DATABASE sales;
USE sales;
CREATE TABLE Salesman(
	salesman_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    City VARCHAR(50),
    commission DECIMAL(4,2)
    );
    
CREATE TABLE Customer(
	customer_id INT PRIMARY KEY,
    Cust_name VARCHAR(100),
    City VARCHAR(50),
    Grade INT,
    salesman_id INT,
    FOREIGN KEY (salesman_id) REFERENCES Salesman(salesman_id)
    );
    
CREATE TABLE Orders(
ord_no INT PRIMARY KEY,
purch_amt DECIMAL(10,2),
ord_date DATE,
customer_id INT,
salesman_id INT,
FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
);
    
INSERT INTO Salesman VALUES 
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5003, 'Lauson Hen', 'San Jose', 0.12),
(5007, 'Paul Adam', 'Rome', 0.13);

INSERT INTO Customer VALUES
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3001, 'Brad Guzan', 'London', 100, 5005),
(3004, 'Fabian Johns', 'Paris', 300, 5006),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3009, 'Geoff Camero', 'Berlin', 100, 5003),
(3008, 'Julian Green', 'London', 300, 5002),
(3003, 'Jozy Altidor', 'Moscow', 200, 5007);

INSERT INTO Orders VALUES
(70001, 150.50, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.50, '2012-08-17', 3009, 5003),
(70007, 948.50, '2012-09-10', 3005, 5002),
(70005, 2400.60, '2012-07-27', 3007, 5001),
(70008, 5760.00, '2012-09-10', 3002, 5001),
(70010, 1983.43, '2012-10-10', 3004, 5006);

/* Display all customers whose ID is 2001 below the salesperson ID of MCLyon*/
SELECT * FROM Customer
WHERE customer_id = 2001 AND salesman_id < (SELECT salesman_id FROM salesman
	Where name = 'Mc Lyon');
    
/*salespeople not in same city as customer and commission > 12%*/
SELECT Customer.cust_name, Customer.City AS customer_city, Salesman.name AS Salesman_name, salesman.city AS Salesman_city, Salesman.commission
FROM Customer 
JOIN Salesman ON Customer.Salesman_id = Salesman.Salesman_id
WHERE customer.city <> Salesman.city AND salesman.commission > 0.12;

/* Customer Order placement report

SELECT c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt
FROM Orders o
LEFT JOIN Customer c ON o.customer_id = c.customer_id; */