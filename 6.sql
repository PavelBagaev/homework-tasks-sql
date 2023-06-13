--Задача 6
--Вывести список сотрудников, непосредственный руководитель которых младше сотрудника и меньше работает в компании
--Столбцы: Имя руководителя | Дата приема руководителя на работу| Дата рождения руководителя |
--	| Имя сотрудника | Дата приема сотрудника на работу| Дата рождения сотрудника
--Поле имя выводить в формате 'Фамилия И.О.'
--Упорядочить по иерархии от директора вниз к рядовым сотрудникам
--Внутри одного уровня иерархии упорядочить по фамилии руководителя, затем по фамилии сотрудника

WITH Employees (FullNameOfSubordinate,
				HireDateOfSubordinate,
				BirthDateOfSubordinate,
				OrganizationNodeOfSubordinate) AS (
	SELECT CONCAT(Person.LastName, ' ', SUBSTRING(Person.FirstName, 1, 1), '.', SUBSTRING(Person.MiddleName, 1, 1), '.', ' ') AS FullNameOfSupervisor,
		   Subordinate.HireDate AS HireDateOfSupervisor,
	       Subordinate.BirthDate AS BirthDateOfSupervisor,
	       Subordinate.OrganizationNode
	FROM HumanResources.Employee AS Subordinate
	JOIN Person.Person AS Person
		ON Person.BusinessEntityID = Subordinate.BusinessEntityID
)
select CONCAT(Person.LastName, ' ', SUBSTRING(Person.FirstName, 1, 1), '.', SUBSTRING(Person.MiddleName, 1, 1), '.', ' ') AS FullNameOfSupervisor,
	   Supervisor.HireDate AS HireDateOfSupervisor,
	   Supervisor.BirthDate AS BirthDateOfSupervisor,
	   EH.FullNameOfSubordinate,
	   EH.HireDateOfSubordinate,
	   EH.BirthDateOfSubordinate
FROM HumanResources.Employee AS Supervisor
JOIN Person.Person AS Person
	ON Person.BusinessEntityID = Supervisor.BusinessEntityID
JOIN Employees AS EH
	ON EH.OrganizationNodeOfSubordinate.GetAncestor(1) = Supervisor.OrganizationNode OR Supervisor.OrganizationNode IS NULL
WHERE Supervisor.BirthDate > EH.BirthDateOfSubordinate AND Supervisor.HireDate > EH.HireDateOfSubordinate
ORDER BY Supervisor.OrganizationLevel, EH.OrganizationNodeOfSubordinate, FullNameOfSupervisor, EH.FullNameOfSubordinate;
GO