--������� 1: ����� ������
CREATE INDEX NewCoolIndex ON Marketing.WebLog (SessionStart, ServerID)
INCLUDE (SessionID, UserName);