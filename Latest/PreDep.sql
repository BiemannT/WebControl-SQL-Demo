-- If the dacpac is already deployed to the server, check if the actual installed version is suitable for the new version.
-- Throw an error if the new version isn't compatible to the installed version, because a post-deployment script of a previous version has to be performed before.

DECLARE @OldVersion AS NVARCHAR(64);
DECLARE @OldVer1 AS INT;
DECLARE @OldVer2 AS INT;
DECLARE @OldVer3 AS INT;
DECLARE @OldVer4 AS INT;

SELECT
	@OldVersion = [si].[type_version]
FROM [msdb].[dbo].[sysdac_instances] [si]
WHERE [si].[database_name] = '$(DatabaseName)';

-- The dacpac version number is expected in the following form: "x.x.x.x", where "x" is a number.
-- Split the given string of the old version to enable easier version comparisons.
WITH OldVers (vers1, vers2, vers3, vers4)
AS
(SELECT
		[1]
	   ,[2]
	   ,[3]
	   ,[4]
	FROM (SELECT
			ROW_NUMBER() OVER (ORDER BY (SELECT
					NULL)
			) AS ord
		   ,value
		FROM STRING_SPLIT(@OldVersion, '.')) AS [s]
	PIVOT (MIN([s].[value]) FOR [s].[ord] IN ([1], [2], [3], [4])) AS VersTab)

SELECT
	@OldVer1 = CONVERT(INT, [vers1])
   ,@OldVer2 = CONVERT(INT, [vers2])
   ,@OldVer3 = CONVERT(INT, [vers3])
   ,@OldVer4 = CONVERT(INT, [vers4])
FROM [OldVers];

-- Perform the version comparison based on the OldVersion string, or the individual version values.
-- If the 'DatabaseName' is not available on the SQL-Server, all values are NULL.

--IF @OldVersion IN ('1.0.0.0')
--	THROW 50000, 'The actual database version is not compatible with this package version. Update the database prior to version 0.1.0.0', 1;