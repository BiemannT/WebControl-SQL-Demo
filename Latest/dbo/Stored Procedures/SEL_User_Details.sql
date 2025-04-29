-- Select detail information on one user-id from this database.
-- If no recordset is returned, the requested ID doesn't exist.

CREATE PROCEDURE [dbo].[SEL_User_Details] @ID AS INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		[u].[LoginName]
	   ,[u].[FirstName]
	   ,[u].[LastName]
	   ,[u].[Department]
	   ,[u].[LoginActive]
	   ,[u].[LastSuccesfulLogin]
	   ,[u].[LastFailedLogin]
	   ,[u].[LoginBlocked]
	FROM [dbo].[Users] [u]
	WHERE [u].[ID] = @ID;

END