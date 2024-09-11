create database ecommerce; 
use ecommerce;
 
create table product
(product_id int auto_increment primary key,
product_name varchar(75) not null,
category varchar(50) not null,
price decimal(15,2) not null,
stock_quantity int not null);

create table customers
(customer_id int auto_increment primary key,
first_name varchar(70) not null,
last_name varchar(65) not null,
email_id varchar(55) not null,
address varchar(45) not null,
contact_number varchar(85) not null);

create table orders
(order_id int auto_increment primary key,
customer_id int not null,
order_date date,
total_amount decimal(18,3));

create table order_details
(orderdetails_id int auto_increment primary key,
order_id int not null,
product_id int not null,
quantity int not null,
price decimal(15,2)not null); 

alter table orders add foreign key (customer_id) references customers (customer_id);
alter table order_details add foreign key(order_id) references orders (order_id);
alter table order_details add foreign key (product_id) references product (product_id);
 
insert into product values(01,"smartphone","Electronics",15000,75),
(02,"mixture","Electronics",7500,60),
(03,"television","Electronics",10000,55),
(04,"freeze","Electronics",18000,120),
(05,"sofas","Furniture",25000,95),
(06,"Bed","Furniture",8500,35),
(07,"tables","Furniture",1500,48),
(08,"goldchain","jeweler",75000,69),
(09,"goldrings","jeweler",23000,55),
(10,"goldearing","jeweler",32000,40);

insert into customers values
(1,"aashish","jain","aashis@123gmail.com","dewas",9826533586),
(2,"ramesh","shah","ramesh@123gmail.com","ujjain",9856498566),
(3,"krishn","murti","krishn@123gmail.com","rau",9845755698),
(4,"dev","aaryan","dev@123gmail.com","bhopal",8758944569),
(5,"ravi","roy","ravi@123gmail.com","indore",8874523559),
(6,"sunny","verma","sunny@123gmail.com","up",7745874588),
(7,"aditya","sahu","aadi@123gmail.com","shrilanka",8974584456),
(8,"semma","jain","seema@123gmail.com","kashmir",8874577848),
(9,"shivam","jain","shivam@123gmail.com","jamu",9856844785),
(10,"radhika","sen","radhu@123gmail.com","shrinagar",8874598658); 

insert into orders values
(001,1,"2024-1-1",35000),
(002,2,"2024-2-1",45000),
(003,3,"2024-3-1",55000),
(004,4,"2024-4-1",65000),
(005,5,"2024-5-1",55000),
(006,6,"2024-2-1",45000),
(007,7,"2024-6-1",40000),
(008,8,"2024-2-1",60000),
(009,9,"2024-7-1",35000),
(0010,10,"2024-3-1",55000);

insert into order_details values
(1001,001,01,25,15000),
(1002,002,02,35,7500),
(1003,003,03,10,10000),
(1004,004,04,100,18000),
(1005,005,05,150,25000),
(1006,006,06,50,8500),
(1007,007,07,80,1500),
(1008,008,08,300,75000),
(1009,009,09,250,23000),
(10010,0010,010,120,32000);

select * from product; 
select * from customers; 
select * from orders; 
select * from order_details; 

-- Q1 Retrieve all products from the product table.
select * from product; 

-- Q2 Find the names and prices of all products in 
-- the product table where the price is greater than $100.
select * from product;
select product_name , price from product 
where price > 100; 

-- Q3 Get the names and email IDs of all customers 
-- from the customers table.
select * from customers; 
select concat(first_name,"  ",last_name) as full_name, email_id from customers; 

-- Q4 Retrieve the details of orders placed on a specific date (e.g., '2024-07-01').
select * from orders; 
select * from orders
where order_date = "2024-07-1"; 

-- Q5 List all products with their stock quantity that belong to the 'Electronics' category.
select * from product
where category = "Electronics"; 

-- Q6 Find the total number of products in each category.
select * from product; 
select category,count(*) as total_number from product
group by category;

-- Q7 Calculate the average price of all products.
select * from product; 
select avg(price)as avg_price from product; 

-- Q8 Get the maximum and minimum price of
-- products in the 'jeweler' category.
select * from product; 
select min(price)as mini_price,max(price)as max_price from product
where category = "jeweler" ; 

-- Q9 Count the total number of orders placed by each customer.
select * from orders; 
select * from customers; 
select c.customer_id ,count(o.order_id)as number_orders from orders o 
join customers c 
on c.customer_id = o.customer_id 
group by c.customer_id; 

-- Q10 Find the total amount spent on orders by each customer.
select * from orders ; 
select * from customers;
select customer_id,sum(total_amount)as spent_amount from orders 
group by customer_id; 

-- Q11 List all orders along with the names of the products 
-- included in those orders. 
select * from order_details; 
select * from product; 
select p.product_id, p.product_name from product p
join order_details o 
on p.product_id = o.product_id
group by p.product_id ;

-- Q12 Get the names and total amount of each order placed by customers.
select * from orders; 
select * from customers; 
select c.customer_id,concat(c.first_name," ",c.last_name) as full_name, sum(o.total_amount) as total_amount from customers c 
join orders o 
on c.customer_id = o.customer_id
group by c.customer_id;

-- Q13 Show all order details along with the corresponding product names and order quantities.
select * from order_details; 
select * from product; 
select od.orderdetails_id ,od.product_id ,od.quantity,p.product_name from order_details od 
join product p 
on od.product_id = p.product_id;

-- Q14 Retrieve products that are included in any orders.
select * from product; 
select * from order_details; 
select p.product_id,p.product_name from product p 
join order_details od 
on p.product_id = od.product_id; 

-- Q15 Find products with a price higher than the average price.
select * from product; 
select * from product 
where price > (select avg(price) from product); 

-- Q16 Get customers who have placed orders totaling more than 50,000.
select * from customers; 
select * from orders; 
select c.customer_id,concat(c.first_name," ",c.last_name)as full_name ,o.total_amount from customers c 
join orders o 
on c.customer_id = o.customer_id 
where o.total_amount > 50000; 

-- Q17 List products that have never been ordered.
select * from product; 
select * from order_details; 
select * from product 
where product_id not in (select product_id from order_details); 

-- Q18 Find the customer who has placed the most orders.
select * from customers; 
select * from orders;
select c.customer_id,concat(c.first_name," ",c.last_name)as full_name,max(order_id) as most_order from customers c 
join orders o 
on c.customer_id  = o.customer_id 
group by o.order_id
order by most_order 
limit 1;

-- Q19 Get products with stock quantities below the average stock quantity.
select * from product;
select * from product 
where (stock_quantity)<(select avg(stock_quantity) from product); 

-- Q20 Increase the price of all products by 5%.
select * from product; 
update product 
set price = price * 1.5;
set sql_safe_updates = 0;  

-- Q21 List customers who have placed at least one order.
select * from customers; 
select * from orders; 
select distinct concat(c.first_name," ",c.last_name)as full_name from customers c 
join orders o   
on c.customer_id = o.customer_id ; 

-- Q22 Find products with prices both in 'Electronics' and 'Furniture' categories. 
select * from product; 
select product_name , price , category from product
where category in ('Electronics','Furniture') ; 

-- Q23 Retrieve the most recent 5 orders.
select * from orders
order by order_date desc
limit 5 ;  

-- Q24 Get the average order amount per customer.
select * from customers; 
select * from orders; 
select avg(o.total_amount) as avg_amount, c.first_name, c.last_name from customers c  
join orders o  
on o.customer_id = c.customer_id
group by c.customer_id; 

-- Q26 Find the total number of products ordered per product category.
select * from product; 
select * from order_details; 
select p.category,sum(od.quantity) as total_quantity from order_details od  
join product p    
on od.product_id = p.product_id
group by p.category; 

-- Q27 Create a view to display the total spending of each customer.
 select * from orders; 
create view customer_total_spending as 
select customer_id ,sum(total_amount) as 
total_spending_customer from orders
group by customer_id;

select * from customer_total_spending; 

-- Q28 Get a summary of products and their total sales.
select * from product; 
select * from order_details; 
select p.product_id,p.product_name,sum(od.quantity)as total_sales from product p 
join order_details od 
on p.product_id = od.product_id 
group by p.product_id ; 

-- Q29 Add an index on the price column in the product table.
select * from product;
create index idx_price on product(price); 
show index from product; 







 


 
 


 

 




 
  





 





 







  






















 












 





  



  

