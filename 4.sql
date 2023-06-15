--Задача 4
--Выбрать покупателей, купивших больше 15 единиц одного и того же продукта за все время работы компании.
--Столбцы: Фамилия покупателя | Имя покупателя | Название продукта | Количество купленных экземпляров (за все время) 
--Упорядочить по количеству купленных экземпляров по убыванию, затем по полному имени покупателя по возрастанию

SELECT person.LastName AS 'First name', person.FirstName AS 'Last name', product.Name AS 'Name of the product', SUM(OrderQty) AS 'Products bought'
FROM Sales.SalesOrderHeader AS SOH
JOIN Sales.Customer AS customer
ON SOH.CustomerID = customer.CustomerID
JOIN Person.Person AS person
ON customer.PersonID = person.BusinessEntityID
JOIN Sales.SalesOrderDetail SOD
ON SOH.SalesOrderID = SOD.SalesOrderID
JOIN Production.Product AS product
ON SOD.ProductID = product.ProductID
GROUP BY person.LastName, person.FirstName, product.Name
HAVING SUM(OrderQty) > 15
ORDER BY [Products bought] DESC, person.LastName, person.FirstName;
