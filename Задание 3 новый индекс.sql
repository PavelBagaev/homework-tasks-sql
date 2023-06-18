--Задание 3: новые индексы
CREATE INDEX NewCoolIndex1 ON Marketing.Prospect (LastName)
INCLUDE (FirstName);

CREATE INDEX NewCoolIndex2 ON Marketing.Salesperson (LastName);