--������� 2: ����� ������
CREATE INDEX NewCoolIndex ON Marketing.PostalCode (StateCode, PostalCode)
INCLUDE (Country);