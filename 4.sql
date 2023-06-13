--Задача 4
--Выбрать покупателей, купивших больше 15 единиц одного и того же продукта за все время работы компании.
--Столбцы: Фамилия покупателя | Имя покупателя | Название продукта | Количество купленных экземпляров (за все время) 
--Упорядочить по количеству купленных экземпляров по убыванию, затем по полному имени покупателя по возрастанию

SELECT person.FirstName, person.LastName, product.Name, COUNT(soh.SalesOrderID) AS 'Products bought'
FROM Production.Product AS product
JOIN Sales.SalesOrderDetail AS sod
ON sod.ProductID = product.ProductID
JOIN Sales.SalesOrderHeader AS soh
ON soh.SalesOrderID = sod.SalesOrderID
JOIN Sales.Customer AS customer
ON soh.CustomerID = customer.CustomerID
JOIN Person.Person AS person
ON customer.PersonID = person.BusinessEntityID
GROUP BY person.FirstName, person.LastName, product.Name
HAVING COUNT(soh.SalesOrderID) > 15
ORDER BY COUNT(soh.SalesOrderID) DESC;