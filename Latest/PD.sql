SET XACT_ABORT ON;
-- Old version number
DECLARE @OldMajorVersion AS TINYINT;
DECLARE @OldMinorVersion AS TINYINT;
DECLARE @OldPatchVersion AS TINYINT;

SELECT TOP (1)
	@OldMajorVersion = [vh].[MajorVersion]
   ,@OldMinorVersion = [vh].[MinorVersion]
   ,@OldPatchVersion = [vh].[PatchVersion]
FROM [dbo].[VersionHistory] [vh]
ORDER BY [vh].[InstallDate] DESC;

-- New version number
DECLARE @NewMajorVersion AS TINYINT;
DECLARE @NewMinorVersion AS TINYINT;
DECLARE @NewPatchVersion AS TINYINT;

SET @NewMajorVersion = 1;
SET @NewMinorVersion = 2;
SET @NewPatchVersion = 0;

-- Write Basic-Data

-- Errors-Table
:R..\Latest\Basedata\Errors.sql

-- Database post-deploy update-script
-- The pre-check of the required minimum version is already done in the pre-deployment script.
-- Perform only the update-script, if an installation already exists with an older version.
IF ISNULL(@OldMajorVersion, @NewMajorVersion) <= @NewMajorVersion
	AND ISNULL(@OldMinorVersion, @NewMinorVersion) <= @NewMinorVersion
	AND ISNULL(@OldPatchVersion, @NewPatchVersion) < @NewPatchVersion
BEGIN
	PRINT 'Execute update script...';

	-- R: ..\Latest\Updates\xyz.sql

END;

-- Write current Databaseversion into the table VersionHistory
INSERT INTO [dbo].[VersionHistory] ([MajorVers], [MinorVers], [PatchVers])
	VALUES (@NewMajorVersion, @NewMinorVersion, @NewPatchVersion);