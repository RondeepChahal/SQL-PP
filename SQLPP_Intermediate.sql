Use Northwind_SPP;
--20. Total number of products in each category. Sort results by total number of products in desc
-- order.
--Select C.CategoryName, Count(*)
--From Categories C
--Join Products P
--ON C.CategoryID = P.CategoryID
--Group by C.CategoryName
--Order by 2 Desc;

-- 21. Customers table, show total number of customers per country and city
--Select C.Country, C.City, Count(*) as CustNum
--From Customers C
--Group by C.Country, C.City
--Order by 3 Desc;

-- 22. Products in Inventory that should be reordered. Use UnitsInStock and ReorderLevel - where UnitsInStock. Show ProductID, ProductName,
-- UnitsInStock, ReorderLevel. Sort by ProductID 
--Select ProductID, ProductName, UnitsInStock, ReorderLevel
--From Products
--Where UnitsInStock < ReorderLevel
--Order by 1;

-- 23. Products that need reordering.Same calculation as above, but UnitsInStock + UnitsOnOrder <= ReorderLevel and Discontinued is False (0).
--Select ProductID, ProductName, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued
--From Products
--Where (UnitsInStock+UnitsOnOrder)<= ReorderLevel
--and Discontinued = 0;

-- *** INTERESTING PROBLEM - using Case ***
-- 24. Get list of Customers, sorted by region, alphabetically. At top, list customers with nothing in region and sort those by CustomerID.
--Select CustomerID, ContactName, Region
--From Customers
--Order by Case when Region IS Null then 1 Else 0 End,3,2;

-- ***INTERESTING PROBLEM - using Top? ***
-- 25. Show 3 shipping countries with the highest average freight overall, in desc order of avg freight.
--Select Top 3 ShipCountry, AVG(Freight)
--from Orders
--Group by ShipCountry
--Order by 2 Desc;

-- 26. Same as above, but only factoring orders from year 2015
--Select Top 3 ShipCountry, AVG(Freight)
--from Orders
--Where Year(OrderDate) = 2015
--Group by ShipCountry
--Order by 2 Desc;

-- 27. A diagnostic query - between and date and datetime (12/31/2015 has an implied time of 00:00:00, and doesn't include the activities of the hours
-- of that day
--Select Top 3 ShipCountry, Avg(Freight) as AvgFreight
--From Orders
--Where OrderDate between '1/1/2015' and '12/31/2015 23:59:59'
--Group by ShipCountry
--Order by 2 Desc;

-- 28. Same query, but instead of filtering by year, filter for 12 months prior to last order
--Select Top 3 ShipCountry, AVG(Freight)
--from Orders
--Where OrderDate > DateAdd(Month,-12,(Select Max(OrderDate) from Orders))
--Group by ShipCountry
--Order by 2 Desc;

--29. Show employee and order detail information for all orders - sort by orderID and product ID. Columns: employeeid,lastname,orderid,productname, 
-- and quantity.
--Select E.EmployeeID, E.LastName, O.OrderID, P.ProductName, OD.Quantity
--from Employees E
--Join Orders O
--On E.EmployeeID = O.EmployeeID
--JOIN OrderDetails OD
--ON O.OrderID = OD.OrderID
--JOIN Products P
--ON OD.ProductID = P.ProductID
--Order by 3,P.ProductID;

--30. Show Customers with no orders
--Select C.CustomerID, O.OrderID as OrderHistory
--From Customers C
--Left Join Orders O
--On C.CustomerID = O.CustomerID
--Where O.OrderID is Null;

--31. Show customers who have never placed an order with employeeid 4
--Select distinct C.CustomerID, employeeID
--From Customers C
--Left Join Orders O
--ON C.CustomerID = O.CustomerID
--Where C.CustomerID Not In
--	(Select C.CustomerID
--	From Customers C
--	Join Orders O
--	ON C.CustomerID = O.CustomerID
--	Where EmployeeID = 4);
