--Задача 2
--Вывести общую сумму продаж с разбивкой по годам и месяцам, за все время работы компании

SELECT YEAR(OrderDate) AS 'Год', MONTH(OrderDate) AS 'Месяц', SUM(TotalDue) AS 'Заработок за период'
FROM Sales.SalesOrderHeader
WHERE Status = 5
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY [Год], [Месяц];
