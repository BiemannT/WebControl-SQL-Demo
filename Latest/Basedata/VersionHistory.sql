-- Write current DACPAC-version into the table VersionHistory:

INSERT INTO [dbo].[VersionHistory] ([MajorVers], [MinorVers], [PatchVers])
	VALUES (1, 1, 0);