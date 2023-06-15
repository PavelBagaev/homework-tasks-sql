--Задача 6
--Вывести список сотрудников, непосредственный руководитель которых младше сотрудника и меньше работает в компании
--Столбцы: Имя руководителя | Дата приема руководителя на работу| Дата рождения руководителя |
--	| Имя сотрудника | Дата приема сотрудника на работу| Дата рождения сотрудника
--Поле имя выводить в формате 'Фамилия И.О.'
--Упорядочить по иерархии от директора вниз к рядовым сотрудникам
--Внутри одного уровня иерархии упорядочить по фамилии руководителя, затем по фамилии сотрудника

WITH Employees AS (
	SELECT CONCAT(Person.LastName, ' ', SUBSTRING(Person.FirstName, 1, 1), '.', SUBSTRING(Person.MiddleName, 1, 1), '.', ' ') AS 'Full name of supervisor',
		   supervisor.HireDate AS 'Hire date of supervisor',
	       supervisor.BirthDate AS 'Birth date of supervisor',
	       supervisor.OrganizationNode,
		   supervisor.OrganizationLevel
	FROM HumanResources.Employee AS supervisor
	JOIN Person.Person AS person
		ON person.BusinessEntityID = supervisor.BusinessEntityID
)
select supervisor.[Full name of supervisor],
	   supervisor.[Hire date of supervisor],
	   supervisor.[Birth date of supervisor],
	   CONCAT(person.LastName, ' ', SUBSTRING(person.FirstName, 1, 1), '.', SUBSTRING(person.MiddleName, 1, 1), '.', ' ') AS 'Full name of subordinate',
	   subordinate.HireDate AS 'Hire date of subordinate',
	   subordinate.BirthDate AS 'Birth date of subordinate'
FROM Employees AS supervisor
JOIN HumanResources.Employee AS subordinate
ON subordinate.OrganizationNode.GetAncestor(1) = supervisor.OrganizationNode
JOIN Person.Person AS person
ON person.BusinessEntityID = subordinate.BusinessEntityID
WHERE supervisor.[Birth date of supervisor] > subordinate.BirthDate AND supervisor.[Hire date of supervisor] > subordinate.HireDate
ORDER BY supervisor.OrganizationLevel, [Full name of supervisor], [Full name of subordinate];
