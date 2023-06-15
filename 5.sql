--Задача 5
--Вывести содержимое первого заказа каждого клиента
--Столбцы: Дата заказа | Фамилия покупателя | Имя покупателя | Содержимое заказа
--Упорядочить по дате заказа от новых к старым
--В ячейку содержимого заказа нужно объединить все элементы заказа покупателя в следующем формате:
--<Имя товара> Количество: <количество в заказе> шт.
--<Имя товара> Количество: <количество в заказе> шт.
--<Имя товара> Количество: <количество в заказе> шт.
--...

WITH FirstOrder AS (
  SELECT CustomerID, MIN(OrderDate) AS FirstOrderDate
  FROM Sales.SalesOrderHeader
  GROUP BY CustomerID
)
SELECT FO.FirstOrderDate, person.LastName, person.FirstName,
       STUFF((
           SELECT CONCAT(' ', product.Name, ' Quantity: ', SOD.OrderQty, ' item(s)', CHAR(13) + CHAR(10))
           FROM Sales.SalesOrderHeader AS SOH
           JOIN Sales.SalesOrderDetail AS SOD
		   ON SOH.SalesOrderID = SOD.SalesOrderID
           JOIN Production.Product AS product
		   ON SOD.ProductID = product.ProductID
           WHERE SOH.CustomerID = FO.CustomerID AND SOH.OrderDate = FO.FirstOrderDate
           FOR XML PATH(''), TYPE
       ).value('.', 'NVARCHAR(MAX)'), 1, 1, '') AS 'Order contents'
FROM FirstOrder AS FO
JOIN Sales.Customer AS customer
ON FO.CustomerID = customer.CustomerID
JOIN Person.Person AS person
ON customer.PersonID = person.BusinessEntityID
ORDER BY FO.FirstOrderDate DESC;




