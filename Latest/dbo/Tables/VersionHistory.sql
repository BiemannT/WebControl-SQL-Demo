CREATE TABLE [dbo].[VersionHistory] (
	[MajorVers] TINYINT NOT NULL
   ,[MinorVers] TINYINT NOT NULL
   ,[PatchVers] TINYINT NOT NULL
   ,[InstallDate] DATETIME2(3) CONSTRAINT [DF_VersionHistory_InstallDate] DEFAULT GETDATE() NOT NULL
) ON [DEFAULT];