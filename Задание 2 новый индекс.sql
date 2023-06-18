--Задание 2: новый индекс
CREATE INDEX NewCoolIndex ON Marketing.PostalCode (StateCode, PostalCode)
INCLUDE (Country);