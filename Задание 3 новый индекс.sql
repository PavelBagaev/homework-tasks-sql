--������� 3: ����� �������
CREATE INDEX NewCoolIndex1 ON Marketing.Prospect (LastName)
INCLUDE (FirstName);

CREATE INDEX NewCoolIndex2 ON Marketing.Salesperson (LastName);