CREATE TABLE [dbo].[Users] (
	[ID] INT IDENTITY (1, 1) NOT NULL
   ,[LoginName] VARCHAR(50) NOT NULL
   ,[LoginPwd] VARBINARY(MAX) NOT NULL
   ,[FirstName] VARCHAR(50) NULL
   ,[LastName] VARCHAR(50) NULL
   ,[Department] VARCHAR(50) NULL
   ,[LoginActive] BIT NOT NULL
   ,[LastSuccesfulLogin] DATETIME2(2) NULL
   ,[LastFailedLogin] DATETIME2(2) NULL
   ,[FailedLoginCounter] SMALLINT NOT NULL CONSTRAINT [DF_Users_FailedLoginCounter] DEFAULT 0
   ,[LoginBlocked] AS IIF([FailedLoginCounter] > 3, 1, 0)
   ,CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED ([ID]) ON [DEFAULT]
   ,INDEX [IX_Users] UNIQUE NONCLUSTERED ([LoginName] ASC) ON [DEFAULT]
) ON [DEFAULT];