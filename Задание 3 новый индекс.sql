--New indices for the third task
CREATE INDEX NewCoolIndex1 ON Marketing.Prospect (LastName)
INCLUDE (FirstName);

CREATE INDEX NewCoolIndex2 ON Marketing.Salesperson (LastName);
