CREATE TABLE [dbo].[Errors] (
	[Code] INT NOT NULL
   ,[ObjType] NCHAR(3) NOT NULL
   ,[ObjName] VARCHAR(255) NOT NULL
   ,[Message_en] VARCHAR(MAX) NOT NULL
   ,[Message_de] VARCHAR(MAX) NULL
   ,CONSTRAINT [PK_Errors] PRIMARY KEY CLUSTERED ([Code]) ON [DEFAULT]
   ,CONSTRAINT [CK_Errors_ObjType] CHECK ([ObjType] = 'spr' OR [ObjType] = 'trg')
) ON [DEFAULT];
