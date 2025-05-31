-- If the dacpac is already deployed to the server, check if the actual installed version is suitable for the new version.
-- Throw an error if the new version isn't compatible to the installed version, because a post-deployment script of a previous version has to be performed before.

-- Check first, if the database is already installed and VersionHistory table is available

DECLARE @Major AS TINYINT;
DECLARE @Minor AS TINYINT;
DECLARE @Patch AS TINYINT;

IF OBJECT_ID('[$(DatabaseName)].[dbo].[VersionHistory]') IS NOT NULL
BEGIN
	SELECT TOP (1)
		@Major = [MajorVers]
	   ,@Minor = [MinorVers]
	   ,@Patch = [PatchVers]
	FROM [$(DatabaseName)].[dbo].[VersionHistory]
	ORDER BY [InstallDate] DESC;

	-- Check last version if update is applicable
	IF ISNULL(@Major, 0) <= 1
		AND ISNULL(@Minor, 0) <= 0
		AND ISNULL(@Patch, 0) < 0

		THROW 50000, 'The actual database version is not compatible with this package version. Update the database prior to version 1.0.0', 1;

END;