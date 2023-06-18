--New index for the first task
CREATE INDEX NewCoolIndex ON Marketing.WebLog (SessionStart, ServerID)
INCLUDE (SessionID, UserName);
