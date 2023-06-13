--Задача 7
--Написать хранимую процедуру, с тремя параметрами и результирующим набором данных 
--входные параметры - две даты, с и по 
--выходной параметр - количество найденных записей 
--Результирующий набор содержит записи всех холостых мужчин-сотрудников, родившихся в диапазон указанных в параметре дат

CREATE PROCEDURE SingleMales ( 
			--дата с
			@DateFrom DATE, 
			--дата по
			@DateTo DATE, 
			--количество записей
			@RecordCount INT OUTPUT 
			)
AS
	BEGIN
		--собираем в #TemporaryTable все записи холостых мужчин родившихся с  @DateFrom по @DateTo
		SELECT *
		INTO #TemporaryTable
		FROM HumanResources.Employee
		WHERE MaritalStatus = 'S' AND Gender = 'M' AND (BirthDate BETWEEN @DateFrom AND @DateTo)
		ORDER BY BirthDate DESC; 

		--заносим в переменную @RecordCount количество записей
		SELECT @RecordCount = COUNT(*)
		FROM #TemporaryTable;

		--сносим временную таблицу
		DROP TABLE #TemporaryTable;
	END   
GO


--вызываем процедуру и получаем количество записей
DECLARE @Count INT 
EXEC SingleMales '19500101', '19800101', @Count OUTPUT;
SELECT @Count AS NumberOfRecords

--сносим процедуру по необходимости :)
DROP PROCEDURE SingleMales