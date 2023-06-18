--Задание 1: новый индекс
CREATE INDEX NewCoolIndex ON Marketing.WebLog (SessionStart, ServerID)
INCLUDE (SessionID, UserName);