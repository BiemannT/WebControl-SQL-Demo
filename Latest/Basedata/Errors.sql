-- Fill Errors-Table
DECLARE @tmp AS TABLE (
	Code INT NOT NULL
   ,ObjType CHAR(3) NOT NULL
   ,ObjName VARCHAR(255) NOT NULL
   ,Message_en VARCHAR(MAX) NOT NULL
   ,Message_de VARCHAR(MAX) NULL
);

INSERT INTO @tmp ([Code], [ObjType], [ObjName], [Message_en], [Message_de])
	VALUES (50000, 'spr', 'INS_User', 'The minimum required length of the encryption phrase is 8 characters!', 'Die erforderliche Mindestlänge für die Passwortverschlüsselung beträgt 8 Zeichen!')
	, (50001, 'spr', 'INS_User', 'The selected Login Name already exists.', 'Der ausgewählte Benutzername existiert bereits.')
	, (50002, 'spr', 'UPD_User_details', 'The selected Login Name already exists.', 'Der ausgewählte Benutzername existiert bereits.')
	, (50003, 'spr', 'UPD_User_Pwd', 'The minimum required length of the encryption phrase is 8 characters!', 'Die erforderliche Mindestlänge für die Passwortverschlüsselung beträgt 8 Zeichen!')
	, (50004, 'trg', 'Users_BlockDirect', 'No direct modifications allowed on the users-table!', 'Es sind keine direkten Bearbeitungen in der Users-Tabelle erlaubt!');

MERGE [dbo].[Errors] AS t USING @tmp AS s
ON [t].[Code] = [s].[Code]
WHEN MATCHED
	THEN UPDATE
		SET [ObjType] = [s].[ObjType]
		   ,[ObjName] = [s].[ObjName]
		   ,[Message_en] = [s].[Message_en]
		   ,[Message_de] = [s].[Message_de]
WHEN NOT MATCHED BY TARGET
	THEN INSERT ([Code], [ObjType], [ObjName], [Message_en], [Message_de])
			VALUES ([s].[Code], [s].[ObjType], [s].[ObjName], [s].[Message_en], [s].[Message_de])
WHEN NOT MATCHED BY SOURCE
	THEN DELETE;