Use Northwind_SPP;
--32. Customers who have at least 1 order equal to $10,000 or more during orders in year 2016.
--Select C.CustomerID, C.CompanyName, OD.OrderID, Sum(OD.UnitPrice*OD.Quantity) as TotalOrderAmount
--From OrderDetails OD
--Join Orders O
--on OD.OrderID = O.OrderID
--Join Customers C
--on O.CustomerID = C.CustomerID
--Where Year(O.OrderDate) = 2016
--Group by C.CustomerID, C.CompanyName, OD.OrderID
--Having Sum(OD.UnitPrice*OD.Quantity) >= 10000
--Order by 4 desc;

--33. Do the same query, instead of looking at orders with an order over 10k, look at customers with overall order sum over 15k for the year.
--Select C.CustomerID, C.CompanyName, Sum(OD.UnitPrice*OD.Quantity) as TotalOrderAmount
--From OrderDetails OD
--Join Orders O
--on OD.OrderID = O.OrderID
--Join Customers C
--on O.CustomerID = C.CustomerID
--Where Year(O.OrderDate) = 2016
--Group by C.CustomerID, C.CompanyName
--Having Sum(OD.UnitPrice*OD.Quantity) >= 15000
--Order by 3 desc;

--34. Same query, just calculate based on discounted total order amount
--Select C.CustomerID, C.CompanyName, Sum(OD.UnitPrice*OD.Quantity) as TotalOrderAmount, Sum(OD.UnitPrice*OD.Quantity*(1-OD.Discount)) as DiscountedTotalOrderAmount
--From OrderDetails OD
--Join Orders O
--on OD.OrderID = O.OrderID
--Join Customers C
--on O.CustomerID = C.CustomerID
--Where Year(O.OrderDate) = 2016
--Group by C.CustomerID, C.CompanyName
--Having Sum(OD.UnitPrice*OD.Quantity*(1-OD.Discount)) >= 15000
--Order by 4 desc;

--35. Show all orders made on the last day of the month, Order by EmployeeId and OrderID
--Select O.EmployeeID, O.OrderID, O.OrderDate
--From Orders O
--Where Cast(OrderDate as Date) = EOMONTH(Cast(OrderDate as Date))
--Order by 1,2;

--36. Show orders with most line items
--Select Top 10 OD.OrderID, Count(*) as NumLineItems
--From OrderDetails OD
--Group by OD.OrderID
--Order by 2 Desc;

--37. Get a Random Set of 2% of all Orders
--Select Top 2 percent OrderID
--From Orders
--Order by NewID()

-- 38. Find orders with a line item of same quantity, where quantity is greater than or equal to 60.
--Select Small.OrderID
--From 
--	(Select OrderID, Quantity, Count(Quantity) as Counted
--	From OrderDetails
--	Where Quantity >= 60
--	Group by OrderID, Quantity
--	Having Count(Quantity) >1) as Small;

--INCOMPLETE--
-- 39. Above but with details for those orderIDs,  using common table expressions - https://technet.microsoft.com/en-us/library/ms175972.aspx
--Select distinct OD.*
--From OrderDetails OD
--JOIN
--	(Select OrderID, Quantity, Count(Quantity) as Counted
--	From OrderDetails
--	Where Quantity >= 60
--	Group by OrderID, Quantity
--	Having Count(Quantity) >1) as Small 
--ON Small.OrderID = OD.OrderID;

-- 40. Above but with details for those orderIDs, using a derived table
--Select distinct OD.*
--From OrderDetails OD
--JOIN
--	(Select OrderID, Quantity, Count(Quantity) as Counted
--	From OrderDetails
--	Where Quantity >= 60
--	Group by OrderID, Quantity
--	Having Count(Quantity) >1) as Small 
--ON Small.OrderID = OD.OrderID;

