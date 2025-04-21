CREATE TABLE [dbo].[Errors]
(
	[Code] INT NOT NULL , 
    CONSTRAINT [CK_Errors_Code] CHECK (Code>=50000), 
    CONSTRAINT [PK_Errors] PRIMARY KEY ([Code])
)
