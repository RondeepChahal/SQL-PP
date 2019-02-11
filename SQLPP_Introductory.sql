-- Select * from Sys.databases;
Use Northwind_SPP;

-- Introductory Problems

-- 1. Return all fields from all the shippers
-- select * from Shippers;

-- 2. Get 2 columns from the Categories table - CategoryName and Description

-- Select * from Categories;

--Select CategoryName, Description
--From Categories;

-- 3. Show FirstName, LastName, and HireDate of all employees with Title of Sales Representative

--Select FirstName, LastName, HireDate
--from Employees
--Where Title = 'Sales Representative';

-- 4. Same as above but also only those in United States

--Select FirstName, LastName, HireDate
--from Employees
--Where Title = 'Sales Representative'
--	and Country = 'USA';

-- 5. All orders by EmployeeID 5

--Select OrderID, OrderDate
--from Orders
--where employeeid = 5;

-- 6. From Suppliers Table - show SupplierID, ContactName, ContactTitle and suppliers whose contacttitle is NOT marketing Manager
--Select SupplierID, ContactName, ContactTitle
--From Suppliers
--Where ContactTitle != 'Marketing Manager';

-- 7. Products table - ProductID and ProductName where the ProductName includes the string 'queso'
--Select ProductID, ProductName
--From Products
--Where ProductName like '%queso%';

-- 8. From Orders, show OrderID, CustomerID, ShipCountry where the ShipCountry is either France or Belgium.
--Select OrderID, CustomerID, ShipCountry
--from Orders
--Where ShipCountry in ('France','Belgium');

--9. From Orders, show OrderID, CustomerID, ShipCountry where the ShipCountry is in Latin America (Brazil, Mexico, Argentina,
-- and Venezuela).
--Select OrderID, CustomerID, ShipCountry
--from Orders
--Where ShipCountry in ('Brazil','Mexico','Argentina','Venezuela');

--10. From Employees, show FirstName,LastName,Title, and BirthDate. Order by BirthDate with oldest employees first.
--Select FirstName,LastName,Title,Birthdate
--from Employees
--Order by BirthDate;

--11. From Employees, show FirstName, LastName, Title and Birthdate - but don't include the time portion.
--Select FirstName,LastName,Title,Convert(date,Birthdate)
--from Employees
--Order by BirthDate;

--12. From Employees, FirstName, LastName, then new column concating with a space
--Select FirstName,LastName, Concat(FirstName,' ',LastName) FullName
--from Employees;

--13. From OrderDetails table, Show OrderID, ProductID, UnitPrice, Quantity, then a TotalPrice Field that
--is Quantity*UnitPrice. Order by OrderID and ProductID.

--Select OrderID, ProductID, UnitPrice, Quantity, (UnitPrice*Quantity) TotalPrice
--From OrderDetails
--Order by 1,2;

--14. How many customers are in the Customers table.

--Select Count(*) TotalCustomers
--From Customers;

----15. Show the date of the first order in the Orders Table
--Select Min(OrderDate) as FirstOrder
--From Orders;

-- 16. Show countries where Northwind Co. has customers.
--Select Distinct Country
--from Customers;
---- or
--Select Country
--From Customers
--group by Country;

--17. Show the different values in the ContactTitles column of the Customers table. Include their count.

--Select ContactTitle, Count(*) as Total
--From Customers
--Group by ContactTitle
--Order by 2 Desc;

-- 18. For each Product, show the associated Supplier. Show ProductID, ProductName, and CompanyName of
-- the Supplier. Sort by ProductID.

--Select P.ProductID, P.ProductName, S.CompanyName
--From Products P
--JOIN Suppliers S
--ON P.SupplierID = S.SupplierID
--Order by 1;

--19. Show a list of Orders, and include the Shipper used. Show OrderID, OrderDate (DateOnly), and
-- CompanyName of Shipper, sorted by OrderID, and show only rows with OrderID less than 10270

--Select O.OrderID, O.OrderDate, S.CompanyName
--From Orders O
--Join Shippers S
--ON O.ShipVia = S.ShipperID
--Where O.OrderID < 10270
Order by 1