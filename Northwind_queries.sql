
   -- 1. What is the undiscounted subtotal for each Order (identified by OrderID).
   select OrderID,
   SUM(UnitPrice * Quantity) as subtotal
   from [Order Details]
   GROUP BY OrderID

   -- 2. What products are currently for sale (not discontinued)?
   select *
   FROM Products p
   WHERE Discontinued = 0

    --3. What is the cost after discount for each order?  Discounts should be applied as a percentage off.
	select OrderID,
	SUM(UnitPrice * Quantity) as Subtotal,
   SUM((UnitPrice * Quantity) * (1 - Discount)) as DiscountedTotal
   from [Order Details]
   GROUP BY OrderID
    --4. I need a list of sales figures broken down by category name.  Include the total $ amount sold over all time and the total number of items sold.

select c.CategoryName,
SUM((od.UnitPrice * Quantity) * (1 - Discount)) as TotalRevenue,
SUM(Quantity) as TotalSold
from [Order Details] od
JOIN Products p
ON od.ProductID = p.ProductID
JOIN Categories c
ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryName

   -- 5. What are our 10 most expensive products?
select TOP(10) *
from Products
ORDER BY UnitPrice DESC

    --6. In which quarter in 1997 did we have the most revenue?

	SELECT SUM(CASE
			WHEN MONTH(o.OrderDate) BETWEEN 1 AND 3 THEN (od.UnitPrice * Quantity) * (1 - Discount)
			ELSE 0
			END) AS Q1,
	SUM(CASE
			WHEN MONTH(o.OrderDate) BETWEEN 4 AND 6 THEN (od.UnitPrice * Quantity) * (1 - Discount)
			ELSE 0
			END) AS Q2,
	SUM(CASE
			WHEN MONTH(o.OrderDate) BETWEEN 7 AND 9 THEN (od.UnitPrice * Quantity) * (1 - Discount)
			ELSE 0
			END) AS Q3,
	SUM(CASE
			WHEN MONTH(o.OrderDate) BETWEEN 10 AND 12 THEN (od.UnitPrice * Quantity) * (1 - Discount)
			ELSE 0
			END) AS Q4
	FROM Orders o
	JOIN [Order Details] od
	ON o.OrderID = od.OrderID
	WHERE YEAR(o.OrderDate) = 1997

    --7. Which products have a price that is higher than average?

	SELECT *
	FROM Products
	WHERE UnitPrice > (select AVG(UnitPrice)
				FROM Products)
	ORDER BY UnitPrice DESC
