-- If the dacpac is already deployed to the server, check if the actual installed version is suitable for the new version.
-- Throw an error if the new version isn't compatible to the installed version, because a post-deployment script of a previous version has to be performed before.

DECLARE @OldVersion AS NVARCHAR(64);

SELECT
	@OldVersion = [si].[type_version]
FROM [msdb].[dbo].[sysdac_instances] [si]
WHERE [si].[database_name] = '$(DatabaseName)';

--IF @OldVersion IN ('1.0.0.0')
--	THROW 50000, 'The actual database version is not compatible with this package version. Update the database prior to version 0.1.0.0', 1;