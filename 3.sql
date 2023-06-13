--Задача 3
--Выбрать 10 самых приоритетных городов для следующего магазина
--Столбцы: Город | Приоритет
--Приоритет определяется как количество покупателей в городе
--В городе не должно быть магазина

SELECT TOP 10 
City, COUNT(CustomerID) AS 'Priority'
FROM Sales.SalesOrderHeader AS soh
JOIN Person.Address AS address
ON soh.ShipToAddressID = address.AddressID
WHERE City NOT IN (
	SELECT City
	FROM Sales.vStoreWithAddresses
	)
GROUP BY City
ORDER BY [Priority] DESC;