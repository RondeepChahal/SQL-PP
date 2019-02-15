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

-- *** INTERESTING PROBLEM ***
-- 24. Get list of Customers, sorted by region, alphabetically. At top, list customers with nothing in region and sort those by CustomerID.
--Select CustomerID, ContactName, Region
--From Customers
--Order by Case when Region IS Null then 1 Else 0 End,3,2;

-- 25. 