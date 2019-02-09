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