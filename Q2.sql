-- Question 2: 
 -- For this question you’ll need to use SQL. Follow this link to access the data set required for the challenge.
 -- Please use queries to answer the following questions. Paste your queries along with your final numerical answers below.


-- a)How many orders were shipped by Speedy Express in total?

select count(*) as total_orders 
From Orders 
where ShipperID=(SELECT ShipperID FROM [Shippers] where ShipperName="Speedy Express")

-- a) ans: 54


-- 

-- b) What is the last name of the employee with the most orders?
with max_order_emp as 
(
SELECT EmployeeID,count(*) as cnt 
FROM [Orders] 
	group by EmployeeID 
	order by cnt DESC 
)
SELECT emp.LastName,max_ord.cnt as OrderCount 
FROM [Employees] emp 
	join max_order_emp max_ord 
	on emp.EmployeeID=max_ord.EmployeeID 
	order by max_ord.cnt DESC 

-- b) ans: LastName:Peacock


 -- 


-- c)What product was ordered the most by customers in Germany?

with germany_orders as
(
SELECT  ord.OrderID as OrderID  
FROM [Orders]  ord 
	join Customers cus 
	on  ord.CustomerID=cus.CustomerID and cus.Country="Germany"
),

germany_productids as (
		SELECT OD.ProductID,count(*) cnt 
		FROM [OrderDetails] od join germany_orders go 
			on  go.OrderID=od.OrderID  
			group by od.ProductID 
			order by cnt DESC 
)
select p.ProductName ,germ_prod.cnt
From Products p join germany_productids germ_prod
	on p.ProductID =germ_prod.ProductID  order by germ_prod.cnt DESC

-- c) ans: ProductName:Gorgonzola Telino
