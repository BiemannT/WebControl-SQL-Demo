-- Select all users created in this database.
-- Optionally only the active users will be replied, if the parameter @ActiveOnly is set true.

CREATE PROCEDURE [dbo].[SEL_Users] @ActiveOnly AS BIT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		[u].[ID]
	   ,[u].[LoginName]
	   ,[u].[FirstName]
	   ,[u].[LastName]
	   ,[u].[Department]
	   ,[u].[LoginActive]
	   ,[u].[LoginBlocked]
	FROM [dbo].[Users] [u]
	WHERE [u].[LoginActive] = 1
	OR [u].[LoginActive] = @ActiveOnly
	ORDER BY [u].[LoginName] ASC;

END