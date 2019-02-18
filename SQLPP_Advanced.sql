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

-- 39. Above but with details for those orderIDs,  using common table expressions - https://technet.microsoft.com/en-us/library/ms175972.aspx
--With Small (OrderID,Quantity,Counted) as
--	(Select OrderID, Quantity, Count(Quantity) as Counted
--	From OrderDetails
--	Where Quantity >= 60
--	Group by OrderID, Quantity
--	Having Count(Quantity) >1)
--Select distinct OD.*
--From OrderDetails OD
--Join Small
--ON OD.OrderID = Small.OrderID;

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

-- 41. Find the orders arriving late. Sort by OrderID. Columns OrderID, OrderDate, RequiredDate,
-- ShippedDate.
--Select O.OrderID, O.OrderDate, O.RequiredDate, O.ShippedDate
--From Orders O
--Where O.ShippedDate >= O.RequiredDate;

-- 42. Salespeople with the most late orders.
--Select O.EmployeeID, E.LastName, Count(O.OrderID) as NumLate
--From Orders O
--Join Employees E
--ON O.EmployeeID = E.EmployeeID
--Where O.ShippedDate >= O.RequiredDate
--Group by O.EmployeeID, E.LastName
--Order by 3 desc;

-- 43. Salespeople with most late orders, and number of their total orders, and show null row. Use CTE.

--With AllData (EmployeeID, LastName, TotalOrders) as
--		(Select O.EmployeeID, E.LastName, Count(O.OrderID) as AllOrders
--		From Orders O
--		Join Employees E
--		ON O.EmployeeID = E.EmployeeID
--		Group by O.EmployeeID, E.LastName),
--	LateData (EmployeeID, LastName, LateOrders) as
--		(Select O.EmployeeID, E.LastName, Count(O.OrderID) as LateOrders
--		From Orders O
--		Join Employees E
--		ON O.EmployeeID = E.EmployeeID
--		Where O.ShippedDate >= O.RequiredDate
--		Group by O.EmployeeID, E.LastName)
--Select AllData.*, LateData.LateOrders
--From AllData
--Join LateData
--ON AllData.EmployeeID = LateData.EmployeeID
--Order by 1;

-- 44. Salespeople with most late orders, and number of their total orders, and show null row.
--Select O.EmployeeID, E.LastName, Count(O.OrderID) as AllOrders, LateData.LateOrders
--From Orders O
--Join Employees E
--ON O.EmployeeID = E.EmployeeID
--Left Join
--	(Select O.EmployeeID, E.LastName, Count(O.OrderID) as LateOrders
--	From Orders O
--	Join Employees E
--	ON O.EmployeeID = E.EmployeeID
--	Where O.ShippedDate >= O.RequiredDate
--	Group by O.EmployeeID, E.LastName) LateData
--On O.EmployeeID =LateData.EmployeeID
--Group by O.EmployeeID, E.LastName, LateData.LateOrders
--Order by 1;

 --45. Now do the same, but replace the null with 0.
--With AllData (EmployeeID, LastName, TotalOrders) as
--		(Select O.EmployeeID, E.LastName, Count(O.OrderID) as AllOrders
--		From Orders O
--		Join Employees E
--		ON O.EmployeeID = E.EmployeeID
--		Group by O.EmployeeID, E.LastName),
--	LateData (EmployeeID, LastName, LateOrders) as
--		(Select O.EmployeeID, E.LastName, Count(O.OrderID) as LateOrders
--		From Orders O
--		Join Employees E
--		ON O.EmployeeID = E.EmployeeID
--		Where O.ShippedDate >= O.RequiredDate
--		Group by O.EmployeeID, E.LastName)
--Select AllData.*, IsNull(LateData.LateOrders,0) as LateOrders
--From AllData
--Left Join LateData
--ON AllData.EmployeeID = LateData.EmployeeID
--Order by 1;

--46. Now calculate Late as Percent of Total.
--With AllData (EmployeeID, LastName, TotalOrders) as
--		(Select O.EmployeeID, E.LastName, Count(O.OrderID) as AllOrders
--		From Orders O
--		Join Employees E
--		ON O.EmployeeID = E.EmployeeID
--		Group by O.EmployeeID, E.LastName),
--	LateData (EmployeeID, LastName, LateOrders) as
--		(Select O.EmployeeID, E.LastName, Count(O.OrderID) as LateOrders
--		From Orders O
--		Join Employees E
--		ON O.EmployeeID = E.EmployeeID
--		Where O.ShippedDate >= O.RequiredDate
--		Group by O.EmployeeID, E.LastName)
--Select AllData.*, IsNull(LateData.LateOrders,0) as LateOrders, IsNull((Cast(LateOrders as Float) / AllData.TotalOrders),0) as PercentLate
--From AllData
--Left Join LateData
--ON AllData.EmployeeID = LateData.EmployeeID
--Order by 1;

-- 47. Now calculate Late as Percent of Total, and keep only first 2 decimals.
--With AllData (EmployeeID, LastName, TotalOrders) as
--		(Select O.EmployeeID, E.LastName, Count(O.OrderID) as AllOrders
--		From Orders O
--		Join Employees E
--		ON O.EmployeeID = E.EmployeeID
--		Group by O.EmployeeID, E.LastName),
--	LateData (EmployeeID, LastName, LateOrders) as
--		(Select O.EmployeeID, E.LastName, Count(O.OrderID) as LateOrders
--		From Orders O
--		Join Employees E
--		ON O.EmployeeID = E.EmployeeID
--		Where O.ShippedDate >= O.RequiredDate
--		Group by O.EmployeeID, E.LastName)
--Select AllData.*, IsNull(LateData.LateOrders,0) as LateOrders,
--	IsNull(Cast(Cast(LateOrders as Float) / AllData.TotalOrders as Decimal(16,2)),0) as PercentLate
--From AllData
--Left Join LateData
--ON AllData.EmployeeID = LateData.EmployeeID
--Order by 1;

--- VALUABLE - when things get hairy with theoreticals and functions,
--- use an actual value to help you debug)
--Select Cast(Cast(3 as Float) / 123 as Decimal(16,2));

-- 48. Organize customers into groups based on how much they ordered in spend in 2016. Groups are 0-1000,1000-5000,
-- 5000-10000, and 10000+. Identify them as Low, Medium, High, and Very High. Ignore customers who ordered
-- 0 in 2016. Columns desired: CustomerID, CompanyName, Total Order Amount, Customer Group

--With TotalData (CustomerID, TotalOrderAmount) as
--	(Select O.CustomerID
--		,Sum(OD.UnitPrice*Quantity) as TotalOrderAmount
--	From Orders O
--	JOIN OrderDetails OD
--	on O.OrderID = OD.OrderID
--	Where Year(OrderDate) = 2016
--	Group by O.CustomerID)
--Select TotalData.CustomerID
--	, TotalData.TotalOrderAmount
--	,(Case when TotalData.TotalOrderAmount < 1000 then 'Low'
--	when TotalData.TotalOrderAmount < 5000 then 'Medium'
--	when TotalData.TotalOrderAmount < 10000 then 'High'
--	when TotalData.TotalOrderAmount >= 10000 then 'Very High'
--	End) as CustomerGroup
--From TotalData;

--49. Freebie (Using Between creates nulls for the integers that mark the boundaries between groups and
-- using boolean operators doesn't. We solved it most efficiently and so didn't have any null value).

--50. Rework the top, Get a count of customers in each group, and calculate the percent of customers
-- in each group.
--With TotalData (CustomerID, TotalOrderAmount) as
--	(Select O.CustomerID
--		,Sum(OD.UnitPrice*Quantity) as TotalOrderAmount
--	From Orders O
--	JOIN OrderDetails OD
--	on O.OrderID = OD.OrderID
--	Where Year(OrderDate) = 2016
--	Group by O.CustomerID)
--Select (Case when TotalData.TotalOrderAmount < 1000 then 'Low'
--	when TotalData.TotalOrderAmount < 5000 then 'Medium'
--	when TotalData.TotalOrderAmount < 10000 then 'High'
--	when TotalData.TotalOrderAmount >= 10000 then 'Very High'
--	End) as CustomerGroup
--	, Count(TotalData.CustomerID) as TotalInGroup
--	, Cast(Count(TotalData.CustomerID) as Float)/(Select Count(*) from TotalData) as PercentInGroup
--From TotalData
--Group by (Case when TotalData.TotalOrderAmount < 1000 then 'Low'
--	when TotalData.TotalOrderAmount < 5000 then 'Medium'
--	when TotalData.TotalOrderAmount < 10000 then 'High'
--	when TotalData.TotalOrderAmount >= 10000 then 'Very High'
--	End)
--Order by 2 Desc;

-- 51. Do the top but use table CustomerGroupThresholds, to define the categories.

Select *
From CustomerGroupThresholds;