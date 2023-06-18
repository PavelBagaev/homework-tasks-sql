--New index for the second task
CREATE INDEX NewCoolIndex ON Marketing.PostalCode (StateCode, PostalCode)
INCLUDE (Country);
