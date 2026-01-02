create database ecommerce_db;
drop database ecommerce_db;
use ecommerce_db;

create table Customers (
Customer_id int primary key,
Customer_Name  varchar(200),
Email varchar(50),
City varchar(30),
Register_date Date);

select* from Customers;
insert into Customers values (1, 'Amit Kumar', 'amit@gmail.com', 'Pune', '2024-01-05'),
							(2, 'Neha Sharma', 'neha@gmail.com', 'Pune', '2024-01-10'),
                            (3, 'pooja kale', 'pooja@gamil.com', 'Nashik', '2024-03-06'),
                            (4, 'Aajy Kumar','aajay@gmail.com', 'Mumbai', '2025-03-20'),
                            (5, 'Ram Patil','ram@gmail.com', 'Nashik', '2024-02-10');
                            
create table Products(
Poduct_id int primary key,
Product_Name varchar(100),
Category varchar(50),
Price decimal(8,2),
Stock int);

Alter table Products change poduct_id product_id int;
Alter table Products change product_id Product_id int; 

select * from Products;
insert into  Products values(101, 'Laptop', 'Electronic', 55000,10),
							(102, 'Mobile Phone', 'Electronic', 25000,15),
                            (103, 'Headphone', 'Accessories', 5000,25),
                            (104, 'Tab', 'Electronic', 35000,10),
                            (105, 'Laptop', 'Electronic', 65000,15);
                            
create table Orders(
Order_id int primary key,
Customer_id int,
Order_date Date,
Order_status varchar(30),
foreign key (Customer_id) references Customers(Customer_id)
);

select * from Orders;
insert into Orders values(1001, 1, '2024-01-04', 'Delivered'),
                         (1002, 2, '2024-01-10', 'Shipped'),
                         (1003, 3, '2024-03-06', ' Not Delivered'),
                         (1004, 4, '2025-03-20', 'Delivered'),
						 (1005, 5, '2024-02-10', 'Delivered');

delete  from Orders where Order_date='2024-01-05';  

create table order_items(
item_id int primary key,
Order_id int,
Product_id int,
quntity int,
foreign key (Order_id) references Orders(Order_id),
foreign key (Product_id) references Products(Product_id));   

select * from order_items;
insert into order_items values(1, 1001, 101, 1),
							 (2, 1002, 102, 2),
                             (3, 1003, 103, 1),
                             (4, 1004, 104, 4),
                             (5, 1005, 105, 1);
create table Payments(
payment_id int primary key,
Order_id int,
payment_date Date,
payment_method varchar(20),
amount Decimal(10.2),
foreign key (Order_id) references Orders(Order_id));

select * from Payments;
insert into Payments value(1, 1001, '2024-01-05', 'Cerdit Card', 61000),
						(2, 1002, '2024-01-10', 'UPI', 1000),
                        (3, 1003, '2024-02-05', 'Cerdit Card', 6000),
                        (4, 1004,  '2025-02-05', 'Debit Card', 5500),
                        (5, 1005, '2025-01-04', 'UPI', 15000);


select Product_Name, Price
from Products
where Category = 'Electronic';

select o.Order_id, c.Customer_Name, o.Order_status
from Orders o
join Customers c on o.Customer_id = c.Customer_id;

select c.Customer_Name, p.Product_Name, oi.quntity
from order_items oi
join Orders o on oi.Order_id = o.Order_id
join Customers c on o.Customer_id = c.Customer_id
join Products p on oi.Product_id = p.Product_id;

select sum(amount)  as total_sales
from Payments;

select p.Product_Name, sum(oi.quntity * p.Price) as total_revenue
from order_items oi
join Products p on oi.Product_id = p.Product_id 
group by p.Product_Name;

select p.Product_Name, sum(oi.quntity) as total_sold
from order_items oi
join Products p on oi.Product_id = p.Product_id
group by p.Product_Name
order by total_sold Desc;

select c.Customer_Name, count(o.Order_id) as Order_count
from Customers c 
join Orders o on c.Customer_id = o.Customer_id 
group by c.Customer_Name
Having count(o.Order_id) > 0;

select Order_id, Order_status
from Orders
where Order_status  <> 'Delivered'



