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
SELECT fo.FirstOrderDate, person.LastName, person.FirstName,
       STUFF((
           SELECT CONCAT(' ', product.Name, ' Quantity: ', sod.OrderQty, ' item(s)', CHAR(13) + CHAR(10))
           FROM Sales.SalesOrderHeader AS soh
           JOIN Sales.SalesOrderDetail AS sod
		   ON soh.SalesOrderID = sod.SalesOrderID
           JOIN Production.Product AS product
		   ON sod.ProductID = product.ProductID
           WHERE soh.CustomerID = fo.CustomerID AND soh.OrderDate = fo.FirstOrderDate
           FOR XML PATH(''), TYPE
       ).value('.', 'NVARCHAR(MAX)'), 1, 1, '') AS OrderContents
FROM FirstOrder AS fo
JOIN Sales.SalesOrderHeader AS soh
ON fo.CustomerID = soh.CustomerID AND fo.FirstOrderDate = soh.OrderDate
JOIN Sales.SalesOrderDetail AS sod
ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product AS product
ON sod.ProductID = product.ProductID
JOIN Person.Person AS person
ON fo.CustomerID = person.BusinessEntityID
ORDER BY fo.FirstOrderDate DESC;




