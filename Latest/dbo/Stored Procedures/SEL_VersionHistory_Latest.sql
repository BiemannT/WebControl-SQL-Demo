-- Ruft die zuletzt installierte DACPAC-Version ab.

CREATE PROCEDURE [dbo].[SEL_VersionHistory_Latest]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT TOP (1)
		[vh].[MajorVers]
	   ,[vh].[MinorVers]
	   ,[vh].[PatchVers]
	   ,[vh].[InstallDate]

	FROM [dbo].[VersionHistory] [vh]
	ORDER BY [vh].[InstallDate] DESC;

END;